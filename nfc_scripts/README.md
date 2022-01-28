# NFC read/write scrips

## Card read
card read script: NFC_read_card.sh

## Card write
card write script: NFC_write_card.sh

## Shortcut
1. Execute initiate script: 
```bash
bash nfc_on_the_go.sh
```

2. Below are the shortcut to do the NFC operations:
```
nfc_mode
    show this message.

nfc_read
    nfc_read -o <OUTPUT_FILE_NAME>

nfc_write
    nfc_write -f <SOURCE FILE>

MCT2mtd.sh
    Convert the dump file in MCT on Android to binary

scripts_and_data_rbak.sh
    Backup data and scripts
```