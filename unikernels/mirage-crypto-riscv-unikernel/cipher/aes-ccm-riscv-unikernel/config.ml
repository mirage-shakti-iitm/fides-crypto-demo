open Mirage

let main =
  foreign
    ~packages:[package "mirage-crypto"; package "eqaf"; package "hex"] 
    "Unikernel.Aes_Ccm_Ganesha" (time @-> job)

let () =
  register "aes_ccm_ganesha" [main $ default_time]