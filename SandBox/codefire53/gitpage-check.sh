#!/bin/bash
# INFO : Memeriksa GitHub Pages ada atau tidak
# Author : Mahardika Krisna Ihsani (codefire53)

INPUT=sandbox-201.txt
OUTPUT=validation-result.txt
[-f $OUTPUT ] && rm $OUTPUT
touch $OUTPUT

cat $INPUT || while read USER
    do
        URL="https://$USER.github.io/os201/"
        [curl -s  "$URL" | grep "Site not found"] && echo "$USER 0" >> $OUTPUT;
        [curl -s  "$URL" | grep "Site not found"] || echo "$USER 1" >> $OUTPUT 
    done