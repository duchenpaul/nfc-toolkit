# About 
* Integrates Libnfc drivers with MFOC and MFCUK installed 
* Preconfigured to work on ttyUSB0 uart 

# Usages 
## Docker 
### Build
```bash
docker build -t nfc-toolkit -f Dockerfile .
```

### Run
```bash
docker run --rm -h nfc-toolkit -ti --device=/dev/ttyUSB0 -v $(pwd):/workspace nfc-toolkit bash
```
