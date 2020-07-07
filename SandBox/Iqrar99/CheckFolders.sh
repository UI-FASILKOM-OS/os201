#!/bin/bash
# GOAL      : Cek semua folder yang ada pada os201/Sandbox/
# Author    : Iqrar Agalosi Nureyza (iqrar99)

DIRS=$(ls -d ../*/)
FILENAME='sandbox-201.txt'

for d in $DIRS
do
    echo $d | sed 's/\.\.\///g' | sed 's/\///g' >> tmp.txt
done

mv tmp.txt $FILENAME