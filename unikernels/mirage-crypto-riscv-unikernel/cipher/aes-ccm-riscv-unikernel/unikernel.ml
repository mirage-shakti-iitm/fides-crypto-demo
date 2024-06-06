open Lwt.Infix
open Mirage_crypto
open Cipher_block

exception CCM_Decryption_Broken of string


module Aes_Ccm_Ganesha (Time : Mirage_time_lwt.S) = struct
  
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


    let case ~key ~p ~a ~nonce ~c ~maclen = (AES.CCM.of_secret ~maclen (vx key), vx p, vx a, vx nonce,vx c)

    let aes_ccm_data = [

    case ~key:    "404142434445464748494a4b4c4d4e4f"
         ~p:      "20212223"
         ~a:      "0001020304050607"
         ~nonce:  "10111213141516"
         ~c:      "7162015b4dac255d"
         ~maclen: 4
    ;
    case ~key:    "40414243 44454647 48494a4b 4c4d4e4f"
         ~p:      "20212223 24252627 28292a2b 2c2d2e2f"
         ~a:      "00010203 04050607 08090a0b 0c0d0e0f"
         ~nonce:  "10111213 14151617"
         ~c:      "d2a1f0e0 51ea5f62 081a7792 073d593d 1fc64fbf accd"
         ~maclen: 6
    ;
    case ~key:    "404142434445464748494a4b4c4d4e4f"
         ~p:      "202122232425262728292a2b2c2d2e2f3031323334353637"
         ~a:      "000102030405060708090a0b0c0d0e0f10111213"
         ~nonce:  "101112131415161718191a1b"
         ~c:      "e3b201a9f5b71a7a9b1ceaeccd97e70b6176aad9a4428aa5484392fbc1b09951"
         ~maclen: 8
  ]


   let check (key, p, adata, nonce, c) =
    (* let open Cipher_block in  *)
    let cip = AES.CCM.authenticate_encrypt ~key ~nonce ~adata p in
    let pdata = 
    match AES.CCM.authenticate_decrypt ~key ~nonce ~adata c with
    | None -> raise (CCM_Decryption_Broken "CCM decryption broken")
    | Some data -> data
    in
    let _ = check_cipher_text c cip in
    let _ = check_plain_text p pdata in ()

    let cases_of f aes_data = List.iter f aes_data

    let start _time =
        (* let open Cipher_block in *)
        List.iter check aes_ccm_data;
        Lwt.return_unit
end