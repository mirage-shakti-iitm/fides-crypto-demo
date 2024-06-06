open Lwt.Infix
open Mirage_crypto
open Cipher_block

exception GCM_Decryption_Broken of string


module Aes_Gcm_Ganesha (Time : Mirage_time_lwt.S) = struct
  
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


    let case ~key ~p ~a ~nonce ~c ~t = (AES.GCM.of_secret (vx key), vx p, vx a, vx nonce,vx c, vx t)

    let aes_gcm_data = [

    case ~key: "00000000000000000000000000000000"
         ~p:   ""
         ~a:   ""
         ~nonce: "000000000000000000000000"
         ~c:   ""
         ~t:   "58e2fccefa7e3061367f1d57a4e7455a" ;
    case ~key: "00000000000000000000000000000000"
         ~p:   "00000000000000000000000000000000"
         ~a:   ""
         ~nonce: "000000000000000000000000"
         ~c:   "0388dace60b6a392f328c2b971b2fe78"
         ~t:   "ab6e47d42cec13bdf53a67b21257bddf" ;
    case ~key: "feffe9928665731c6d6a8f9467308308"
         ~p:   "d9313225f88406e5a55909c5aff5269a
                86a7a9531534f7da2e4c303d8a318a72
                1c3c0c95956809532fcf0e2449a6b525
                b16aedf5aa0de657ba637b391aafd255"
         ~a:   ""
         ~nonce: "cafebabefacedbaddecaf888"
         ~c:   "42831ec2217774244b7221b784d0d49c
                e3aa212f2c02a4e035c17e2329aca12e
                21d514b25466931c7d8f6a5aac84aa05
                1ba30b396a0aac973d58e091473f5985"
         ~t:   "4d5c2af327cd64a62cf35abd2ba6fab4" ;
    case ~key: "feffe9928665731c6d6a8f9467308308"
         ~p:   "d9313225f88406e5a55909c5aff5269a
                86a7a9531534f7da2e4c303d8a318a72
                1c3c0c95956809532fcf0e2449a6b525
                b16aedf5aa0de657ba637b39"
         ~a:   "feedfacedeadbeeffeedfacedeadbeef
                abaddad2"
         ~nonce: "cafebabefacedbaddecaf888"
         ~c:   "42831ec2217774244b7221b784d0d49c
                e3aa212f2c02a4e035c17e2329aca12e
                21d514b25466931c7d8f6a5aac84aa05
                1ba30b396a0aac973d58e091"
         ~t:   "5bc94fbc3221a5db94fae95ae7121a47" ;
    case ~key: "feffe9928665731c6d6a8f9467308308"
         ~p:   "d9313225f88406e5a55909c5aff5269a
                86a7a9531534f7da2e4c303d8a318a72
                1c3c0c95956809532fcf0e2449a6b525
                b16aedf5aa0de657ba637b39"
         ~a:   "feedfacedeadbeeffeedfacedeadbeef
                abaddad2"
         ~nonce: "cafebabefacedbad"
         ~c:   "61353b4c2806934a777ff51fa22a4755
                699b2a714fcdc6f83766e5f97b6c7423
                73806900e49f24b22b097544d4896b42
                4989b5e1ebac0f07c23f4598"
         ~t:   "3612d2e79e3b0785561be14aaca2fccb" ;
    case ~key: "feffe9928665731c6d6a8f9467308308"
         ~p:   "d9313225f88406e5a55909c5aff5269a
                86a7a9531534f7da2e4c303d8a318a72
                1c3c0c95956809532fcf0e2449a6b525
                b16aedf5aa0de657ba637b39"
         ~a:   "feedfacedeadbeeffeedfacedeadbeef
                abaddad2"
         ~nonce: "9313225df88406e555909c5aff5269aa
                6a7a9538534f7da1e4c303d2a318a728
                c3c0c95156809539fcf0e2429a6b5254
                16aedbf5a0de6a57a637b39b"
         ~c:   "8ce24998625615b603a033aca13fb894
                be9112a5c3a211a8ba262a3cca7e2ca7
                01e4a9a4fba43c90ccdcb281d48c7c6f
                d62875d2aca417034c34aee5"
         ~t:   "619cc5aefffe0bfa462af43c1699d050" ;
    case ~key: "feffe9928665731c6d6a8f9467308308
                feffe9928665731c"
         ~p:   "d9313225f88406e5a55909c5aff5269a
                86a7a9531534f7da2e4c303d8a318a72
                1c3c0c95956809532fcf0e2449a6b525
                b16aedf5aa0de657ba637b39"
         ~a:   "feedfacedeadbeeffeedfacedeadbeef
                abaddad2"
         ~nonce: "cafebabefacedbaddecaf888"
         ~c:   "3980ca0b3c00e841eb06fac4872a2757
                859e1ceaa6efd984628593b40ca1e19c
                7d773d00c144c525ac619d18c84a3f47
                18e2448b2fe324d9ccda2710"
         ~t:   "2519498e80f1478f37ba55bd6d27618c" ;
    case ~key: "feffe9928665731c6d6a8f9467308308
                feffe9928665731c6d6a8f9467308308"
         ~p:   "d9313225f88406e5a55909c5aff5269a
                86a7a9531534f7da2e4c303d8a318a72
                1c3c0c95956809532fcf0e2449a6b525
                b16aedf5aa0de657ba637b39"
         ~a:   "feedfacedeadbeeffeedfacedeadbeef
                abaddad2"
         ~nonce: "9313225df88406e555909c5aff5269aa
                6a7a9538534f7da1e4c303d2a318a728
                c3c0c95156809539fcf0e2429a6b5254
                16aedbf5a0de6a57a637b39b"
         ~c:   "5a8def2f0c9e53f1f75d7853659e2a20
                eeb2b22aafde6419a058ab4f6f746bf4
                0fc0c3b780f244452da3ebf1c5d82cde
                a2418997200ef82e44ae7e3f"
         ~t:   "a44a8266ee1c8eb0c8b5d4cf5ae9f19a";
    case ~key: "00000000000000000000000000000000"  (* large GHASH batch *)
         ~p:   ""
         ~a:   "f0f0f0f0f0f0f0f00f0f0f0f0f0f0f0f
                e0e0e0e0e0e0e0e00e0e0e0e0e0e0e0e
                d0d0d0d0d0d0d0d00d0d0d0d0d0d0d0d
                c0c0c0c0c0c0c0c00c0c0c0c0c0c0c0c
                b0b0b0b0b0b0b0b00b0b0b0b0b0b0b0b
                a0a0a0a0a0a0a0a00a0a0a0a0a0a0a0a
                90909090909090900909090909090909
                80808080808080800808080808080808
                70707070707070700707070707070707
                60606060606060600606060606060606
                50505050505050500505050505050505
                40404040404040400404040404040404
                30303030303030300303030303030303
                20202020202020200202020202020202
                10101010101010100101010101010101
                00000000000000000000000000000000
                ff"
         ~nonce: "000000000000000000000000"
         ~c:   ""
         ~t:   "9bfdb8fdac1be65739780c41703c0fb6";
    case ~key: "00000000000000000000000000000002"  (* ctr rollover *)
         ~nonce: "3222415d"
         ~p:   "deadbeefdeadbeefdeadbeefdeadbeef
                deadbeefdeadbeefdeadbeefdeadbeef
                deadbeef"
         ~a:   ""
         ~c:   "42627ce3de61b5c105c7f01629c031c1
                b890bb273b6b6bc26b56c801f87fa95c
                a8b37503"
         ~t:   "3631cbe44782713b93b1c7d93c3c8638"
]


   let check (key, p, adata, nonce, c, t) =
    (* let open Cipher_block in  *)
    let cipher = AES.GCM.authenticate_encrypt ~key ~nonce ~adata p in
    let pdata = 
    match AES.GCM.authenticate_decrypt ~key ~nonce ~adata cipher with
    | None -> raise (GCM_Decryption_Broken "GCM decryption broken")
    | Some data -> data
    in
    let _ = check_cipher_text (Cstruct.append c t) cipher in
    let _ = check_plain_text p pdata in ()

    let cases_of f aes_data = List.iter f aes_data

    let start _time =
        (* let open Cipher_block in *)
        List.iter check aes_gcm_data;
        Lwt.return_unit
end