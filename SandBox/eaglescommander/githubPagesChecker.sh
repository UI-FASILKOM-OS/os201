bash folderChecker.sh

usernames=$(cat sandbox-201.txt)

if [ -e GitHub-Pages-os201.txt ]
then rm -f GitHub-Pages-os201.txt
fi

touch GitHub-Pages-os201.txt

for ii in $usernames
do
status=$(curl -s -o /dev/null -w "%{http_code}" https://$ii.github.io/os201/)
if [[ $status == "200" ]]
then
echo "$ii 1" >> GitHub-Pages-os201.txt
else
echo "$ii 0" >> GitHub-Pages-os201.txt
fi
done

