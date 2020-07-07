#!/bin/bash
# INFO : Mengecek github page
# USAGE : ./gh-check.sh [FILE]


INFILE='sandbox-201.txt'
OUTFILE='GitHub-Pages-os201.txt'

if [[ -e $1 ]]; then
    INFILE=$1
fi

if [[ ! -e $INFILE ]]; then
    echo "$INFILE file not found"
    exit
fi

list=$(cat $INFILE)
res=''
for val in $list; do
    status=$(curl -s --head --request GET https://$val.github.io/os201/ | grep "HTTP" | cut -d ' ' -f 2)
    if [[ $status = '200' ]]; then
        res+=$(printf "%-20s 1" $val)
    else
        res+=$(printf "%-20s 0" $val)
    fi
    res+=$'\n'
done

echo "$res" > $OUTFILE
echo "File $OUTFILE telah dibuat dengan input dari $INFILE"