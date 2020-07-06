#!/bin/bash
# INFO : Memeriksa GitHub Pages ada atau tidak
# Author : Christopher Samuel (ChristopherSamuelW)

FILE=sandbox-201.txt
OUTPUT=GitHub-Pages-os201.txt

if [ -f $OUTPUT ];
  then rm $OUTPUT
fi

cat $FILE | while read II
  do
    URL=https://$II.github.io/os201/
    if (curl -s  "$URL" | grep "Site not found");
    then
        echo "$II 0" >> $OUTPUT 
    else
        echo "$II 1" >> $OUTPUT 
    fi
  done