open Mirage

let main =
  foreign
    ~packages:[package "mirage-crypto"; package "eqaf"; package "hex"; package "ounit2"] 
    "Unikernel.Aes_Ecb_Ganesha" (time @-> job)

let () =
  register "aes_ecb_ganesha" [main $ default_time]