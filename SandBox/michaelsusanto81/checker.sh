#!/bin/sh
wget -c https://raw.githubusercontent.com/mlhmg/os201/master/UAS/0001-mytest.txt -O mlhmg.txt
wget -c https://raw.githubusercontent.com/MNatalnael/os201/master/UAS/0001-mytest.txt -O mnatalnael.txt

cek() {
	counter=0

	tetangga_TIME_STATUS="SEQOK"
	tetangga_HASH_STATUS="SUMOK"
	tetangga_github=$1
	tetangga_sso=$2
	tetangga_txt=$3
	pemeriksa=$5
	tetangga_TIME_STATUS=( )
	tetangga_HASH_STATUS=( )
	tetangga_LONG_HASH_STATUS=( )

	temp="$pemeriksa ZCZCSCRIPTSTART "

	tetangga_mulai=$(grep "^Script started" $tetangga_txt | cut -c 18-)
	copy=$(date -d "$tetangga_mulai" +%y%m%d-%H%M%S)
	start=$(date -d "$tetangga_mulai" +%H%M%S)
	tetangga_mulai=$(date -d "$tetangga_mulai" +%y%m%d%H%M%S)
	temp+=$copy
	temp+=" $tetangga_github \n"

	tetangga_selesai=$(grep "^Script done" $tetangga_txt | cut -c 15-)
	end=$(date -d "$tetangga_selesai" +%y%m%d-%H%M%S)
	tetangga_selesai=$(date -d "$tetangga_selesai" +%y%m%d%H%M%S)

	tetangga_in_script=$(grep '^20' $tetangga_txt | cut -c -13 | cut -c 8-)
	tetangga_in_script_date=$(grep '^20' $tetangga_txt | cut -c -19)
	# echo $tetangga_in_script_date

	tetangga_result=( )

	filled=0
	for i in $tetangga_in_script
	do
		tetangga_result[$filled]=$i
		filled=$(expr $filled + 1)
	done

	ii=0
	jj=1
	while [ $jj -lt $filled ]
	do
		subtract=$(expr ${tetangga_result[$jj]} - ${tetangga_result[$ii]})
		[ "$ii" = "0" ] && \
			sub2=$(expr ${tetangga_result[$ii]} - $start)
			[ "$sub2" -lt "0" ] && \
				tetangga_TIME_STATUS[$ii]="SEQNO"
			[ "$sub2" -lt "0" ] || \
				tetangga_TIME_STATUS[$ii]="SEQOK"
			counter=$(expr $counter + 1)
		[ "$subtract" -lt "0" ] && \
			tetangga_TIME_STATUS[$jj]="SEQNO"
		[ "$subtract" -lt "0" ] || \
			tetangga_TIME_STATUS[$jj]="SEQOK"
		ii=$(expr $ii + 1)
		jj=$(expr $jj + 1)
		counter=$(expr $counter + 1)
	done
	# echo $tetangga_TIME_STATUS

	tetangga_hashes=$(grep '^20' $tetangga_txt | cut -c -18 | cut -c 15-)
	tetangga_hash_date=$(grep '^20' $tetangga_txt | cut -c -13)
	tetangga_hashes_result=( )
	tetangga_hash_date_result=( )

	filled=0
	for i in $tetangga_hashes
	do
		tetangga_hashes_result[$filled]=$i
		filled=$(expr $filled + 1)
	done

	filled=0
	for i in $tetangga_hash_date
	do
		tetangga_hash_date_result[$filled]="$i-$tetangga_github-$tetangga_sso"
		result=$(echo "${tetangga_hash_date_result[$filled]}" | sha1sum | cut -c -4)
		tetangga_LONG_HASH_STATUS[$filled]=$(echo "${tetangga_hash_date_result[$filled]}" | sha1sum | cut -c -8)
		# echo "${tetangga_LONG_HASH_STATUS[$filled]}"
		compared=${tetangga_hashes_result[$filled]}
		[ "$result" != "$compared" ] && \
			tetangga_HASH_STATUS[$filled]="SUMNO"
		[ "$result" != "$compared" ] || \
			tetangga_HASH_STATUS[$filled]="SUMOK"
		filled=$(expr $filled + 1)
	done
	# echo $tetangga_HASH_STATUS

	filled=0
	for i in $tetangga_in_script_date
	do
		temp2=$(echo "$i" | cut -c -13)
		temp+="$pemeriksa $tetangga_github $i$tetangga_sso/ $temp2 ${tetangga_TIME_STATUS[$filled]} ${tetangga_HASH_STATUS[$filled]} ${tetangga_LONG_HASH_STATUS[$filled]} \n"
		filled=$(expr $filled + 1)
	done

	tetangga_selisih=$(expr $tetangga_selesai - $tetangga_mulai)

	counter=$(expr $counter + 1)
	[ "$tetangga_selisih" -lt "0" ] && \
		tetangga_TIME_STATUS[counter]="SEQNO"
	[ "$tetangga_selisih" -lt "0" ] || \
		tetangga_TIME_STATUS[counter]="SEQOK"
	temp+="$pemeriksa ZCZCSCRIPTSTOP $end ${tetangga_TIME_STATUS[$counter]} \n"

	[ "$4" = "saya" ] && \
		export CEKSAYA=$temp
	[ "$4" = "sebela1" ] && \
		export CEKSEBELA1=$temp
	[ "$4" = "sebela2" ] && \
		export CEKSEBELA2=$temp
	echo $temp
}

cek "michaelsusanto81" "michael.susanto81" "0001-mytest.txt" "saya" "michaelsusanto81"
cek "mlhmg" "muhammad.ilham83" "mlhmg.txt" "sebela1" "michaelsusanto81"
cek "MNatalnael" "pjj" "mnatalnael.txt" "sebela2" "michaelsusanto81"