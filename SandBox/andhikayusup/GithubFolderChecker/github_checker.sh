#!/bin/bash

FILE="GitHub-Folder-os201.txt"
echo -n '' > $FILE

for II in $(cat ../vanilla.txt)
do
    [ -d ../../$II ] && {
        printf '%-25s1\n' "$II" >> $FILE
    }  
    [ -d ../../$II ] || {
        printf '%-25s0\n' "$II" >> $FILE 
    }
done

