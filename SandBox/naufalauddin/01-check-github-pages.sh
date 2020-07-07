#!/bin/bash

IFILE="sandbox-201.txt"
OFILE="GitHub-Pages-os201.txt"

[[ -f $IFILE ]] || ( echo "$IFILE didn't exist"; exit )

[[ -f $OFILE ]] && rm $OFILE

touch $OFILE

USER_LIST=$(cat $IFILE)

for username in $USER_LIST
do
    status=$(curl -o /dev/null -Isw '%{http_code}' -m 30 https://$username.github.io/os201/)
    if [[ status -ne 404 ]]
    then printf "%-25s 1\n" $username >> $OFILE
    else printf "%-25s 0\n" $username >> $OFILE
    fi
done
