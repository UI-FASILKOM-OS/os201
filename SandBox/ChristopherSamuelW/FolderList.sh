#!/bin/bash
# INFO : Mencari dan menuliskan semua nama folder di os201/SandBox
# Author : Christopher Samuel (ChristopherSamuelW)

dirs=$(ls -d ../*/)
FILE=sandbox-201.txt
if [ -f $FILE ];
  then rm $FILE
fi

for dir_name in $dirs
do
  SIZE=${#dir_name}
  SIZE=$(($SIZE-2))
  echo ${dir_name:3} | cut -f1 -d"/" >> $FILE
done
