#!/bin/bash
# 00-CheckFolder.sh
# ============================================================================
# Author: Rafi Muhammad Daffa (skycruiser8)
#
# INFO:
# This script lists the directories inside the parent directory
# (above the current directory).
#
# VERSION:
# v0 (2020-03-29 12:12 UTC+7) - Initial commit
#
# This is free software :)

DIRLIST=$(ls -d ../*/ | sed -e 's/\///g' -e 's/\.\.//g')

[[ -e sandbox-201.txt ]] && rm -f sandbox-201.txt

touch sandbox-201.txt

for II in $DIRLIST
do
echo $II >> sandbox-201.txt
done

# EOF

