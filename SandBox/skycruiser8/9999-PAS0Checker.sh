#!/bin/bash

[[ -z $1 ]] && { echo "Usage: bash $0 <username>";exit 1; }

[[ -e "temp/$1" ]] && rm -f "temp/$1"

checkerUname="skycruiser8"

cd temp

wget -q -O "$1.txt" "https://raw.githubusercontent.com/$1/os201/master/UAS/0001-mytest.txt"

[[ -z $(cat $1.txt | grep "Script started on") ]] && { echo "$checkerUname ZCZCSCRIPTSTART ERROR $1\n";exit 1; }

# Date fetch
startDate=$(cat $1.txt | grep "Script started on" | sed -e "s/WIB//g" -e "s/Script started on //g" -e "s/\[.*$//g")
startDate=$(date -d "$startDate")
endDate=$(cat $1.txt | grep "Script done on" | sed -e "s/WIB//g" -e "s/Script done on//g" -e "s/\[.*$//g")
endDate=$(date -d "$endDate")


# Header
checkDate=$(date -d "$startDate" +%y%m%d-%H%M%S)
echo "$checkerUname ZCZCSCRIPTSTART $checkDate $1\n"

# Loop check all prompts
for LINE in $(cat $1.txt | grep "^[0-9]" | cut -d'>' -f 1)
  do

  # Check date
  thisDate=$(echo $LINE | cut -d'-' -f 1-2)
  if [[ $thisDate < $checkDate ]]; then
    dateStatus="SEQNO"
  else
    dateStatus="SEQOK"
  fi
  checkDate="$thisDate"

  # Check SHA1sum
  thisSum=$(echo $LINE | cut -d'-' -f 3)
  computedSum=$(echo $LINE | cut -d'-' -f 1-2)
  computedSum+="-$1-$(echo $LINE | cut -d'-' -f 4)"
  computedSum=$(echo $computedSum | sed -e "s/\///g" | sha1sum)

  if [[ $thisSum == $(echo $computedSum | cut -c1-4) ]]; then
    sumStatus="SUMOK"
  else
    sumStatus="SUMNO"
  fi

  echo "$checkerUname $1 $LINE $thisDate $dateStatus $sumStatus $(echo $computedSum | cut -c1-8)\n"

  done

# Final date check
outED=$(date -d "$endDate" +%y%m%d-%H%M%S)
if [[ $outED < $checkDate ]]; then
    dateStatus="SEQNO"
  else
    dateStatus="SEQOK"
fi
echo "$checkerUname ZCZCSCRIPTSTOP $outED $dateStatus\n"
