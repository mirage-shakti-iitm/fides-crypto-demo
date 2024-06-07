# 
eval $(opam env)
opam reinstall mirage-logs-riscv -y
cd unikernels

# build aes-cbc
cd mirage-crypto-riscv-unikernel/cipher/aes-cbc-riscv-unikernel
mirage config -t riscv
cp ../../../../custom_makefile Makefile
make build
export OCAMLPARAM="insert-all-checkcap=1,function_sections=1,default-compartment-id=255,fides-cap-path=/home/fides/fides-crypto-demo/unikernels/mirage-crypto-riscv-unikernel/cipher/aes-cbc-riscv-unikernel,_"
make kernel
# spike kernel

