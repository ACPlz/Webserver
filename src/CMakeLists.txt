aux_source_directory(. ALL_SRCS)

ADD_EXECUTABLE(webserver ${ALL_SRCS})

TARGET_LINK_LIBRARIES(webserver -lmysqlclient -lpthread -lm -lrt -latomic -lssl -lcrypto -ldl)

LINK_DIRECTORIES(/usr/lib/x86_64-linux-gnu)
