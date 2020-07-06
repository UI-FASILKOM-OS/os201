#!/bin/bash
# INFO: generates list of directories on certain path
# USAGE: ./00-list-directories.sh [DIR]

OFILE='sandbox-201.txt'
[[ -d $1 ]] && IDIR=$1 || IDIR='..'

list=$(find $IDIR -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
echo "$list" > $OFILE
echo "File '$OFILE' generated from input '$IDIR'"
