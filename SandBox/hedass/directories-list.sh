#!/bin/bash
# INFO : Mendaftarkan folder yang ada.
# USAGE : ./directories-list.sh [DIR]

DIR='..'
OUTFILE='sandbox-201.txt'

if [[ -e $1 ]]; then
    DIR = $1
fi

list=$(ls $DIR -l | grep ^d | cut -d ' ' -f9)

echo "$list" > $OUTFILE
echo "File $OUTFILE telah dibuat dengan input dari $DIR"