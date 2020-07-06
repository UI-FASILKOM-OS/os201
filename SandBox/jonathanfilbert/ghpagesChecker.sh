LIST_USERNAMES='sandbox-201.txt'
RESULT='GitHub-Pages-os201.txt'

rm  $RESULT
touch $RESULT

cat $LIST_USERNAMES | while read username
do
    if ( curl -s  https://$username.github.io/os201/ | grep 'Site not found');
        then
            printf "%-20s 0\n" $username >> $RESULT
        else
            printf "%-20s 1\n" $username >> $RESULT
    fi
done

