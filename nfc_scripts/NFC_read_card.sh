#!/bin/bash

source env.sh

delete_empty_file(){
    FILENAME=$1
    [ ! -s ${FILENAME} ] && echo "${FILENAME} is empty, so it is deleted." && rm -fr ${FILENAME}
}

cd ${DATA_IMPORT_PATH}
OUTPUT_FILE_NAME=NFC_dmp_`date '+%Y%m%d_%H%M%S'`
KEY=0

# Get arguments
while getopts :o:k: option
do      case "$option" in
        o)      OUTPUT_FILE_NAME=$OPTARG;;
		k)      KEY=$OPTARG;;
        esac
done
shift $((OPTIND-1))

if [ ${KEY} -eq 0 ]; then
	KEY_option=''
else
	KEY_option=" -k ${KEY} "
fi

READ_LOG=${LOG_PATH}/READ_${OUTPUT_FILE_NAME}.log
OUTPUT_FILE_NAME_FULL=${DATA_IMPORT_PATH}/${OUTPUT_FILE_NAME}.mfd

echo "The data will be dumped into ${OUTPUT_FILE_NAME_FULL}"
echo "Log: ${READ_LOG}"

mfoc -O ${OUTPUT_FILE_NAME_FULL} ${KEY_option} | tee ${READ_LOG} 2>&1
rtncode=$?

[ $rtncode -eq 0 ] && echo "Done!"

echo "The data has been dumped into ${OUTPUT_FILE_NAME_FULL}"
echo "Log: ${READ_LOG}"

delete_empty_file ${OUTPUT_FILE_NAME_FULL}
delete_empty_file ${READ_LOG}