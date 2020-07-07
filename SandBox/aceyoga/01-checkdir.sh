#!/bin/bash
# Author: Muhamad Yoga Mahendra (aceyoga) 
# 01-checkdir.sh 
# INFO:
# This script grabs all adjacent directory's name to 
# this script's current directory to sandbox-201.txt
# This script assumes that it is executed from 00-runall.sh.
#
# Version 0 (2020-04-07 01:45 AM UTC+7)
# Version 1 (2020-04-07 01:49 AM UTC+7)
#
# References: https://askubuntu.com/questions/994602/how-to-write-out-all-directory-names-into-a-text-file
#
# This is a Free Software, feel free to modify or use.

OUT="01-sandbox-201.txt"

[[ -e $OUT ]] && rm -f $OUT 
touch $OUT

for dir in ./../*
do
   echo checking "${dir##./../}"\'s directory existence
   [[ -d "$dir" ]] && echo "${dir##./../}" >> $OUT
done
