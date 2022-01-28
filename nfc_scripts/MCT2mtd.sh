#!/bin/bash

source env.sh

exec 

non_uniq_src_file_exit(){
	echo "There is no source file or more than one source file in the landing folder!"
    ls -l ${LANDING_FOLDER}/*
	exit 1
}

validate()
{
	FILE=$1
	[ `cat ${FILE} | wc -L` -ne 32 ] && echo 'Validation failed, check the file!' && exit 1
	[ `cat ${FILE} | wc -w` -ne 64 ] && echo 'Validation failed, check the file!' && exit 1
	[ `cat ${FILE} | wc -c` -ne 2112 ] && echo 'Validation failed, check the file!' && exit 1
	echo "Validation passed!"
}

[ `ls -1 ${LANDING_FOLDER}/* | wc -l ` -ne 1 ] && non_uniq_src_file_exit

source_file=`ls -1 ${LANDING_FOLDER}/*`
source_basename=`basename ${source_file}`

cd ${TEMP_PATH}
# echo ${TEMP_PATH}
echo "Converting ${source_file} to binary..."
rm -fr ${TEMP_PATH}/*
cp ${source_file} ${TEMP_PATH}

grep -v 'Sector' ${source_file} > input_tmp.dat
validate input_tmp.dat

xxd -r -p input_tmp.dat output_tmp.bin

cp -i output_tmp.bin ${DATA_IMPORT_PATH}/${source_basename}_MCT.mfd
echo "Dump file converted to ${DATA_IMPORT_PATH}/${source_basename}_MCT.mfd"
