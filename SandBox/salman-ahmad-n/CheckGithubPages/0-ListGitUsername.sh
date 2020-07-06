#!/bin/bash
# INFO : Membuat file yang berisi list dari directory sebelumya
# Author : Salman Ahmad Nurhoiriza (salman-ahmad-n)

ls -l ../.. | gawk '/^d/ {print $9}' > 00-sandbox-os201.txt
