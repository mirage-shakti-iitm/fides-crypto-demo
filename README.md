# FIDES setup with docker
---
## Setting up Docker image with Riscv-tools:
__Step 1:__ Install Docker by referring to the following link: _https://docs.docker.com/engine/install/_

__Step 2:__ Pull _fides_ docker image.
```
docker pull svkv/fides:v1
```
__Step 3:__ Verifying docker image
```
docker run -it svkv/fides:v1
```
The above command results in a bash. The _/home/fides/fides-crypto-demo_ is the home directory which houses all the packages installed and sample Mirage os unikernels. Press Ctrl^D to exit from the docker container.

## Executing crypto unikernel
__Step 1:__ 
```
cd unikernels/mirage-crypto-riscv-unikernel/cipher/aes-cbc-riscv-unikernel

spike kernel

echo 5:31 >> $CAP_MATRIX_PATH/cap_table.txt
```

