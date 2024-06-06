open Mirage

let main =
  foreign
    ~packages:[package "mirage-crypto"; package "eqaf"; package "hex"] 
    "Unikernel.Aes_Gcm_Ganesha" (time @-> job)

let () =
  register "aes_gcm_ganesha" [main $ default_time]