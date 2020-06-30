# Sun Jun 21 19:00:55 WIB 2020
# Thu Jun 11 17:35:49 WIB 2020

CC      = gcc
SOURCES = $(wildcard *.c)
EXECS   = $(SOURCES:%.c=%)
SHAREMEM= SharedMemoryFile.bin
CFLAGS  = -std=gnu11 -pthread

.PHONY: all clean

all: $(EXECS)

$(EXECS): p00.h

clean:
	rm -f $(EXECS) $(SHAREMEM)

