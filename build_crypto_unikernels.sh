# 
eval $(opam env)
cd unikernels

# build aes-cbc
cd mirage-crypto-riscv-unikernel/cipher/aes-cbc-riscv-unikernel
mirage config -t riscv
cp ../../../../custom_makefile Makefile
make build
make kernel
# spike kernel