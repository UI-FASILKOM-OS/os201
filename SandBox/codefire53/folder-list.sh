#!/bin/bash
# INFO : Mencari dan menuliskan semua nama folder di os201/SandBox
# Author : Mahardika Krisna Ihsani (codefire53)
FILE=sandbox-201.txt
[ -f $FILE ] && rm $FILE
touch $FILE
for folder in output $(ls -d ../*/ | sed "s/\.\.\///g" | sed "s/\///g")
    do
        echo $folder >> $FILE
    done
