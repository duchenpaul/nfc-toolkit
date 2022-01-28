#!/bin/bash

source env.sh

delete_empty_file(){
    FILENAME=$1
    [ ! -s ${FILENAME} ] && echo "${FILENAME} is empty, so it is deleted." && rm -fr ${FILENAME}
}

cd ${TEMP_PATH}
OUTPUT_FILE_NAME=NFC_dmp_`date '+%Y%m%d_%H%M%S'`

# Get arguments
while getopts :o: option
do      case "$option" in
        o)      OUTPUT_FILE_NAME=$OPTARG;;
        esac
done
shift $((OPTIND-1))

LOG=${LOG_PATH}/${OUTPUT_FILE_NAME}.log
echo "Brute attacking..."
echo "Log: ${LOG}"
mfcuk -C -R 0:A -s 250 -S 250 -v 3 > ${LOG} 2>&1 
if [ $? -eq 0 ]; then
	key=`cat ${LOG} | grep recovered | awk -F ':' '{print $3}'`
	echo "Got key!"
	echo "bash ${SCRIPT_PATH}/NFC_read_card.sh -o ${OUTPUT_FILE_NAME} -k ${key}"
else
	echo "Crack failed!"
	echo "For more info: ${LOG}"
fi
