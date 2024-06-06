open Mirage

let main =
  foreign
    ~packages:[package "mirage-crypto"; package "eqaf"; package "hex"] 
    "Unikernel.Aes_Cbc_Ganesha" (time @-> job)

let () =
  register "aes_cbc_ganesha" [main $ default_time]