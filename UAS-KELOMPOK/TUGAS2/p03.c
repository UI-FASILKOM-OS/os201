/*
// Sun Jun 21 14:27:37 WIB 2020
// Tue Jun  9 17:46:47 WIB 2020
 */

// adjust DELAY and akunGitHub
#define  DELAY 3
#define  akunGitHub "fadhilibra"
#include "p00.h"

char*    progs[]={P01, P02, P03, P04, P05, P06};
myshare* mymap;

int init(void) {
    sleep(DELAY);
    int ssize=sizeof(myshare);
    int fd   =open(SHAREMEM, O_RDWR, CHMOD);
    fchmod   (fd, CHMOD);
    ftruncate(fd, ssize);
    mymap=mmap(NULL, ssize, MYPROTECTION, MYVISIBILITY, fd, 0);
    if (mymap == MAP_FAILED) {
        printf("No \"SharedMemoryFile.bin\" file.\n");
        exit(1);
    }
    close(fd);
    // blah blah blah
    return NOTBOSS;
}

char tmpStr[256]={};  // a temporary string.
void myprint(char* str1, char* str2) {
    printf("%s[%s]\n", str1, str2);
    // blah blah blah
    // blah blah blah
    // blah blah blah
}

int getEntry(void) {
    // get an entry number
    sem_wait(&(mymap -> mutex));
    int entry = mymap -> entry++;
    mymap -> progs[entry].stamp++;
    mymap -> mutexctr++;
    sem_post(&(mymap -> mutex));
    return entry;
}

void display(int entry) {
    // display an entry of MMAP.
    // eg. akunGH2[progs[03] TIME[18] MUTEX[05] MMAP[OPEN] [akunGH1][akunGH3][akunGH0][akunGH2]]
    mymap -> mutexctr++;
    mymap -> progs[entry].stamp++;
    printf("%s[progs[%.2d] TIME[%.2d] MUTEX[%.2d] MMAP[%s] ",akunGitHub, entry ,mymap -> mutexctr , mymap -> progs[entry].stamp , "OPEN");

    for(int x = 0 ; x < mymap -> entry; x++){
        if(mymap -> progs[x].akun == NULL){
            printf("[]");
        }else{
            printf("[%s]",mymap -> progs[x].akun);
        }
    }

    printf("]\n");
}

void putInfo(char* akun, int entry) {
    // put "akunGitHub" into akun[] array (MMAP)
    sem_wait(&(mymap -> mutex));
    strcpy(mymap->progs[entry].akun, akun);
    mymap -> mutexctr++;
    mymap -> progs[entry].stamp++;
    sem_post(&(mymap -> mutex));
}

void checkOpen(void) {
    // exit if MMAP is closed.
    if (mymap -> state == CLOSED) {
        printf("CLOSED, BYE BYE ==== ====\n");
        exit(1);
    }
}

int main(void) {
    sprintf(tmpStr, "START PID[%d] PPID[%d]", getpid(), getppid());
    myprint(akunGitHub, tmpStr);
    int boss=init();
    checkOpen();
    sleep (DELAY);
    int entry = getEntry();
    display(entry);
    sleep(DELAY);
    putInfo(akunGitHub,entry);
    display(entry);
    sleep(DELAY);
    display(entry);
    // blah... blah... blah...
    // blah... blah... blah...
    // blah... blah... blah...
    myprint(akunGitHub, "BYEBYE =====  ===== =====");
}

