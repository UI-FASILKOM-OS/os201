#!/bin/bash
# check-folder.sh

DIR=$(ls -d ../*/ | sed -e 's/\///g' -e 's/\.\.//g')

[[ -e sandbox-201.txt ]] && rm -f sandbox-201.txt

touch sandbox-201.txt

for II in $DIR
do
echo $II >> sandbox-201.txt
done
