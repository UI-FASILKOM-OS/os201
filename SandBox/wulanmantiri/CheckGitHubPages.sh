#!/bin/sh
# Check if the existing folders in sandbox-201.txt 
# have GitHub pages with format
# https://{folder}.github.io/os201
# 
# Author: Wulan Mantiri 1806205666 OS B

FILENAME="GitHub-Pages-os201.txt"

[[ -f $FILENAME ]] && echo -n "" > $FILENAME || touch $FILENAME

for DIR in $(cat sandbox-201.txt)
do
    if curl --output /dev/null --silent --head --fail "https://${DIR}.github.io/os201/"
    then
        LOG="1"
    else
        LOG="0"
    fi
    echo "$DIR $LOG" >> $FILENAME
done
