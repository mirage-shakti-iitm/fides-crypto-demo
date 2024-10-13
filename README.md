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
__Step 1:__ Lets try executing a sample AES-CBC cipher unikernel.
```
cd unikernels/mirage-crypto-riscv-unikernel/cipher/aes-cbc-riscv-unikernel

spike kernel
```

__Step 2:__ The AES-CBC crpto unikernel exits with and error message stating transition from compartment 5 to 31 fails. This is because, the main unikernel application is in compartment 5 and the cryptographic libraries are in compartment 31. And we have not explicitly stated transition from 5 to 31 is allowed in the access matrix.
```
Checkcap capability matrix fail(Due to invalid compartment jump) : (5) to (31) at 0x8005cc90
```

__Step 3:__ We add the "5:31" to enable to transitions from compartment 5 to 31 in the access matrix, which is stored in cap_table.txt. And we recompile the Security Monitor, which is part of the _ocaml_boot-riscv_ package. Then we rebuild the unikernel. Now it executes successfully.
```
echo 5:31 >> $CAP_MATRIX_PATH/cap_table.txt

opam reinstall ocaml-boot-riscv -y

eval $(opam env)

make build kernel

spike kernel
```