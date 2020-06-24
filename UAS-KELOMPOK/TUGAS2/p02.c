/*
// Sun Jun 21 14:27:37 WIB 2020
// Tue Jun  9 17:46:47 WIB 2020
 */

// adjust DELAY and akunGitHub
#define  DELAY 3
#define  akunGitHub "akunGH2"
#include "p00.h"

char*    progs[]={P01, P02, P03};
myshare* mymap;

int init(void) {
    sleep(DELAY);
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
    int entry;
    // get an entry number
    return entry;
}

void display(int entry) {
    // display an entry of MMAP.
    // eg. akunGH2[progs[03] TIME[18] MUTEX[05] MMAP[OPEN] [akunGH1][akunGH3][akunGH0][akunGH2]]
}

void putInfo(char* akun, int entry) {
    // put "akunGitHub" into akun[] array (MMAP)
}

void checkOpen(void) {
    // exit if MMAP is closed.
}

int main(void) {
    sprintf(tmpStr, "START PID[%d] PPID[%d]", getpid(), getppid());
    myprint(akunGitHub, tmpStr);
    int boss=init();
    checkOpen();
    sleep (DELAY);
    // blah... blah... blah...
    // blah... blah... blah...
    // blah... blah... blah...
    myprint(akunGitHub, "BYEBYE =====  ===== =====");
}

