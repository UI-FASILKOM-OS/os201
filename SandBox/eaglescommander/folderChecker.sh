if [ -e sandbox-201.txt ]
then rm -f sandbox-201.txt
fi

touch sandbox-201.txt

for ii in  $(ls -p .. | grep '/$' | sed 's/.$//')
do
echo $ii >> sandbox-201.txt
done
