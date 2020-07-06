#!/bin/bash
# INFO: generates GitHub page status from list of usernames
# USAGE: ./01-check-gh-pages.sh [FILE]

OFILE='GitHub-Pages-os201.txt'
IFILE='sandbox-201.txt'

if [[ -e $1 ]]; then
    IFILE=$1
elif [[ ! -e $IFILE ]]; then
    echo 'error: list file not found'
    exit -1
fi

list=$(cat $IFILE)
out=''
for username in $list; do
    out+=$(printf "%-21s" $username)

    status=$(curl -o /dev/null -Isw '%{http_code}' -m 300 https://$username.github.io/os201)
    [[ $? -ne 0 ]] && {
        echo 'error: curl failed'
        exit -1
    }

    [[ status -ne '404' ]] && out+='1' || out+='0'
    out+=$'\n'
done

echo -n "$out" > $OFILE
echo "File '$OFILE' generated from input '$IFILE'"
