open Lwt.Infix
open Mirage_crypto
open Cipher_block

module Aes_Ecb_Ganesha (Time : Mirage_time_lwt.S) = struct
  
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


    let case ~key ~out = (AES.ECB.of_secret (vx key), vx out)

    let aes_ecb_data = [
    case ~key: "2b 7e 15 16 28 ae d2 a6 ab f7 15 88 09 cf 4f 3c"
         ~out: "3a d7 7b b4 0d 7a 36 60 a8 9e ca f3 24 66 ef 97
                f5 d3 d5 85 03 b9 69 9d e7 85 89 5a 96 fd ba af
                43 b1 cd 7f 59 8e ce 23 88 1b 00 e3 ed 03 06 88
                7b 0c 78 5e 27 e8 ad 3f 82 23 20 71 04 72 5d d4"

  ; case ~key: "8e 73 b0 f7 da 0e 64 52 c8 10 f3 2b 80 90 79 e5
                62 f8 ea d2 52 2c 6b 7b"
         ~out: "bd 33 4f 1d 6e 45 f2 5f f7 12 a2 14 57 1f a5 cc
                97 41 04 84 6d 0a d3 ad 77 34 ec b3 ec ee 4e ef
                ef 7a fd 22 70 e2 e6 0a dc e0 ba 2f ac e6 44 4e
                9a 4b 41 ba 73 8d 6c 72 fb 16 69 16 03 c1 8e 0e"

  ; case ~key: "60 3d eb 10 15 ca 71 be 2b 73 ae f0 85 7d 77 81
                1f 35 2c 07 3b 61 08 d7 2d 98 10 a3 09 14 df f4"
         ~out: "f3 ee d1 bd b5 d2 a0 3c 06 4b 5a 7e 3d b1 81 f8
                59 1c cb 10 d4 10 ed 26 dc 5b a7 4a 31 36 28 70
                b6 ed 21 b9 9c a6 f4 f9 f1 53 e7 b1 be af ed 1d
                23 30 4b 7a 39 f9 f3 ff 06 7d 8d 8f 9e 24 ec c7"
  ]


   let check (key, out) =
    (* let open Cipher_block in  *)
    let enc = AES.ECB.encrypt ~key nist_sp_800_38a in
    let dec = AES.ECB.decrypt ~key enc in
    let _ = check_cipher_text out enc in
    let _ = check_plain_text nist_sp_800_38a dec in ()

    let cases_of f aes_data = List.iter f aes_data

    let start _time =
        (* let open Cipher_block in *)
        List.iter check aes_ecb_data;
        Lwt.return_unit
end