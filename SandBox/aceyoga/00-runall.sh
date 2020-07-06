#!/bin/bash
# Author: Muhamad Yoga Mahendra (aceyoga) 
# 00-runall.sh 
# INFO: this script executes all scripts in this folder.
#
# Version 0 (2020-04-07 01:45 AM UTC+7)
#
# Reference:  https://stackoverflow.com/questions/41079143/run-all-shell-scripts-in-folder
#             https://unix.stackexchange.com/questions/361655/find-a-file-matching-with-certain-pattern-and-giving-that-file-name-as-value-to
# 
# This is a Free Software, feel free to modify or use.

[[ -e sclist.txt ]] && rm -f sclist.txt 
find . -type f -iname "*check*" > sclist.txt

SCLIST=$(cat sclist.txt)

for f in $SCLIST
do
  echo running $f
  $f
  echo =============================================
done