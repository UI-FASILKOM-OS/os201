#!/bin/bash
# desc: check all establish github pages and print to GitHub-Pages-os201.txt

# Modified from a05-finding-EXIST
# Reference: https://askubuntu.com/questions/994602/how-to-write-out-all-directory-names-into-a-text-file
# Reference: https://stackoverflow.com/questions/2924422/how-do-i-determine-if-a-web-page-exists-with-shell-scripting

echo -n "" > GitHub-Pages-os201.txt

for d in ./../*
do
   if [[ -d "$d" ]] 
   then
      if curl --output /dev/null --silent --head --fail "https://${d##./../}.github.io/os201/"
      then
         printf "%-25s %s\n" "`cut -c 1-25 <<< ${d##./../}`" "1" >> GitHub-Pages-os201.txt
      else
         printf "%-25s %s\n" "`cut -c 1-25 <<< ${d##./../}`" "0" >> GitHub-Pages-os201.txt
      fi
   fi   
done

exit 0
