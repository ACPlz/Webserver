#ifndef BLOCK_QUEUE_H
#define BLOCK_QUEUE_H
#include <iostream>
#include <pthread.h>
#include <sys/time.h>
#include <queue>
#include "locker.h"
using namespace std;

template<class T>
class block_queue {

public:
    block_queue(int max_size);
    ~block_queue();

    //清空阻塞队列
    void clear();

    //判断队列是否已满；
    bool full();

    //判断队列是否为空
    bool empty();

    //返回队首元素
    bool front(T &value);

    //返回队尾元素
    bool back(T &value);

    //获取队列大小
    int size();

    //获取队列最大容量
    int max_size();

    //向队列中放入元素
    bool push(const T &item);

    //弹出元素
    bool pop(T &item);

private:
    locker m_mutex;
    cond m_cond;
    
    queue<T> m_queue;
    int m_size;
    int m_max_size;
};

template<class T>
block_queue<T>::block_queue(int max_size) {
    if (max_size <= 0)
    {
        exit(-1);
    }

    m_max_size = max_size;
    m_size = 0;
}

template<class T>
block_queue<T>::~block_queue() {
        m_mutex.lock();
        while (!m_queue.empty()) m_queue.pop();
        m_mutex.unlock();
}

template<class T>
void block_queue<T>::clear() {
    m_mutex.lock();
    m_queue.clear();
    m_size = 0;
    m_mutex.unlock();
}

template<class T>
bool block_queue<T>::full() {
    m_mutex.lock();
    if (m_queue.size() >= m_max_size) {
        m_mutex.unlock();
        return true;
    }
    m_mutex.unlock();
    return false;    
}

template<class T>
bool block_queue<T>::empty() {
    m_mutex.lock();
    if (m_queue.empty()) {
        m_mutex.unlock();
        return true;
    }
    m_mutex.unlock();
    return false;    
}

template<class T>
bool block_queue<T>::front(T &value) {
    m_mutex.lock();
    if (m_queue.empty()) {
        m_mutex.unlock();
        return false;
    }
    value = m_queue.front();
    m_mutex.unlock();
    return true;
}

template<class T>
bool block_queue<T>::back(T &value) {
    m_mutex.lock();
    if (m_queue.empty()) {
        m_mutex.unlock();
        return false;
    }
    value = m_queue.back();
    m_mutex.unlock();
    return true;
}

template<class T>
int block_queue<T>::size() {
    int tmp = 0;
    m_mutex.lock();
    tmp = m_queue.size();
    m_mutex.unlock();
    return tmp;
}

template<class T>
int block_queue<T>::max_size() {
    int tmp = 0;
    m_mutex.lock();
    tmp = m_max_size;
    m_mutex.unlock();
    return tmp;
}

template<class T>
bool block_queue<T>::push(const T &item) {
    m_mutex.lock();
    if (m_queue.size() >= m_max_size) {
        m_cond.broadcast();
        m_mutex.unlock();
        return false;
    }
    m_queue.push(item);
    m_size++;
    m_cond.broadcast();
    m_mutex.unlock();
    return true;
}

template<class T>
bool block_queue<T>::pop(T &item) {
    m_mutex.lock();
    if (m_queue.size() <= 0) {
        if (!m_cond.wait(m_mutex.get()))
        {
            m_mutex.unlock();
            return false;
        }
    }
    item = m_queue.front();
    m_queue.pop();
    m_size--;
    m_mutex.unlock();
    return true;
}

#endif