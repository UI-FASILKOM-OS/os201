#!/bin/bash
# GOAL      : Cek apakah user pada os201/Sandbox/ telah
#             membuat halaman github.io
# Author    : Iqrar Agalosi Nureyza (iqrar99)

FILESOURCE="sandbox-201.txt"
FILETARGET="GitHub-Pages-os201.txt"
USERS=$(cat $FILESOURCE)

touch tmp.txt

for USERNAME in $USERS
do
    URL="https://$USERNAME.github.io/os201/"
    if (curl -s $URL | grep 'Site not found');
    then
        echo "$USERNAME 0" >> tmp.txt
    else
        echo "$USERNAME 1" >> tmp.txt
    fi
done

mv tmp.txt $FILETARGET