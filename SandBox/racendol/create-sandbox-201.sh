#!/bin/bash
#
# Author: Rocky Arkan Adnan Ahmad (racendol)
# 
# Script ini akan membuat file sanbox-201.txt yang berisi
# daftar dari directory folder dari parent folder ini (folder SandBox).
#
# Jika sudah ada file sandbox-201.txt, maka akan menghapus isinya terlebih dahulu.

if [ -f sandbox-201.txt ]
then
    rm sandbox-201.txt
fi

for ii in $(ls -d ../*/ | sed "s/[./]//g")
do
    echo $ii >> sandbox-201.txt
done



