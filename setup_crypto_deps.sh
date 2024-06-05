# Installing mirage which supports riscv backend
git clone https://github.com/mirage-shakti-iitm/mirage.git
cd mirage
git checkout fides-crypto-demo
eval $(opam env)
opam install functoria.3.1.1 -y
opam pin mirage . -y
cd ../

# Installing Fides-OCaml cross compiler
git clone https://github.com/mirage-shakti-iitm/ocaml.git
cd ocaml
git pull
git checkout fides-crypto-demo
eval $(opam env)
opam update
eval $(opam env)
# ocamlopt
opam pin ocaml-base-compiler . -n
opam reinstall ocaml-base-compiler -y
eval $(opam env)
opam pin ocaml-riscv . -y
opam reinstall ocaml-riscv -y

# Installing fides-utilities
cd ../
git clone https://github.com/mirage-shakti-iitm/fides-utilities.git
cd fides-utilities
git pull
cd cap_matrix_gen
make install_cap_matrix_generator

# Install ocaml-boot-riscv
cd ../../
git clone https://github.com/mirage-shakti-iitm/ocaml-boot-riscv.git
cd ocaml-boot-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin . -y
# opam reinstall ocaml-boot-riscv -y
cd ../

# Installing ocaml-freestanding-riscv
git clone https://github.com/mirage-shakti-iitm/ocaml-freestanding-riscv.git
cd ocaml-freestanding-riscv
git checkout fides-crypto-demo
opam pin . -y
cd ../


# Install ocamlbuild
git clone https://github.com/mirage-shakti-iitm/ocamlbuild.git
cd ocamlbuild
git checkout fides
eval $(opam env)
opam pin . -y
cd ../

# Installing astring
git clone https://github.com/mirage-shakti-iitm/astring-riscv.git
cd astring-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin . -y
cd ../

# Installing parse-argv
git clone https://github.com/mirage-shakti-iitm/parse-argv-riscv.git
cd parse-argv-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin parse-argv-riscv . -y
cd ../

# Installing sexplib0
git clone https://github.com/mirage-shakti-iitm/sexplib0-riscv.git
cd sexplib0-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin sexplib0-riscv . -y
cd ../


# Installing base
git clone https://github.com/mirage-shakti-iitm/base-riscv.git
cd base-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin base-riscv . -y
cd ../

# Installing parsexp
git clone https://github.com/mirage-shakti-iitm/parsexp-riscv.git
cd parsexp-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin parsexp-riscv . -y
cd ../


# Installing sexplib
git clone https://github.com/mirage-shakti-iitm/sexplib-riscv.git
cd sexplib-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin sexplib-riscv . -y
cd ../

# Installing ptime
git clone https://github.com/mirage-shakti-iitm/ptime-riscv.git
cd ptime-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin . -y
cd ../

# Installing bheap
git clone https://github.com/mirage-shakti-iitm/bheap.git
cd bheap
git checkout fides-crypto-demo
eval $(opam env)
opam pin bheap-riscv . -y
cd ../

# Installing mtime
git clone https://github.com/mirage-shakti-iitm/mtime-riscv.git
cd mtime-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin . -y
cd ../

# Installing optint
git clone https://github.com/mirage-shakti-iitm/optint-riscv.git
cd optint-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin optint-riscv . -y
cd ../

# Installing checkseum
git clone https://github.com/mirage-shakti-iitm/checkseum-riscv.git
cd checkseum-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin checkseum-riscv . -y
cd ../

# Installing cmdliner
git clone https://github.com/mirage-shakti-iitm/cmdliner-riscv.git
cd cmdliner-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin . -y
cd ../

# Installing cstruct-riscv
git clone https://github.com/mirage-shakti-iitm/cstruct-riscv.git
cd cstruct-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin cstruct-riscv . -y
eval $(opam env)
opam pin cstruct-sexp-riscv . -y
cd ../

# Installing randomconv
git clone https://github.com/mirage-shakti-iitm/randomconv-riscv.git
cd randomconv-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin randomconv-riscv . -y
cd ../

