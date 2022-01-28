#!/bin/bash

source env.sh


REMOTE_SERVER=duchenpaul.us.to
REMOTE_PORT=2201
REMOTE_PATH=/home/pi/run/pi_extensions/nfc_project

tput setaf 3 && echo "Back up card data..." && tput sgr0
rsync -av -r --delete -e "ssh -p 2201" -r  ${CARD_DATA_BASE_PATH} ${REMOTE_SERVER}:${REMOTE_PATH}
[ $? -ne 0 ] && echo "Backup failed!" 
echo -e "Done!\n"

tput setaf 3 && echo "Back up scripts..." && tput sgr0
rsync -av -r --delete -e "ssh -p 2201" -r  ${SCRIPT_PATH} ${REMOTE_SERVER}:${REMOTE_PATH}
[ $? -ne 0 ] && echo "Backup failed!" 
echo "Done!"