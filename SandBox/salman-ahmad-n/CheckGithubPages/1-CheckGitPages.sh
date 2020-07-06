#!/bin/bash
# INFO : List mahasiswa yang sudah membuat Github Pages
# Author : Salman Ahmad Nurhoiriza (salman-ahmad-n)

INPUT="00-sandbox-os201.txt"
OUTPUT="GitHub-Pages-os201.txt"

[[ -f $INPUT ]] || ( echo "$INPUT doesn't exists, run 0-ListGitUsername.sh"; exit)

[[ -f $OUTPUT ]] && rm $OUTPUT

touch $OUTPUT

cat $INPUT | 
	while read username
	do
		STATUS=$(curl -o /dev/null -Isw '%{http_code}' -m 30 https://$username.github.io/os201/)
		if [[ STATUS -ne 404 ]]
		then printf "%-25s 1\n" $username >> $OUTPUT
		else printf "%-25s 0\n" $username >> $OUTPUT
		fi
	done
