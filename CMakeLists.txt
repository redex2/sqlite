add_library(sqlite3 STATIC)

target_sources(sqlite3 PRIVATE
    sqlite3.c
    sqlite3.h
)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
find_package(Threads REQUIRED)
target_link_libraries(sqlite3 Threads::Threads)
target_link_libraries(sqlite3 ${CMAKE_DL_LIBS})