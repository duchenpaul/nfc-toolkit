#!/bin/bash

source env.sh

cd ${DATA_EXPORT_PATH}
source_file=''

usage(){
	echo "Usage: $0 -f <SOURCE FILE>"
	echo "Path: ${DATA_EXPORT_PATH}/"
	ls -l ${DATA_EXPORT_PATH}
	exit 0
}

# Get arguments
while getopts :f: option
do      case "$option" in
        f)      source_file=$OPTARG;;
        esac
done
shift $((OPTIND-1))

[ "${source_file}" = '' ] && usage

source_file_basename=`basename ${source_file} .mfd`
WRITE_LOG=${LOG_PATH}/WRITE_${source_file_basename}_`date '+%Y%m%d_%H%M%S'`.log

echo "Writing data from file: ${source_file} to the card..."
echo "Log: ${WRITE_LOG}"

nfc-mfclassic W b ${source_file} | tee ${WRITE_LOG} 2>&1
rtncode=$?

[ $rtncode -eq 0 ] && echo "Done!"

echo "${source_file_basename} has been wrote to the card"
echo "Log: ${WRITE_LOG}"