#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/epoll.h>
#include <signal.h>
#include <mysql/mysql.h>
#include "../inc/mysql_connection_pool.h"
#include "../inc/locker.h"
#include "../inc/threadpool.h"
#include "../inc/http_conn.h"
#include "../inc/log.h"

#define MAX_FD 65535 //最大文件描述符数
#define MAX_EVENT_NUMBER 10000 //监听的最大事件数
#define FD_LIMIT 65535
#define TIMESLOT 5
#define CLOSE_LOG 0 //日志关闭与开启
int m_close_log = CLOSE_LOG;

static int pipefd[2];
static sort_timer_lst timer_lst;
static int epollfd = 0;

connection_pool *m_connPool;
string m_user = "muyi";         //登陆数据库用户名
string m_passWord = "123456";     //登陆数据库密码
string m_databaseName= "signdb"; //使用数据库名
int m_sql_num = 8;

//设置非阻塞
extern int setnonblocking( int fd );

//添加文件描述符到epoll中
extern void addfd(int epollfd, int fd, bool one_shot);

//从epoll中删除文件描述符
extern void removefd(int epollfd, int fd);

//从epoll中修改文件描述符
extern void modfd(int epollfd, int fd, int ev);

//信号捕捉后的处理函数，将信号写入管道
void sig_handler( int sig )
{
    int save_errno = errno;
    int msg = sig;
    send( pipefd[1], ( char* )&msg, 1, 0 );
    errno = save_errno;
}

//添加信号捕捉
void addsig(int sig, void(handler)(int)) {
    struct sigaction sa;
    memset(&sa, '\0', sizeof(sa));
    sa.sa_handler = handler;
    sigfillset(&sa.sa_mask);
    sigaction(sig, &sa, NULL);
}

//信号捕捉2
void addsig(int sig) {
    struct sigaction sa;
    memset(&sa, '\0', sizeof(sa));
    sa.sa_handler = sig_handler;
    sa.sa_flags |= SA_RESTART;
    sigfillset( &sa.sa_mask );
    assert( sigaction( sig, &sa, NULL ) != -1 );
}

// 定时器回调函数，它删除非活动连接socket上的注册事件，并关闭之。
void cb_func( client_data* user_data )
{
    epoll_ctl( epollfd, EPOLL_CTL_DEL, user_data->sockfd, 0 );
    assert( user_data );
    LOG_INFO("%s", "A client disconnect");
    close( user_data->sockfd );
    printf( "close fd %d\n", user_data->sockfd );
}

void timer_handler()
{
    // 定时处理任务，实际上就是调用tick()函数
    timer_lst.tick();
    // 因为一次 alarm 调用只会引起一次SIGALARM 信号，所以我们要重新定时，以不断触发 SIGALARM信号。
    alarm(TIMESLOT);
}

