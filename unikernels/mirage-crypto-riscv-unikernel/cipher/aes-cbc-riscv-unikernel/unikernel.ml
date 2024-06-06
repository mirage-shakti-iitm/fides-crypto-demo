open Lwt.Infix
open Mirage_crypto
open Cipher_block

module Aes_Cbc_Ganesha (Time : Mirage_time_lwt.S) = struct
  
    let red s =
        "\027[0;31m" ^ s ^ "\027[0m"

    let green s =
        "\027[0;32m" ^ s ^ "\027[0m"

    let vx = Cstruct.of_hex
    
    let nist_sp_800_38a = vx 
  "6b c1 be e2 2e 40 9f 96 e9 3d 7e 11 73 93 17 2a
   ae 2d 8a 57 1e 03 ac 9c 9e b7 6f ac 45 af 8e 51
   30 c8 1c 46 a3 5c e4 11 e5 fb c1 19 1a 0a 52 ef
   f6 9f 24 45 df 4f 9b 17 ad 2b 41 7b e6 6c 37 10"

   let check_cipher_text out enc =
    let computed_cipher_hex = Hex.of_cstruct enc in
    let expected_cipher_hex = Hex.of_cstruct out in 
    let computed_cipher_string = Hex.show computed_cipher_hex in
    let expected_cipher_string = Hex.show expected_cipher_hex in
    let _ = print_endline ("\nCalculated Cipher\t:\t" ^ computed_cipher_string) in
    let _ = print_endline ("\nExpected Cipher\t\t:\t" ^ expected_cipher_string) in
    let res = Eqaf.equal computed_cipher_string expected_cipher_string in
    if res then print_endline (green "\n****************SUCCESS CIPHER TEXT****************\n") else print_endline (red "\n****************FAILURE CIPHER TEXT****************\n")

   let check_plain_text inp dec =
    let computed_plain_hex = Hex.of_cstruct dec in
    let expected_plain_hex = Hex.of_cstruct inp in 
    let computed_plain_string = Hex.show computed_plain_hex in
    let expected_plain_string = Hex.show expected_plain_hex in
    let _ = print_endline ("\nCalculated Plain\t:\t" ^ computed_plain_string) in
    let _ = print_endline ("\nExpected Plain\t\t:\t" ^ expected_plain_string) in
    let res = Eqaf.equal computed_plain_string expected_plain_string in
    if res then print_endline (green "\n****************SUCCESS PLAIN TEXT****************\n") else print_endline (red "\n****************FAILURE PLAIN TEXT****************\n")


    let case ~key ~iv ~out = (AES.CBC.of_secret (vx key), vx iv, vx out)

    let aes_cbc_data = [
    case ~key: "2b 7e 15 16 28 ae d2 a6 ab f7 15 88 09 cf 4f 3c"
         ~iv:  "00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f"
         ~out: "76 49 ab ac 81 19 b2 46 ce e9 8e 9b 12 e9 19 7d
                50 86 cb 9b 50 72 19 ee 95 db 11 3a 91 76 78 b2
                73 be d6 b8 e3 c1 74 3b 71 16 e6 9e 22 22 95 16
                3f f1 ca a1 68 1f ac 09 12 0e ca 30 75 86 e1 a7"

  ; case ~key: "8e 73 b0 f7 da 0e 64 52 c8 10 f3 2b 80 90 79 e5
                62 f8 ea d2 52 2c 6b 7b"
         ~iv:  "00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f"
         ~out: "4f 02 1d b2 43 bc 63 3d 71 78 18 3a 9f a0 71 e8
                b4 d9 ad a9 ad 7d ed f4 e5 e7 38 76 3f 69 14 5a
                57 1b 24 20 12 fb 7a e0 7f a9 ba ac 3d f1 02 e0
                08 b0 e2 79 88 59 88 81 d9 20 a9 e6 4f 56 15 cd"

  ; case ~key: "60 3d eb 10 15 ca 71 be 2b 73 ae f0 85 7d 77 81
                1f 35 2c 07 3b 61 08 d7 2d 98 10 a3 09 14 df f4"
         ~iv:  "00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f"
         ~out: "f5 8c 4c 04 d6 e5 f1 ba 77 9e ab fb 5f 7b fb d6
                9c fc 4e 96 7e db 80 8d 67 9f 77 7b c6 70 2c 7d
                39 f2 33 69 a9 d9 ba cf a5 30 e2 63 04 23 14 61
                b2 eb 05 e2 c3 9b e9 fc da 6c 19 07 8c 6a 9d 1b"
  ]


   let check (key, iv, out) =
    (* let open Cipher_block in  *)
    let enc = AES.CBC.encrypt ~key ~iv nist_sp_800_38a in
    let dec = AES.CBC.decrypt ~key ~iv enc in
    let _ = check_cipher_text out enc in
    let _ = check_plain_text nist_sp_800_38a dec in ()

    let cases_of f aes_data = List.iter f aes_data


    let start _time =
        (* let open Cipher_block in *)
        List.iter check aes_cbc_data;
        Lwt.return_unit
end