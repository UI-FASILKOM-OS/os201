#!/bin/sh
#
# Author :
# Glenda Emanuella Sutanto
# 1806133774 - OS B

DIRLIST=$(ls -d ../*/ | sed -e s/"\/"//g | sed -e s/".."//)

FILE="GitHub-Pages-os201.txt"

[[ -f $FILE ]] || touch $FILE

echo -n "" > $FILE

for DIR in $DIRLIST
do
url="https://$DIR.github.io/os201/"
if curl --output /dev/null --silent --head --fail "$url"; then
  echo "$DIR 1" >> $FILE
else
  echo "$DIR 0" >> $FILE
fi
done
