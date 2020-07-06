#!/bin/bash
#
# Author: Rocky Arkan Adnan Ahmad (racendol)
# 
# Script ini akan mengecek apakah 
# daftar username yang ada di file sandbox-201.txt sudah membuat GitHub Pages atau belum,
# lalu mencetak hasilnya di file GitHub-Pages-os201.txt.
#
# Jika username sudah membuat GitHub Pages maka akan mencetak 1,
# dan akan mencetak 0 jika belum membuat.
#
# Jika sudah ada file GitHub-Pages-os201.txt, maka akan menghapus isinya terlebih dahulu.
# Jika tidak menemukan file sandbox-201.txt, maka program akan mengeluarkan error & exit

inputFile="sandbox-201.txt"
outputFile="GitHub-Pages-os201.txt"

if [ ! -f $inputFile ]; then
    echo "sandbox-201.txt tidak ditemukan!"
    echo "Jalankan create-sandbox-201.sh terlebih dahulu"
    exit 1
fi


if [ -f $outputFile ]; then
    rm $outputFile
fi

for ii in $(cat $inputFile)
do
    statusIsOk=$(curl --silent --head https://$ii.github.io/os201/ | head -n 1 | grep 'HTTP/2 [23]..')
    if [[ $statusIsOk ]]
    then
        echo "$ii 1" >> $outputFile
    else 
        echo "$ii 0" >> $outputFile
    fi
done