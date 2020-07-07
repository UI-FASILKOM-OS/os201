#!/bin/sh
# Print names of GitHub folders to sandbox-201.txt
# 
# Author: Wulan Mantiri 1806205666 OS B

[[ -f sandbox-201.txt ]] && echo -n "" > sandbox-201.txt || touch sandbox-201.txt

for DIR in ./../*
do
    [[ -d ${DIR} ]] && echo $DIR >> sandbox-201.txt
done

sed -i 's/\.\/\.\.\///' sandbox-201.txt
