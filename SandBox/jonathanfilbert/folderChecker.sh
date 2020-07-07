# Script was made by Jonathan Filbert

# variable for the name of the generated file
RESULT_NAME="sandbox-201.txt"

# delete the result (if exists)
rm -rf $RESULT_NAME
# make the empty result file
touch $RESULT_NAME

# loop through every file
for entry in "../"*
do
# if that's a directory
    if [ -d ${entry} ]; then
        # print to the file
        echo $entry >> $RESULT_NAME
    fi
done

# remove every / and .. with an empty string
sed -i -e 's/\///g' $RESULT_NAME
sed -i -e 's/\.\.//g' $RESULT_NAME
# delete weird file
rm sandbox-201.txt-e