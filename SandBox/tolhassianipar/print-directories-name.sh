#!/bin/bash
# desc: print all directories name to sandbox-201.txt

# Modified from a05-finding-EXIST
# Reference: https://askubuntu.com/questions/994602/how-to-write-out-all-directory-names-into-a-text-file


echo -n "" > sandbox-201.txt

for dir in ./../*
do
   [[ -d "$dir" ]] && echo "${dir##./../}" >> sandbox-201.txt
done

exit 0
