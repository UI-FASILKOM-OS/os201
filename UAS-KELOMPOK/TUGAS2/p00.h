/*
// Mon Jun 22 15:48:14 WIB 2020
// Tue Jun  9 17:47:31 WIB 2020
*/

#define P00 "./p00"
#define P01 "./p01"
#define P02 "./p02"
#define P03 "./p03"

#include <fcntl.h>
#include <semaphore.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <wait.h>

#define AKUNSIZE     30
#define BOSS         0
#define NOTBOSS      1
#define CHMOD        0666
#define CLOSED       127
#define MAXPROGS     20
#define MUTEX        1
#define MYFLAGS      O_CREAT|O_RDWR
#define MYPROTECTION PROT_READ|PROT_WRITE
#define MYVISIBILITY MAP_SHARED
#define OPEN         255
#define SHAREMEM     "SharedMemoryFile.bin"
#define SYNC         0

typedef struct {
    char  akun [AKUNSIZE];
    int   stamp;
} usrinfo;

typedef struct {
    usrinfo progs[MAXPROGS+1];
    int     entry;
    int     state;
    int     mutexctr;
    sem_t   mutex;
} myshare;

void checkOpen(void);
void display(int entry);
int  getEntry(void);
int  init(void);
void myprint(char* str1, char* str2);
void putInfo(char* akun, int entry);