int main(int argc, char* argv[]) {
    
    if (argc <= 1) {
        printf("按照如下格式运行：%s port_number\n", basename(argv[0]));
        exit(-1);
    }

    //获取端口号
    int port = atoi(argv[1]);

    //创建日志文件
    Log::get_instance()->init("../ServerLog/ServerLog", CLOSE_LOG, 2000, 800000, 800);

    //对SIGPIPE信号进行处理
    addsig(SIGPIPE, SIG_IGN);

    //数据库连接相关
    //初始化数据库连接池

    //创建一个数组用于保存客户端用户信息
    http_conn * users = new http_conn[MAX_FD];

    m_connPool = connection_pool::GetInstance();
    m_connPool->init("localhost", m_user, m_passWord, m_databaseName, 3306, m_sql_num, m_close_log);
     
    //初始化数据库读取表
    users->initmysql_result(m_connPool);

    //创建线程池，初始化线程池
    threadpool<http_conn>* pool = NULL;
    try {
        pool = new threadpool<http_conn>(m_connPool);
    } catch(...) {
        exit(-1);
    }
   

    //创建监听套接字
    int listenfd = socket(PF_INET, SOCK_STREAM, 0);

    //设置端口复用
    int reuse = 1;
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &reuse, sizeof(&reuse));

    //绑定
    struct sockaddr_in address;
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(port);
    bind(listenfd, (struct sockaddr*) &address, sizeof(address));

    //监听
    listen(listenfd, 5);

    //创建epoll对象
    epoll_event events[MAX_EVENT_NUMBER];
    int epollfd = epoll_create(5);

    //将监听的文件描述符添加到epoll对象中
    addfd(epollfd, listenfd, false);
    http_conn::m_epollfd = epollfd;

    // 创建管道
    socketpair(PF_UNIX, SOCK_STREAM, 0, pipefd);
    setnonblocking( pipefd[1] );
    addfd( epollfd, pipefd[0],false);

    // 设置信号处理函数
    addsig( SIGALRM );
    addsig( SIGTERM );
    bool stop_server = false;
    bool timeout = false;
    alarm(TIMESLOT);  // 定时,5秒后产生SIGALARM信号

    client_data* userstimer = new client_data[FD_LIMIT]; 
    while(true) {
        int num = epoll_wait(epollfd, events, MAX_EVENT_NUMBER, -1);
        if (num < 0 && errno != EINTR) {
            printf("epoll failure\n");
            break;
        }

        //循环遍历数组
        for (int i = 0; i < num; i++) {
            int sockfd = events[i].data.fd;

            if (sockfd == listenfd) {
                LOG_INFO("%s", "A new client is connecting");
                //表明有客户端链接
                struct sockaddr_in client_address;
                socklen_t client_addrlen = sizeof(client_address);
                int connfd = accept(listenfd, (struct sockaddr*)&client_address, &client_addrlen);
                
                if ( connfd < 0 ) {
                    printf( "errno is: %d\n", errno );
                    continue;
                } 

                if (http_conn::m_user_count >= MAX_FD) {
                    //连接数已满
                    //printf("Connect full\n");
                    close(connfd);
                    continue;
                }
                
                //将新的客户端初始化，放到数组中
                users[connfd].init(connfd, client_address, m_user, m_passWord, m_databaseName);

                LOG_INFO("%s", "A new client connected");
                // 创建定时器，设置其回调函数与超时时间，然后绑定定时器与用户数据，最后将定时器添加到链表timer_lst中
                userstimer[connfd].address = client_address;
                userstimer[connfd].sockfd = connfd;
                util_timer* timer = new util_timer;
                timer->user_data = &userstimer[connfd];
                timer->cb_func = cb_func;
                time_t cur = time( NULL );
                timer->expire = cur + 3 * TIMESLOT;
                userstimer[connfd].timer = timer;
                timer_lst.add_timer( timer );

            } else if( ( sockfd == pipefd[0] ) && ( events[i].events & EPOLLIN ) ) {
                // 处理信号
                int sig;
                char signals[1024];
                int ret = recv( pipefd[0], signals, sizeof( signals ), 0 );
                if( ret == -1 ) {
                    continue;
                } else if( ret == 0 ) {
                    continue;
                } else  {
                    for( int i = 0; i < ret; ++i ) {
                        switch( signals[i] )  {
                            case SIGALRM:
                            {
                                // 用timeout变量标记有定时任务需要处理，但不立即处理定时任务
                                // 这是因为定时任务的优先级不是很高，我们优先处理其他更重要的任务。
                                timeout = true;
                                break;
                            }
                            case SIGTERM:
                            {
                                stop_server = true;
                            }
                        }
                    }
                }
            } else if (events[i].events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)) {
                //对方异常断开或错误事件等
                util_timer* timer = userstimer[sockfd].timer;
                //if (timer) timer_lst.del_timer(timer);
                LOG_ERROR("%s", "Abnormal disconnection");
                users[sockfd].close_conn();
            } else if (events[i].events & EPOLLIN) {
                util_timer* timer = userstimer[sockfd].timer;
                if (users[sockfd].read()) {
                    if( timer ) {
                        time_t cur = time( NULL );
                        timer->expire = cur + 3 * TIMESLOT;
                        //printf( "adjust timer once\n" );
                        timer_lst.adjust_timer( timer );
                    }
                    pool->append(users + sockfd);
                } else {
                    //if (timer) timer_lst.del_timer(timer);
                    users[sockfd].close_conn();
                }
            } else if (events[i].events & EPOLLOUT) {
                util_timer* timer = userstimer[sockfd].timer;
                if (users[sockfd].write()) {
                    if( timer ) {
                        time_t cur = time( NULL );
                        timer->expire = cur + 3 * TIMESLOT;
                        //printf( "adjust timer once\n" );
                        timer_lst.adjust_timer( timer );
                    }
                } else {
                    //if (timer) timer_lst.del_timer(timer);
                    LOG_INFO("%s", "A client disconnect");
                    users[sockfd].close_conn();
                }
            }
        }
        if( timeout ) {

            timer_handler();
            timeout = false;
        }
    }

    close(epollfd);
    close(listenfd);
    delete [] users;
    delete pool;

    return 0;
}