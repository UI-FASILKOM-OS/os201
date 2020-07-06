#!/bin/bash

FILE="../GitHub-Pages-os201.txt"
echo -n '' > $FILE

for II in $(cat ../vanilla.txt)
do
    STATUS=$(curl -Is https://$II.github.io/os201/ | head -1 | cut -c 8-10 )
    printf '%-25s%s\n' "$II" "$STATUS"

    [ $STATUS == '200' ] && {
        printf '%-25s1\n' "$II" >> $FILE
    }  
    [ $STATUS == '200' ] || {
        printf '%-25s0\n' "$II" >> $FILE 
    }
done