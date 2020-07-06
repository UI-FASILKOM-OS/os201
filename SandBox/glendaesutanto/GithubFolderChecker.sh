#!/bin/sh
#
# Author :
# Glenda Emanuella Sutanto
# 1806133774 - OS B

DIRLIST=$(ls -d ../*/ | sed -e s/"\/"//g | sed -e s/".."//)

FILE="sandbox-201.txt"

[[ -f $FILE ]] || touch $FILE

echo -n "" > $FILE

for DIR in $DIRLIST
do
echo $DIR >> $FILE
done