# Installing result
git clone https://github.com/mirage-shakti-iitm/result-riscv.git
cd result-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin result-riscv . -y
cd ../

# Installing fmt
git clone https://github.com/mirage-shakti-iitm/fmt-riscv.git
cd fmt-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin . -y
cd ../

# Installing duration
git clone https://github.com/mirage-shakti-iitm/duration-riscv.git
cd duration-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin duration-riscv . -y
cd ../

# Installing domain-name
git clone https://github.com/mirage-shakti-iitm/domain-name-riscv.git
cd domain-name-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin domain-name-riscv . -y
cd ../

# Installing eqaf
git clone https://github.com/mirage-shakti-iitm/eqaf-riscv.git
cd eqaf-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin eqaf-riscv . -y
cd ../

# Installing functoria-runtime
git clone https://github.com/mirage-shakti-iitm/functoria-runtime-riscv.git
cd functoria-runtime-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin functoria-runtime-riscv . -y
cd ../

# Installing hex
git clone https://github.com/mirage-shakti-iitm/hex-riscv.git
cd hex-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin hex-riscv . -y
cd ../


# Installing macaddr, ipaddr
git clone https://github.com/mirage-shakti-iitm/ipaddr-riscv.git
cd ipaddr-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin macaddr-riscv . -y
opam pin ipaddr-riscv . -y
cd ../

# Installing lwt
git clone https://github.com/mirage-shakti-iitm/lwt-riscv.git
cd lwt-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin lwt-riscv . -y
cd ../

# Installing lwt-dllist
git clone https://github.com/mirage-shakti-iitm/lwt-dllist-riscv.git
cd lwt-dllist-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin lwt-dllist-riscv . -y
cd ../

# Installing logs
git clone https://github.com/mirage-shakti-iitm/logs-riscv.git
cd logs-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin logs-riscv . -y
cd ../

# Installing mirage-riscv
git clone https://github.com/mirage-shakti-iitm/mirage-riscv.git
cd mirage-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-riscv-riscv . -y
cd ../

# Installing metrics
git clone https://github.com/mirage-shakti-iitm/metrics-riscv.git
cd metrics-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin metrics-riscv . -y
cd ../

# Installing mirage, mirage-runtime
cd mirage
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-runtime-riscv . -y
cd ../

# Installing mirage-time
git clone https://github.com/mirage-shakti-iitm/mirage-time-riscv.git
cd mirage-time-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-time-riscv . -y
cd ../

# Installing mirage-bootvar
git clone https://github.com/mirage-shakti-iitm/mirage-bootvar-riscv.git
cd mirage-bootvar-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-bootvar-riscv . -y
cd ../

# Installing mirage-clock
git clone https://github.com/mirage-shakti-iitm/mirage-clock-riscv.git
cd mirage-clock-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-clock-riscv . -y
cd ../

# Installing mirage-crypto
git clone https://github.com/mirage-shakti-iitm/mirage-crypto-riscv.git
cd mirage-crypto-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-crypto-riscv . -y
cd ../

# Installing mirage-crypto-rng
git clone https://github.com/mirage-shakti-iitm/mirage-crypto-rng-riscv.git
cd mirage-crypto-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-crypto-rng-riscv . -y
cd ../

# Installing mirage-crypto-rng-mirage
git clone https://github.com/mirage-shakti-iitm/mirage-crypto-rng-mirage-riscv.git
cd mirage-crypto-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-crypto-rng-mirage-riscv . -y
cd ../

# Installing mirage-logs
git clone https://github.com/mirage-shakti-iitm/mirage-logs-riscv.git
cd mirage-logs-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-logs-riscv . -y
cd ../

# Installing mirage-random
git clone https://github.com/mirage-shakti-iitm/mirage-random-riscv.git
cd mirage-random-riscv
git checkout fides-crypto-demo
eval $(opam env)
opam pin mirage-random-riscv . -y
cd ../

# Copying ppx libraries
eval $(opam env)
cp $OPAM_SWITCH_PREFIX/lib/ppx* $OPAM_SWITCH_PREFIX/riscv-sysroot/lib/ -r

