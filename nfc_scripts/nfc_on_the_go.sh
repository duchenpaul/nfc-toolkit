#!/bin/bash

source env.sh

intro(){
	echo '***************** YOU HAVE ENTERED NFC MODE *****************'
	echo '                                                .//:`        
                                               +NMMMm-       
                                      ```      yMMMMMm.      
                                    `omNNh-    .mMMMMMd`     
                                    /MMMMMm-    :NMMMMMo     
                         .++:`      `mMMMMMd`    oMMMMMN.    
                        .mMMMd:      -NMMMMMo    `mMMMMMs    
    .sdy/`              .MMMMMN:      oMMMMMN.    +MMMMMN`   
   `dMMMMms-             sMMMMMm`     `mMMMMMs    `MMMMMM/   
   +MMMMMMMNh/.          `mMMMMMs      sMMMMMm     dMMMMMy   
   mMMMMMMMMMMms-`        +MMMMMN.     :MMMMMM-    sMMMMMd   
  `NMMMMMMMMMMMMNd+.      .MMMMMM/     `MMMMMM+    +MMMMMm   
  .NMMMMMsymMMMMMMMmy:`   `NMMMMM+      NMMMMM+    +MMMMMN`  
  `NMMMMM/ ./hNMMMMMMMd+. .MMMMMM+     `MMMMMM+    +MMMMMm   
   hMMMMMy    .odMMMMMMMNyyMMMMMM-     :MMMMMM-    sMMMMMd   
   :MMMMMN      `:ymMMMMMMMMMMMMh      sMMMMMm     dMMMMMy   
    yMMMMN`        .+dNMMMMMMMMN-     `mMMMMMs    `MMMMMM/   
     /hmh/           `:ymMMMMMM+      oMMMMMN.    +MMMMMN`   
                        ./hmNd/      -NMMMMMo    `mMMMMMs    
                           ``       `mMMMMMd`    oMMMMMN.    
                                    +MMMMMm-    :NMMMMMo     
                                    `omNNh-    .mMMMMMd`     
                                      ```      yMMMMMm.      
                                               +NMMMm-       
                                                .//:`        
                                                        '
	echo '***************** YOU HAVE ENTERED NFC MODE *****************'
}

set_alias(){
	alias nfc_mode='cd ${WORK_PATH}/ && ${SCRIPT_PATH}/nfc_on_the_go.sh'
	alias nfc_read='cd ${DATA_IMPORT_PATH} && ${SCRIPT_PATH}/NFC_read_card.sh'
	alias nfc_write='cd ${DATA_EXPORT_PATH} && ${SCRIPT_PATH}/NFC_write_card.sh'
}

cd ${SCRIPT_PATH}
nfc-scan-device
[ $? -ne 0 ] && "Failed to getting the NFC scanner, check the device and the configuration!" &&  exit 1 
intro


card_read_script=${SCRIPT_PATH}/NFC_read_card.sh
card_write_script=${SCRIPT_PATH}/NFC_write_card.sh

echo "---------------------------------------------"
echo "card read script=${card_read_script}"
echo "data read path=${DATA_IMPORT_PATH}"
echo ". . . . . . . . . . . . . . . . . . . .  . . "
echo "card write script=${card_write_script}"
echo -e "data write path=${DATA_EXPORT_PATH}\n"

echo 'nfc_mode
    show this message.

nfc_read
    nfc_read -o <OUTPUT_FILE_NAME>

nfc_write
    nfc_write -f <SOURCE FILE>

MCT2mtd.sh
    Convert the dump file in MCT on Android to binary

scripts_and_data_rbak.sh
    Backup data and scripts

'
