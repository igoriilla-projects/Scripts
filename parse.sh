#!/bin/bash

SOURCEFILE=""
KEYFIELD="NAME"
declare -A JSA


while true; do
	case $1 in

	 -k | --key-field )	KEYFIELD="$2"; shift 2;;
	 -s | --source-file )    SOURCEFILE="$2"; shift 2;;
	 -- ) shift; break;;
         * ) break;;
	esac
done

#Save headers from file to array
HEADERS=$(head -n 1 $SOURCEFILE)
read -r -a array <<< "$HEADERS"

#Delete key field from array
array=( ${array[@]/"$KEYFIELD"} )


echo "{"

while read line
do
	JSON=""

	JSA[VMID]=$(echo $line | awk '{print $1}')
	JSA[NAME]=$(echo $line | awk '{print $2}')
	JSA[STATUS]=$(echo $line | awk '{print $3}')
	JSA[MEM(MB)]=$(echo $line | awk '{print $4}')
	JSA[BOOTDISK(GB)]=$(echo $line | awk '{print $5}')
	JSA[PID]=$(echo $line | awk '{print $6}')

	JSON_BEGINNING='"'${JSA[$KEYFIELD]}'": {'

	for field in ${array[@]}
	do
		JSON=''${JSON}'"'${field}'":"'${JSA[$field]}'",'
	done
	echo $JSON_BEGINNING  ${JSON%?}
	echo "},"


done < <(tail -n +2 "$SOURCEFILE")


#dirty hack for vaildate json XD
echo '"End of the json":{}}'
