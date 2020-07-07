#!/bin/bash

INITIALFILE="sandbox-201.txt"
TARGETFILE="GitHub-Pages-os201.txt"

[[ -f $INITIALFILE ]] || ( echo "$INITIALFILE doesn't exist!"; exit )

[[ -f $TARGETFILE ]] && rm $TARGETFILE

touch $TARGETFILE

USER_LIST=$(cat $INITIALFILE)

for username in $USER_LIST
do
    status=$(curl -o /dev/null -Isw '%{http_code}' -m 30 https://$username.github.io/os201/)
    if [[ status -ne 404 ]]
    then 
	printf "%-25s 1\n" $username >> $TARGETFILE
    else 
	printf "%-25s 0\n" $username >> $TARGETFILE
    fi
done
