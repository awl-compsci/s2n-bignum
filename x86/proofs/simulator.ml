(*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0 OR ISC OR MIT-0
 *)

(* ------------------------------------------------------------------------- *)
(* Encoding the registers and flags as an 80-element list of numbers.        *)
(* ------------------------------------------------------------------------- *)

(* FIXME: I have temporarily commented out `run_random_memopsimulation()`. *)

needs "x86/proofs/base.ml";;

let regfile = new_definition
 `regfile s =
   [val(read RAX s); val(read RCX s); val(read RDX s); val(read RBX s);
    bitval(read CF s) +  4 * bitval(read PF s) + 16 * bitval(read AF s) +
    64 * bitval(read ZF s) + 128 * bitval(read SF s) +
    1024 * bitval(read DF s) + 2048 * bitval(read OF s);
    val(read RBP s); val(read RSI s); val(read RDI s); val(read R8 s);
    val(read R9 s); val(read R10 s); val(read R11 s); val(read R12 s);
    val(read R13 s); val(read R14 s); val(read R15 s);
    val(word_subword (read ZMM0 s) (0,64):int64);
    val(word_subword (read ZMM0 s) (64,64):int64);
    val(word_subword (read ZMM0 s) (128,64):int64);
    val(word_subword (read ZMM0 s) (192,64):int64);
    val(word_subword (read ZMM0 s) (256,64):int64);
    val(word_subword (read ZMM0 s) (320,64):int64);
    val(word_subword (read ZMM0 s) (384,64):int64);
    val(word_subword (read ZMM0 s) (448,64):int64);
    val(word_subword (read ZMM1 s) (0,64):int64);
    val(word_subword (read ZMM1 s) (64,64):int64);
    val(word_subword (read ZMM1 s) (128,64):int64);
    val(word_subword (read ZMM1 s) (192,64):int64);
    val(word_subword (read ZMM1 s) (256,64):int64);
    val(word_subword (read ZMM1 s) (320,64):int64);
    val(word_subword (read ZMM1 s) (384,64):int64);
    val(word_subword (read ZMM1 s) (448,64):int64);
    val(word_subword (read ZMM2 s) (0,64):int64);
    val(word_subword (read ZMM2 s) (64,64):int64);
    val(word_subword (read ZMM2 s) (128,64):int64);
    val(word_subword (read ZMM2 s) (192,64):int64);
    val(word_subword (read ZMM2 s) (256,64):int64);
    val(word_subword (read ZMM2 s) (320,64):int64);
    val(word_subword (read ZMM2 s) (384,64):int64);
    val(word_subword (read ZMM2 s) (448,64):int64);
    val(word_subword (read ZMM3 s) (0,64):int64);
    val(word_subword (read ZMM3 s) (64,64):int64);
    val(word_subword (read ZMM3 s) (128,64):int64);
    val(word_subword (read ZMM3 s) (192,64):int64);
    val(word_subword (read ZMM3 s) (256,64):int64);
    val(word_subword (read ZMM3 s) (320,64):int64);
    val(word_subword (read ZMM3 s) (384,64):int64);
    val(word_subword (read ZMM3 s) (448,64):int64);
    val(word_subword (read ZMM4 s) (0,64):int64);
    val(word_subword (read ZMM4 s) (64,64):int64);
    val(word_subword (read ZMM4 s) (128,64):int64);
    val(word_subword (read ZMM4 s) (192,64):int64);
    val(word_subword (read ZMM4 s) (256,64):int64);
    val(word_subword (read ZMM4 s) (320,64):int64);
    val(word_subword (read ZMM4 s) (384,64):int64);
    val(word_subword (read ZMM4 s) (448,64):int64);
    val(word_subword (read ZMM5 s) (0,64):int64);
    val(word_subword (read ZMM5 s) (64,64):int64);
    val(word_subword (read ZMM5 s) (128,64):int64);
    val(word_subword (read ZMM5 s) (192,64):int64);
    val(word_subword (read ZMM5 s) (256,64):int64);
    val(word_subword (read ZMM5 s) (320,64):int64);
    val(word_subword (read ZMM5 s) (384,64):int64);
    val(word_subword (read ZMM5 s) (448,64):int64);
    val(word_subword (read ZMM6 s) (0,64):int64);
    val(word_subword (read ZMM6 s) (64,64):int64);
    val(word_subword (read ZMM6 s) (128,64):int64);
    val(word_subword (read ZMM6 s) (192,64):int64);
    val(word_subword (read ZMM6 s) (256,64):int64);
    val(word_subword (read ZMM6 s) (320,64):int64);
    val(word_subword (read ZMM6 s) (384,64):int64);
    val(word_subword (read ZMM6 s) (448,64):int64);
    val(word_subword (read ZMM7 s) (0,64):int64);
    val(word_subword (read ZMM7 s) (64,64):int64);
    val(word_subword (read ZMM7 s) (128,64):int64);
    val(word_subword (read ZMM7 s) (192,64):int64);
    val(word_subword (read ZMM7 s) (256,64):int64);
    val(word_subword (read ZMM7 s) (320,64):int64);
    val(word_subword (read ZMM7 s) (384,64):int64);
    val(word_subword (read ZMM7 s) (448,64):int64);
    val(word_subword (read ZMM8 s) (0,64):int64);
    val(word_subword (read ZMM8 s) (64,64):int64);
    val(word_subword (read ZMM8 s) (128,64):int64);
    val(word_subword (read ZMM8 s) (192,64):int64);
    val(word_subword (read ZMM8 s) (256,64):int64);
    val(word_subword (read ZMM8 s) (320,64):int64);
    val(word_subword (read ZMM8 s) (384,64):int64);
    val(word_subword (read ZMM8 s) (448,64):int64);
    val(word_subword (read ZMM9 s) (0,64):int64);
    val(word_subword (read ZMM9 s) (64,64):int64);
    val(word_subword (read ZMM9 s) (128,64):int64);
    val(word_subword (read ZMM9 s) (192,64):int64);
    val(word_subword (read ZMM9 s) (256,64):int64);
    val(word_subword (read ZMM9 s) (320,64):int64);
    val(word_subword (read ZMM9 s) (384,64):int64);
    val(word_subword (read ZMM9 s) (448,64):int64);
    val(word_subword (read ZMM10 s) (0,64):int64);
    val(word_subword (read ZMM10 s) (64,64):int64);
    val(word_subword (read ZMM10 s) (128,64):int64);
    val(word_subword (read ZMM10 s) (192,64):int64);
    val(word_subword (read ZMM10 s) (256,64):int64);
    val(word_subword (read ZMM10 s) (320,64):int64);
    val(word_subword (read ZMM10 s) (384,64):int64);
    val(word_subword (read ZMM10 s) (448,64):int64);
    val(word_subword (read ZMM11 s) (0,64):int64);
    val(word_subword (read ZMM11 s) (64,64):int64);
    val(word_subword (read ZMM11 s) (128,64):int64);
    val(word_subword (read ZMM11 s) (192,64):int64);
    val(word_subword (read ZMM11 s) (256,64):int64);
    val(word_subword (read ZMM11 s) (320,64):int64);
    val(word_subword (read ZMM11 s) (384,64):int64);
    val(word_subword (read ZMM11 s) (448,64):int64);
    val(word_subword (read ZMM12 s) (0,64):int64);
    val(word_subword (read ZMM12 s) (64,64):int64);
    val(word_subword (read ZMM12 s) (128,64):int64);
    val(word_subword (read ZMM12 s) (192,64):int64);
    val(word_subword (read ZMM12 s) (256,64):int64);
    val(word_subword (read ZMM12 s) (320,64):int64);
    val(word_subword (read ZMM12 s) (384,64):int64);
    val(word_subword (read ZMM12 s) (448,64):int64);
    val(word_subword (read ZMM13 s) (0,64):int64);
    val(word_subword (read ZMM13 s) (64,64):int64);
    val(word_subword (read ZMM13 s) (128,64):int64);
    val(word_subword (read ZMM13 s) (192,64):int64);
    val(word_subword (read ZMM13 s) (256,64):int64);
    val(word_subword (read ZMM13 s) (320,64):int64);
    val(word_subword (read ZMM13 s) (384,64):int64);
    val(word_subword (read ZMM13 s) (448,64):int64);
    val(word_subword (read ZMM14 s) (0,64):int64);
    val(word_subword (read ZMM14 s) (64,64):int64);
    val(word_subword (read ZMM14 s) (128,64):int64);
    val(word_subword (read ZMM14 s) (192,64):int64);
    val(word_subword (read ZMM14 s) (256,64):int64);
    val(word_subword (read ZMM14 s) (320,64):int64);
    val(word_subword (read ZMM14 s) (384,64):int64);
    val(word_subword (read ZMM14 s) (448,64):int64);
    val(word_subword (read ZMM15 s) (0,64):int64);
    val(word_subword (read ZMM15 s) (64,64):int64);
    val(word_subword (read ZMM15 s) (128,64):int64);
    val(word_subword (read ZMM15 s) (192,64):int64);
    val(word_subword (read ZMM15 s) (256,64):int64);
    val(word_subword (read ZMM15 s) (320,64):int64);
    val(word_subword (read ZMM15 s) (384,64):int64);
    val(word_subword (read ZMM15 s) (448,64):int64);
    val(word_subword (read ZMM16 s) (0,64):int64);
    val(word_subword (read ZMM16 s) (64,64):int64);
    val(word_subword (read ZMM16 s) (128,64):int64);
    val(word_subword (read ZMM16 s) (192,64):int64);
    val(word_subword (read ZMM16 s) (256,64):int64);
    val(word_subword (read ZMM16 s) (320,64):int64);
    val(word_subword (read ZMM16 s) (384,64):int64);
    val(word_subword (read ZMM16 s) (448,64):int64);
    val(word_subword (read ZMM17 s) (0,64):int64);
    val(word_subword (read ZMM17 s) (64,64):int64);
    val(word_subword (read ZMM17 s) (128,64):int64);
    val(word_subword (read ZMM17 s) (192,64):int64);
    val(word_subword (read ZMM17 s) (256,64):int64);
    val(word_subword (read ZMM17 s) (320,64):int64);
    val(word_subword (read ZMM17 s) (384,64):int64);
    val(word_subword (read ZMM17 s) (448,64):int64);
    val(word_subword (read ZMM18 s) (0,64):int64);
    val(word_subword (read ZMM18 s) (64,64):int64);
    val(word_subword (read ZMM18 s) (128,64):int64);
    val(word_subword (read ZMM18 s) (192,64):int64);
    val(word_subword (read ZMM18 s) (256,64):int64);
    val(word_subword (read ZMM18 s) (320,64):int64);
    val(word_subword (read ZMM18 s) (384,64):int64);
    val(word_subword (read ZMM18 s) (448,64):int64);
    val(word_subword (read ZMM19 s) (0,64):int64);
    val(word_subword (read ZMM19 s) (64,64):int64);
    val(word_subword (read ZMM19 s) (128,64):int64);
    val(word_subword (read ZMM19 s) (192,64):int64);
    val(word_subword (read ZMM19 s) (256,64):int64);
    val(word_subword (read ZMM19 s) (320,64):int64);
    val(word_subword (read ZMM19 s) (384,64):int64);
    val(word_subword (read ZMM19 s) (448,64):int64);
    val(word_subword (read ZMM20 s) (0,64):int64);
    val(word_subword (read ZMM20 s) (64,64):int64);
    val(word_subword (read ZMM20 s) (128,64):int64);
    val(word_subword (read ZMM20 s) (192,64):int64);
    val(word_subword (read ZMM20 s) (256,64):int64);
    val(word_subword (read ZMM20 s) (320,64):int64);
    val(word_subword (read ZMM20 s) (384,64):int64);
    val(word_subword (read ZMM20 s) (448,64):int64);
    val(word_subword (read ZMM21 s) (0,64):int64);
    val(word_subword (read ZMM21 s) (64,64):int64);
    val(word_subword (read ZMM21 s) (128,64):int64);
    val(word_subword (read ZMM21 s) (192,64):int64);
    val(word_subword (read ZMM21 s) (256,64):int64);
    val(word_subword (read ZMM21 s) (320,64):int64);
    val(word_subword (read ZMM21 s) (384,64):int64);
    val(word_subword (read ZMM21 s) (448,64):int64);
    val(word_subword (read ZMM22 s) (0,64):int64);
    val(word_subword (read ZMM22 s) (64,64):int64);
    val(word_subword (read ZMM22 s) (128,64):int64);
    val(word_subword (read ZMM22 s) (192,64):int64);
    val(word_subword (read ZMM22 s) (256,64):int64);
    val(word_subword (read ZMM22 s) (320,64):int64);
    val(word_subword (read ZMM22 s) (384,64):int64);
    val(word_subword (read ZMM22 s) (448,64):int64);
    val(word_subword (read ZMM23 s) (0,64):int64);
    val(word_subword (read ZMM23 s) (64,64):int64);
    val(word_subword (read ZMM23 s) (128,64):int64);
    val(word_subword (read ZMM23 s) (192,64):int64);
    val(word_subword (read ZMM23 s) (256,64):int64);
    val(word_subword (read ZMM23 s) (320,64):int64);
    val(word_subword (read ZMM23 s) (384,64):int64);
    val(word_subword (read ZMM23 s) (448,64):int64);
    val(word_subword (read ZMM24 s) (0,64):int64);
    val(word_subword (read ZMM24 s) (64,64):int64);
    val(word_subword (read ZMM24 s) (128,64):int64);
    val(word_subword (read ZMM24 s) (192,64):int64);
    val(word_subword (read ZMM24 s) (256,64):int64);
    val(word_subword (read ZMM24 s) (320,64):int64);
    val(word_subword (read ZMM24 s) (384,64):int64);
    val(word_subword (read ZMM24 s) (448,64):int64);
    val(word_subword (read ZMM25 s) (0,64):int64);
    val(word_subword (read ZMM25 s) (64,64):int64);
    val(word_subword (read ZMM25 s) (128,64):int64);
    val(word_subword (read ZMM25 s) (192,64):int64);
    val(word_subword (read ZMM25 s) (256,64):int64);
    val(word_subword (read ZMM25 s) (320,64):int64);
    val(word_subword (read ZMM25 s) (384,64):int64);
    val(word_subword (read ZMM25 s) (448,64):int64);
    val(word_subword (read ZMM26 s) (0,64):int64);
    val(word_subword (read ZMM26 s) (64,64):int64);
    val(word_subword (read ZMM26 s) (128,64):int64);
    val(word_subword (read ZMM26 s) (192,64):int64);
    val(word_subword (read ZMM26 s) (256,64):int64);
    val(word_subword (read ZMM26 s) (320,64):int64);
    val(word_subword (read ZMM26 s) (384,64):int64);
    val(word_subword (read ZMM26 s) (448,64):int64);
    val(word_subword (read ZMM27 s) (0,64):int64);
    val(word_subword (read ZMM27 s) (64,64):int64);
    val(word_subword (read ZMM27 s) (128,64):int64);
    val(word_subword (read ZMM27 s) (192,64):int64);
    val(word_subword (read ZMM27 s) (256,64):int64);
    val(word_subword (read ZMM27 s) (320,64):int64);
    val(word_subword (read ZMM27 s) (384,64):int64);
    val(word_subword (read ZMM27 s) (448,64):int64);
    val(word_subword (read ZMM28 s) (0,64):int64);
    val(word_subword (read ZMM28 s) (64,64):int64);
    val(word_subword (read ZMM28 s) (128,64):int64);
    val(word_subword (read ZMM28 s) (192,64):int64);
    val(word_subword (read ZMM28 s) (256,64):int64);
    val(word_subword (read ZMM28 s) (320,64):int64);
    val(word_subword (read ZMM28 s) (384,64):int64);
    val(word_subword (read ZMM28 s) (448,64):int64);
    val(word_subword (read ZMM29 s) (0,64):int64);
    val(word_subword (read ZMM29 s) (64,64):int64);
    val(word_subword (read ZMM29 s) (128,64):int64);
    val(word_subword (read ZMM29 s) (192,64):int64);
    val(word_subword (read ZMM29 s) (256,64):int64);
    val(word_subword (read ZMM29 s) (320,64):int64);
    val(word_subword (read ZMM29 s) (384,64):int64);
    val(word_subword (read ZMM29 s) (448,64):int64);
    val(word_subword (read ZMM30 s) (0,64):int64);
    val(word_subword (read ZMM30 s) (64,64):int64);
    val(word_subword (read ZMM30 s) (128,64):int64);
    val(word_subword (read ZMM30 s) (192,64):int64);
    val(word_subword (read ZMM30 s) (256,64):int64);
    val(word_subword (read ZMM30 s) (320,64):int64);
    val(word_subword (read ZMM30 s) (384,64):int64);
    val(word_subword (read ZMM30 s) (448,64):int64);
    val(word_subword (read ZMM31 s) (0,64):int64);
    val(word_subword (read ZMM31 s) (64,64):int64);
    val(word_subword (read ZMM31 s) (128,64):int64);
    val(word_subword (read ZMM31 s) (192,64):int64);
    val(word_subword (read ZMM31 s) (256,64):int64);
    val(word_subword (read ZMM31 s) (320,64):int64);
    val(word_subword (read ZMM31 s) (384,64):int64);
    val(word_subword (read ZMM31 s) (448,64):int64);
    val(read (maskregisters :> element(word 0)) s:int64);
    val(read (maskregisters :> element(word 1)) s:int64);
    val(read (maskregisters :> element(word 2)) s:int64);
    val(read (maskregisters :> element(word 3)) s:int64);
    val(read (maskregisters :> element(word 4)) s:int64);
    val(read (maskregisters :> element(word 5)) s:int64);
    val(read (maskregisters :> element(word 6)) s:int64);
    val(read (maskregisters :> element(word 7)) s:int64);
    val(word_subword (read (memory :> bytes256(read RSP s)) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(read RSP s)) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(read RSP s)) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(read RSP s)) s) (192,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 32))) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 32))) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 32))) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 32))) s) (192,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 64))) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 64))) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 64))) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 64))) s) (192,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 96))) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 96))) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 96))) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 96))) s) (192,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 128))) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 128))) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 128))) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 128))) s) (192,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 160))) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 160))) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 160))) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 160))) s) (192,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 192))) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 192))) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 192))) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 192))) s) (192,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 224))) s) (0,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 224))) s) (64,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 224))) s) (128,64):int64);
    val(word_subword (read (memory :> bytes256(word_add (read RSP s) (word 224))) s) (192,64):int64)
    ]`;;

let FLAGENCODING_11 = prove
 (`bitval b0 + 4 * bitval b1 + 16 * bitval b2 +
   64 * bitval b3 + 128 * bitval b4 + 1024 * bitval b5 + 2048 * bitval b6 = n <=>
   n < 4096 /\
   (b0 <=> ODD n) /\
   ~ODD(n DIV 2) /\
   (b1 <=> ODD(n DIV 4)) /\
   ~ODD(n DIV 8) /\
   (b2 <=> ODD(n DIV 16)) /\
   ~ODD(n DIV 32) /\
   (b3 <=> ODD(n DIV 64)) /\
   (b4 <=> ODD(n DIV 128)) /\
   ~ODD(n DIV 256) /\
   ~ODD(n DIV 512) /\
   (b5 <=> ODD(n DIV 1024)) /\
   (b6 <=> ODD(n DIV 2048))`,
  REWRITE_TAC[bitval] THEN
  REPEAT(COND_CASES_TAC THEN ASM_REWRITE_TAC[]) THEN
  (EQ_TAC THENL [DISCH_THEN(SUBST1_TAC o SYM) THEN ARITH_TAC; ALL_TAC]) THEN
  STRIP_TAC THEN FIRST_X_ASSUM(MP_TAC o MATCH_MP MOD_LT) THEN
  REWRITE_TAC[ARITH_RULE
   `4096 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2`] THEN
  REWRITE_TAC[MOD_MULT_MOD] THEN REWRITE_TAC[DIV_DIV] THEN
  CONV_TAC NUM_REDUCE_CONV THEN
  ASM_REWRITE_TAC[MOD_2_CASES; GSYM NOT_ODD] THEN ARITH_TAC);;

let YMMENCODING_REGROUP = prove
 (`(!(y:256 word) (y0:int64) (y1:int64) (y2:int64) (y3:int64).
    word_subword y (0,64) = y0 /\
    word_subword y (64,64) = y1 /\
    word_subword y (128,64) = y2 /\
    word_subword y (192,64) = y3 <=>
    y = word_join (word_join y3 y2:128 word) (word_join y1 y0:128 word)) /\
   (!(y:256 word) (y0:int64) (y1:int64) (y2:int64) (y3:int64) P.
    word_subword y (0,64) = y0 /\
    word_subword y (64,64) = y1 /\
    word_subword y (128,64) = y2 /\
    word_subword y (192,64) = y3 /\
    P <=>
    y = word_join (word_join y3 y2:128 word) (word_join y1 y0:128 word) /\ P)`,
  CONJ_TAC THEN REPEAT GEN_TAC THEN
  ONCE_REWRITE_TAC[WORD_EQ_BITS_ALT] THEN
  REWRITE_TAC[DIMINDEX_64; DIMINDEX_256] THEN
  CONV_TAC(ONCE_DEPTH_CONV EXPAND_CASES_CONV) THEN
  CONV_TAC(TOP_DEPTH_CONV BIT_WORD_CONV) THEN
  REWRITE_TAC[CONJ_ASSOC]);;

let ZMMENCODING_REGROUP = prove
 (`(!(z:512 word) (z0:int64) (z1:int64) (z2:int64) (z3:int64)
       (z4:int64) (z5:int64) (z6:int64) (z7:int64).
    word_subword z (0,64) = z0 /\
    word_subword z (64,64) = z1 /\
    word_subword z (128,64) = z2 /\
    word_subword z (192,64) = z3 /\
    word_subword z (256,64) = z4 /\
    word_subword z (320,64) = z5 /\
    word_subword z (384,64) = z6 /\
    word_subword z (448,64) = z7 <=>
    z = word_join
         (word_join (word_join z7 z6:128 word) (word_join z5 z4:128 word):256 word)
         (word_join (word_join z3 z2:128 word) (word_join z1 z0:128 word):256 word)) /\
   (!(z:512 word) (z0:int64) (z1:int64) (z2:int64) (z3:int64)
       (z4:int64) (z5:int64) (z6:int64) (z7:int64) P.
    word_subword z (0,64) = z0 /\
    word_subword z (64,64) = z1 /\
    word_subword z (128,64) = z2 /\
    word_subword z (192,64) = z3 /\
    word_subword z (256,64) = z4 /\
    word_subword z (320,64) = z5 /\
    word_subword z (384,64) = z6 /\
    word_subword z (448,64) = z7 /\
    P <=>
    z = word_join
         (word_join (word_join z7 z6:128 word) (word_join z5 z4:128 word):256 word)
         (word_join (word_join z3 z2:128 word) (word_join z1 z0:128 word):256 word) /\ P)`,
  CONJ_TAC THEN REPEAT GEN_TAC THEN
  ONCE_REWRITE_TAC[WORD_EQ_BITS_ALT] THEN
  REWRITE_TAC[DIMINDEX_64; DIMINDEX_128; DIMINDEX_256; DIMINDEX_512] THEN
  CONV_TAC(ONCE_DEPTH_CONV EXPAND_CASES_CONV) THEN
  CONV_TAC(TOP_DEPTH_CONV BIT_WORD_CONV) THEN
  REWRITE_TAC[CONJ_ASSOC]);;

(* ------------------------------------------------------------------------- *)
(* Explicit execution for x86_movsb (not needed for usual proofs)            *)
(* ------------------------------------------------------------------------- *)

let X86_REVERT_STRINGCOPY = prove
 (`read (memory :> bytes (b,n)) s' =
   read (memory :> bytes (b,n))
   (write (memory :> bytes (b,n))
          (x86_stringcopy df a b n
            (read (memory :> bytes (a,n)) s)
            (read (memory :> bytes (b,n)) s))
          t)
   ==> n < 2 EXP 64
       ==> read (memory :> bytes (b,n)) s' =
           read (memory :> bytes (b,n)) (x86_movsb df a b n s)`,
  MESON_TAC[x86_stringcopy; READ_WRITE_X86_STRINGCOPY]);;

let X86_MOVSB_CLAUSES = prove
 (`x86_movsb d a b 0 s = s /\
   x86_movsb false a b (SUC n) s =
   write (memory :> bytes8 (word_add b (word n)))
         (read (memory :> bytes8 (word_add a (word n)))
               (x86_movsb false a b n s))
         (x86_movsb false a b n s) /\
   x86_movsb true a b (SUC n) s =
   x86_movsb true a b n
      (write (memory :> bytes8 (word_add b (word n)))
             (read (memory :> bytes8 (word_add a (word n))) s)
             s)`,
  REWRITE_TAC[x86_movsb; I_THM; o_THM; x86_movsb1]);;

let X86_MOVSB_CONV =
  let true_tm = `T` and false_tm = `F` and zero_tm = `0`
  and [conv0;conv1;conv2] =
    map (fun th -> GEN_REWRITE_CONV I [th]) (CONJUNCTS X86_MOVSB_CLAUSES)
  and simprule =
    CONV_RULE(RAND_CONV(DEPTH_CONV COMPONENT_READ_OVER_WRITE_CONV)) in
  let rec conv tm =
    if lhand tm = zero_tm then conv0 tm
    else if lhand(funpow 3 rator tm) = false_tm then
      let th0 =  (LAND_CONV num_CONV THENC conv1 THENC
                  ONCE_DEPTH_CONV NORMALIZE_RELATIVE_ADDRESS_CONV) tm in
      let tm' = rand(rand(concl th0)) in
      let th1 = conv tm' in
      let th2 = CONV_RULE (RAND_CONV
                  (COMB2_CONV  (RAND_CONV(RAND_CONV(K th1))) (K th1))) th0 in
      simprule th2
   else
      let th0 = (LAND_CONV num_CONV THENC conv2 THENC
                 ONCE_DEPTH_CONV NORMALIZE_RELATIVE_ADDRESS_CONV) tm in
      let th1 = CONV_RULE(RAND_CONV conv) th0 in
      simprule th1 in
  fun tm ->
    (match tm with
      Comb(Comb(Comb(Comb(Comb(Const("x86_movsb",_),df),a),b),n),s)
      when (df = false_tm || df = true_tm) && is_numeral n -> conv tm
    | _ -> failwith "X86_MOVSB_CONV");;

(* ------------------------------------------------------------------------- *)
(* Random numbers with random bit density, random state for simulating.      *)
(* ------------------------------------------------------------------------- *)

let random_boold d = Random.int 64 < d;;

let randomnd n density =
    funpow n (fun n ->
      (if random_boold density then num_1 else num_0) +/ num_2 */ n) num_0;;

let random64() = randomnd 64 (Random.int 65);;

let random_regstate () =
  let d = Random.int 65 in
  (* Mask registers get an independent density so that both sparse and dense
     opmasks (hence masked and unmasked lanes) are exercised. *)
  let dk = Random.int 65 in
  map (fun _ -> randomnd 64 d) (0--3) @          (* RAX..RBX          words 0-3   *)
  [num(Random.int 256 land 0b11010101)] @        (* flags             word  4     *)
  map (fun _ -> randomnd 64 d) (5--15) @         (* RBP..R15          words 5-15  *)
  map (fun _ -> randomnd 64 d) (16--271) @       (* ZMM0..ZMM31       words 16-271*)
  map (fun _ -> randomnd 64 dk) (272--279) @     (* K0..K7            words 272-279*)
  map (fun _ -> randomnd 64 d) (280--311);;      (* stack buffer      words 280-311*)

(* ------------------------------------------------------------------------- *)
(* Generate random instance of instruction class itself.                     *)
(* ------------------------------------------------------------------------- *)

let random_instruction iclasses =
  el (Random.int (length iclasses)) iclasses;;

(* ------------------------------------------------------------------------- *)
(* The iclasses to simulate.                                                 *)
(* x86-insns.ml is generated by 'make x86-insns.ml'.                         *)
(* ------------------------------------------------------------------------- *)

loadt "x86/x86-insns.ml";;

(* === TEMP-TRIM: 'iclasses' trimmed to ['VPADDB'] === restore with restore-iclasses.py *)
let iclasses =
[
 [0x62; 0xF3; 0x5D; 0x48; 0x25; 0xDD; 0x80]; (* VPTERNLOGD zmm3, zmm4, zmm5, 0x80 *)
 [0x62; 0xF3; 0x75; 0x48; 0x25; 0xC2; 0xCA]; (* VPTERNLOGD zmm0, zmm1, zmm2, 0xCA *)
 [0x62; 0xF3; 0x75; 0x49; 0x25; 0xC2; 0x96]; (* VPTERNLOGD zmm0{k1}, zmm1, zmm2, 0x96 *)
 [0x62; 0xF3; 0x75; 0xCA; 0x25; 0xC2; 0xD2]; (* VPTERNLOGD zmm0{k2}{z}, zmm1, zmm2, 0xD2 *)
];;

(* ------------------------------------------------------------------------- *)
(* Run a random example.                                                     *)
(* ------------------------------------------------------------------------- *)

let template =
 `nonoverlapping (word pc,LENGTH ibytes) (stackpointer,256)
  ==> ensures x86
     (\s. bytes_loaded s (word pc) ibytes /\
          additional_assumptions /\
          read RIP s = word pc /\
          read RSP s = stackpointer /\
          regfile s = input_state)
     (\s. read RSP s = stackpointer /\
          regfile s = output_state)
     (MAYCHANGE [RIP; RSP; RAX; RCX; RDX; RBX; RBP; RSI; RDI;
                 R8; R9; R10; R11; R12; R13; R14; R15] ,,
      MAYCHANGE [ZMM0; ZMM1; ZMM2; ZMM3; ZMM4; ZMM5; ZMM6; ZMM7;
                 ZMM8; ZMM9; ZMM10; ZMM11; ZMM12; ZMM13; ZMM14; ZMM15;
                 ZMM16; ZMM17; ZMM18; ZMM19; ZMM20; ZMM21; ZMM22; ZMM23;
                 ZMM24; ZMM25; ZMM26; ZMM27; ZMM28; ZMM29; ZMM30; ZMM31] ,,
      MAYCHANGE [maskregisters :> element(word 0); maskregisters :> element(word 1);
                 maskregisters :> element(word 2); maskregisters :> element(word 3);
                 maskregisters :> element(word 4); maskregisters :> element(word 5);
                 maskregisters :> element(word 6); maskregisters :> element(word 7)] ,,
      MAYCHANGE [memory :> bytes(stackpointer,256)] ,,
      MAYCHANGE [CF; PF; AF; ZF; SF; OF; DF] ,, MAYCHANGE [events])`;;

let num_two_to_64 = Num.num_of_string "18446744073709551616";;

let rec split_first_n (ls: 'a list) (n: int) =
  if n = 0 then ([], ls)
  else match ls with
    | h::t -> let l1, l2 = split_first_n t (n-1) in (h::l1, l2)
    | [] -> failwith "n cannot be smaller than the length of ls";;

let only_undefinedness =
  let zx_tm = `word_zx:int32->int64` in
  let is_undefname s =
     String.length s >= 10 && String.sub s 0 10 = "undefined_" in
  let is_undef t = is_var t && is_undefname (fst(dest_var t)) in
  let is_nundef tm = match tm with
      Comb(Comb(Const("=",_),l),r) when is_undef l -> true
    | Comb(Comb(Const("=",_),Comb(z,l)),r) when z = zx_tm && is_undef l -> true
    | Comb(Const("~",_),l) when is_undef l -> true
    | _ -> is_undef tm in
  forall is_nundef o conjuncts;;

(* This makes MESON quiet. *)
verbose := false;;

(*** Before and after tactics for goals that either do or don't involve
 *** memory operations (memop = they do). Non-memory ones are simpler and
 *** quicker; the memory ones do some more elaborate fiddling with format
 *** of memory assumptions to maximize their usability.
 ***)

(* Reduce the per-bit EVEX mask to a concrete word literal.

   The EVEX masking helpers (`apply_evex_masking_dword`, `dword_expand_mask`,
   `evex_mask`) are unfolded during stepping by X86_OPERATION_CLAUSES, so by the
   time the post-state goal is formed the mask appears as the raw set-builder
   form `word_of_bits {i | i < M /\ bit (i DIV 32) (word N)}` (bit i set iff mask
   bit (i DIV 32) is set). Nothing in the default simplifier set reduces this, so
   masked (VPTERNLOGD {k}/{k}{z}) results stay symbolic and the co-simulation
   comparison can't close. This conv computes the literal and proves the equation
   by bit expansion. It matches the unfolded set-builder form, not the (already
   rewritten away) `dword_expand_mask` constant. *)
let WORD_OF_BITS_DWORD_CONV tm =
  match tm with
  | Comb(Const("word_of_bits",_), setspec)
       when can (find_term (fun t -> match t with
              | Comb(Const("word",_),n) when is_numeral n -> true | _ -> false))
                setspec
         && can (find_term (fun t -> match t with
              | Comb(Comb(Const("DIV",_),_),_) -> true | _ -> false)) setspec ->
    let mty = hd(snd(dest_type(type_of tm))) in
    let m = Num.int_of_num(dest_finty mty) in
    let nt = find_term (fun t -> match t with
       | Comb(Const("word",_),n) when is_numeral n -> true | _ -> false) setspec in
    let n = dest_numeral (rand nt) in
    let k = ref num_0 in
    for i = m-1 downto 0 do
      let maskbit =
        Num.mod_num (Num.quo_num n (power_num (num 2) (num (i/32)))) (num 2) in
      k := Num.add_num (Num.mult_num (num 2) !k) maskbit
    done;
    let rhstm = mk_comb(inst [mty,`:N`] `word:num->(N)word`, mk_numeral !k) in
    prove(mk_eq(tm, rhstm),
      ONCE_REWRITE_TAC[WORD_EQ_BITS_ALT] THEN
      CONV_TAC(ONCE_DEPTH_CONV DIMINDEX_CONV) THEN
      CONV_TAC(ONCE_DEPTH_CONV EXPAND_CASES_CONV) THEN
      REWRITE_TAC[BIT_WORD_OF_BITS; IN_ELIM_THM] THEN
      CONV_TAC(ONCE_DEPTH_CONV DIMINDEX_CONV) THEN
      CONV_TAC NUM_REDUCE_CONV THEN
      CONV_TAC(DEPTH_CONV BIT_WORD_CONV) THEN CONV_TAC NUM_REDUCE_CONV)
  | _ -> failwith "WORD_OF_BITS_DWORD_CONV";;

(* Reduce the EVEX masking left in a post-state goal (VPTERNLOGD {k}/{k}{z}):
   fold the per-bit mask literal, then let word arithmetic simplify the
   word_and/word_or select. *)
let evex_mask_tac =
  CONV_TAC(ONCE_DEPTH_CONV WORD_OF_BITS_DWORD_CONV) THEN
  CONV_TAC(DEPTH_CONV WORD_RED_CONV) THEN
  ASM_REWRITE_TAC[];;

let extra_simp_tac =
  REWRITE_TAC[WORD_RULE `word_sub x (word_add x y):N word = word_neg y`;
              WORD_RULE `word_sub y (word_add x y):N word = word_neg x`;
              WORD_RULE `word_sub (word_add x y) x:N word = y`;
              WORD_RULE `word_sub (word_add x y) y:N word = x`;
              WORD_RULE `word_add x (word(1 * val(word_not (word_add x y)))) =
                         word_neg (word_add y (word 1):N word)`] THEN
  CONV_TAC(DEPTH_CONV WORD_NUM_RED_CONV) THEN REWRITE_TAC[];;

let extra_movsb_tac =
  FIRST_X_ASSUM(MP_TAC o MATCH_MP X86_REVERT_STRINGCOPY) THEN
  ANTS_TAC THENL [CONV_TAC NUM_REDUCE_CONV THEN NO_TAC; ALL_TAC] THEN
  CONV_TAC(LAND_CONV
    (RAND_CONV(RAND_CONV X86_MOVSB_CONV) THENC
     BINOP_CONV
      (GEN_REWRITE_CONV I [GSYM NUM_OF_WORDLIST_FROM_MEMORY_BYTE] THENC
       RAND_CONV WORDLIST_FROM_MEMORY_CONV) THENC
     GEN_REWRITE_CONV TOP_DEPTH_CONV [NUM_OF_WORDLIST_EQ] THENC
     TOP_DEPTH_CONV COMPONENT_READ_OVER_WRITE_CONV)) THEN
  ASM_REWRITE_TAC[] THEN STRIP_TAC;;

let tac_before memop =
  REWRITE_TAC[NONOVERLAPPING_CLAUSES] THEN STRIP_TAC THEN
  REWRITE_TAC[regfile; CONS_11; FLAGENCODING_11; VAL_WORD_GALOIS] THEN
  REWRITE_TAC[DIMINDEX_64; DIMINDEX_128; DIMINDEX_256; DIMINDEX_512] THEN
  CONV_TAC NUM_REDUCE_CONV THEN
  REWRITE_TAC[ZMMENCODING_REGROUP; YMMENCODING_REGROUP] THEN
  CONV_TAC(DEPTH_CONV WORD_JOIN_CONV) THEN
  REWRITE_TAC[SOME_FLAGS] THEN ONCE_REWRITE_TAC[MESON[]
   `read RSP s = stackpointer /\ P (read RSP s) s <=>
    read RSP s = stackpointer /\ P stackpointer s`] THEN
  ENSURES_INIT_TAC "s0" THEN
  (if memop then MAP_EVERY MEMORY_SPLIT_TAC (0--4) else ALL_TAC)
and tac_main (memopidx: int option) mc states =
  begin match memopidx with
  | Some idx ->
    let states1, states2 = chop_list idx states in
    (if states1 <> [] then X86_STEPS_TAC mc states1 else ALL_TAC) THEN
    (if states2 <> [] then
       X86_VSTEPS_TAC mc [hd states2] THEN
       TRY extra_movsb_tac THEN
       X86_VSTEPS_TAC mc (tl states2)
     else ALL_TAC)
  | None -> X86_STEPS_TAC mc states
  end
and tac_after memop =
  (* MEMORY_SPLIT_TAC will split out the memory write to the stack.
   Assumptions for flags that involves memory reads of more than one byte
   (for example, ADD for byte64) will not be split out into bytes by
   MEMORY_SPLIT_TAC. Instead, the flag expression is only treated until
   it gets into the goal. After it gets into the goal, the first
   READ_MEMORY_FULLMERGE_CONV will split the memory read in the goal that
   represents the flag changes. After that we simplify/rewrite the goal.
   Given that the MEMORY_SPLIT_TAC splits out the memory write to the stack,
   the rewrites pick that up and turn the memory read in the flag expression
   into its RHS, which again isn't in byte form (but rather byte64 for the ADD
   example). To further assist, we will perform the READ_MEMORY_FULLMERGE_CONV
   and rewrite/simplification again for spliting out the memory read and
   simplify the goal. *)
  (if memop then MAP_EVERY MEMORY_SPLIT_TAC (0--4) else ALL_TAC) THEN
  ENSURES_FINAL_STATE_TAC THEN ASM_REWRITE_TAC[] THEN
  (if memop then CONV_TAC(ONCE_DEPTH_CONV READ_MEMORY_FULLMERGE_CONV)
   else ALL_TAC) THEN
  ASM_REWRITE_TAC[] THEN extra_simp_tac THEN
  (* Reduce any EVEX masking left in the post-state (VPTERNLOGD {k}/{k}{z}). *)
  evex_mask_tac THEN
  (if memop then CONV_TAC(ONCE_DEPTH_CONV READ_MEMORY_FULLMERGE_CONV)
   else ALL_TAC) THEN
  ASM_REWRITE_TAC[] THEN extra_simp_tac THEN
  ALL_TAC;;

(* A function that decodes a list of bytes into an x86 instruction.
 Could be used for figuring out if an instruction exist in s2n-bignum. *)
let decode_inst ibytes =
  let ibyteterm =
     mk_flist(map (curry mk_comb `word:num->byte` o mk_small_numeral) ibytes) in
  let execth = X86_MK_EXEC_RULE(REFL ibyteterm) in
  let decoded = mk_flist
     (map (rand o rand o snd o strip_forall o concl o option_get)
       (filter option_is_some (Array.to_list (snd execth)))) in
  let _ = print_term decoded in
  decoded;;

(*** Cosimulate a list of x86_64 instruction codes against hardware.
 *** To pass, the formal simulation has to agree with the hardware,
 *** only modify the 256-byte buffer [RSP,..,RSP+255] and also
 *** leave the final RSP value the same as the initial value, though
 *** it can be modified in between.
 ***)

let cosimulate_instructions (memopidx: int option) (add_assum: int) ibytes_list =
  let ibyte_to_icode_fn =
    fun ibyte -> (itlist (fun h t -> num h +/ num 256 */ t) (List.rev ibyte) num_0) in
  let icodes = map ibyte_to_icode_fn ibytes_list in
  let icodestring =
    end_itlist (fun s t -> s^","^t) (map string_of_num_hex icodes) in
  let _ =
    (Format.print_string("Cosimulating "^icodestring);
     Format.print_newline()) in

  let ibytes = itlist (fun a b -> a @ b) ibytes_list [] in

  let ibyteterm =
    mk_flist(map (curry mk_comb `word:num->byte` o mk_small_numeral) ibytes) in

  let input_state = random_regstate() in

  let outfile = Filename.temp_file "x86simulator" ".out" in

  let command =
    "x86/proofs/x86simulate '" ^
    end_itlist (fun s t -> s ^ "," ^ t) (map string_of_int ibytes) ^
    "' " ^
    end_itlist (fun s t -> s ^ " " ^ t) (map string_of_num input_state) ^
    " >" ^ outfile in

  let _ = Sys.command command in
  (*** This branch determines whether the actual simulation worked ***)
  (*** In each branch we try to confirm that we likewise do or don't ***)

  if strings_of_file outfile <> [] then
    let resultstring = string_of_file outfile in

    let output_state_raw =
      map (fun (Ident s) -> num_of_string s)
          (lex(explode resultstring)) in

    (* Synthesize q registers from two 64 ints *)
    let output_state = output_state_raw in

    let add_assum_subst =
      if add_assum = 32
      then `aligned 32 stackpointer /\ aligned 16 (stackpointer:int64):bool`,`additional_assumptions:bool`
      else if add_assum = 16 then `aligned 16 (stackpointer:int64):bool`,`additional_assumptions:bool`
      else `T:bool`,`additional_assumptions:bool` in
    let goal = subst
      [ibyteterm,`ibytes:byte list`;
       mk_flist(map mk_numeral input_state),`input_state:num list`;
       mk_flist(map mk_numeral output_state),`output_state:num list`;
       add_assum_subst]
      template in

    let execth = X86_MK_EXEC_RULE(REFL ibyteterm) in

    let inst_th = option_get (snd execth).(0) in
    let decoded = mk_flist
      (map (rand o rand o snd o strip_forall o concl o option_get)
        (filter option_is_some (Array.to_list (snd execth)))) in

    let result =
      match
       (PURE_REWRITE_TAC [fst execth] THEN
        (tac_before (memopidx <> None) THEN
         tac_main memopidx execth (1--length icodes) THEN
         tac_after (memopidx <> None)))
       ([],goal)
      with
        _,[_,endres],_ ->
         (if endres = `T` || only_undefinedness endres then
            (Format.print_string "Modulo undefinedness "; true)
          else
            let _,[_,gsd],_ =
             (REWRITE_TAC[regfile; CONS_11; FLAGENCODING_11; VAL_WORD_GALOIS] THEN
              REWRITE_TAC[DIMINDEX_64; DIMINDEX_128; DIMINDEX_256; DIMINDEX_512] THEN
              CONV_TAC NUM_REDUCE_CONV THEN
              REWRITE_TAC[SOME_FLAGS]) ([], goal) in
             (print_qterm gsd; Format.print_newline(); false))
     | _,[],_ -> true in
    (decoded,result)
  else
    let decoded = mk_flist(map mk_numeral icodes) in
    decoded,not(can X86_MK_EXEC_RULE(REFL ibyteterm));;

(*** Pick random instances from register-to-register iclasses and run ***)

let run_random_regsimulation () =
  let ibytes:int list = random_instruction iclasses in
  cosimulate_instructions None 0 [ibytes];;

(* ------------------------------------------------------------------------- *)
(* Setting up safe self-contained tests for memory accessing instructions.   *)
(* ------------------------------------------------------------------------- *)

(* Auxiliary instructions are for making sure operand registers don't depend
   on RSP. This is because RSP in the theorem statement is an arbitrary value
   represented by `stackpointer`. However in actual machine run, it is a
   concrete value. If certain register's value depends on RSP value then the
   machine run and the instruction modeling result won't match. *)

let rand_scale_index index_bound rest =
  let index = if rest = 0 then 0 else Random.int (min rest index_bound) in
  let log2_int = fun x -> int_of_float (Float.log2 (float_of_int x)) in
  let scale =
    (if index = 0 then Random.int 4
     else
       let scale_range = (log2_int (rest/index)) + 1 in
         Random.int (min scale_range 4)) in
  let rest = rest - index * int_of_float (2.0 ** (float_of_int scale)) in
  [rest, scale, index]

(* Mode: base + scale*index + displacement
   Fixed: use of registers, operand size = 64, displacement size = 8
   Randomized: addressing mode parameters *)
let cosimulate_mem_full_harness(opcode) = fun () ->
   (* disp8 is sign-extended *)
   let base = Random.int 128 in
   let rest = 248 - base in
   let [rest, scale, index] = rand_scale_index 128 rest in
   (* disp8 is sign-extended *)
   let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
   let sib = scale * int_of_float (2.0**6.0) + 0b001011 in
   [[0x48; 0xc7; 0xc1; index; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
    [0x48; 0x89; 0xda]; (* MOV rdx, rbx *)
    [0x48; 0x8d; 0x5c; 0x24; base]; (* LEA rbx, [rsp+base] *)
    [0x48] @ opcode @ [0x44; sib; disp];  (* INST [rbx + scale*rcx + displacement], rax *)
    [0x48; 0x89; 0xd3]; (* MOV rbx, rdx *)
   ];;

(* Mode: base + displacement
   Fixed: use of registers, operand size = 64, displacement size = 8
   Randomized: addressing mode parameters
   *)
let cosimulate_mem_base_disp_harness(opcode) = fun () ->
  (* disp8 is sign-extended *)
  let stack_start = Random.int 128 in
  let rest = 248 - stack_start in
  let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
  [[0x48; 0x89; 0xda]; (* MOV rdx, rbx *)
   [0x48; 0x8d; 0x5c; 0x24; stack_start]; (* LEA rbx, [rsp+stack_start] *)
   [0x48] @ opcode @ [0x43; disp];  (* INST [rbx + displacement], rax *)
   [0x48; 0x89; 0xd3]; (* MOV rbx, rdx *)
  ];;

(* Mode: base (rsp) + scale*index + displacement
   Fixed: use of registers, operand size = 64
   Randomized: addressing mode parameters *)
let cosimulate_mem_rsp_harness(opcode) = fun () ->
  let [rest, scale, index] = rand_scale_index 128 248 in
  (* disp8 is a sign-extended *)
  let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
  let sib = scale * int_of_float (2.0**6.0) + 0b001100 in
  [[0x48; 0xc7; 0xc1; index; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
   [0x48] @ opcode @ [0x44; sib; disp];  (* INST [rsp + scale*rcx + displacement], rax *)
  ];;

(* Mode: base + scale*index + displacement
   Fixed: use of registers, operand size = 64
   Randomized: addressing mode parameters *)
let cosimulate_mul_full_harness() = fun () ->
  (* disp8 is sign-extended *)
  let base = Random.int 128 in
  let rest = 248 - base in
  let [rest, scale, index] = rand_scale_index 128 rest in
  (* disp8 is sign-extended *)
  let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
  let sib = scale * int_of_float (2.0**6.0) + 0b001011 in
  [[0x48; 0xc7; 0xc1; index; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
   [0x48; 0x89; 0xd8]; (* MOV r8, rbx *)
   [0x48; 0x8d; 0x5c; 0x24; base]; (* LEA rbx, [rsp+base] *)
   [0x48; 0xf7; 0x64; sib; disp];  (* MUL [rbx + scale*rcx + displacement] *)
   [0x4c; 0x89; 0xc3]; (* MOV rbx, r8 *)
  ];;

(* Mode: base + displacement
   Fixed: use of registers, operand size = 64
   Randomized: addressing mode parameters
  *)
let cosimulate_mul_base_disp_harness() = fun () ->
  (* disp8 is sign-extended *)
  let stack_start = Random.int 128 in
  let rest = 248 - stack_start in
  let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
  [[0x48; 0x89; 0xd8]; (* MOV r8, rbx *)
   [0x48; 0x8d; 0x5c; 0x24; stack_start]; (* LEA rbx, [rsp+stack_start] *)
   [0x48; 0xf7; 0x63; disp];  (* MUL [rbx + displacement] *)
   [0x4c; 0x89; 0xc3]; (* MOV rbx, r8 *)
  ];;

(* Mode: base (rsp) + scale*index + displacement
   Fixed: use of registers, operand size = 64
   Randomized: addressing mode parameters *)
let cosimulate_mul_rsp_harness() = fun () ->
   let [rest, scale, index] = rand_scale_index 128 248 in
   (* disp8 is a sign-extended *)
   let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
   let sib = scale * int_of_float (2.0**6.0) + 0b001100 in
   [[0x48; 0xc7; 0xc1; index; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
    [0x48; 0xf7; 0x64; sib; disp];  (* MUL [rsp + scale*rcx + displacement], rax *)
   ];;

(* Fixed: operand size = 64 *)
let cosimulate_push_harness() = fun () ->
  let reg = Random.int 6 in
  let push_inst = 0x50 + reg in
  if reg = 4 then
    [[0x48; 0x8d; 0x64; 0x24; 0x10]; (* lea rsp, [rsp + 16] *)
     [0x48; 0x8b; 0x44; 0x24; 0xf8]; (* mov rax, [rsp - 8] *)
     [push_inst]; (* push rsp *)
     [0x48; 0x8b; 0x24; 0x24]; (* mov rsp, [rsp] *)
     [0x48; 0x89; 0x44; 0x24; 0xf8]; (* mov [rsp - 8], rax *)
     [0x48; 0x8d; 0x64; 0x24; 0xf0]; (* lea rsp, [rsp - 16] *)
    ]
  else
    [[0x48; 0x8d; 0x64; 0x24; 0x10]; (* lea rsp, [rsp + 16] *)
     [push_inst]; (* push REG *)
     [0x48; 0x8d; 0x64; 0x24; 0xf8] (* lea rsp, [rsp - 8] *)
    ];;

(* Fixed: operand size = 64 *)
let cosimulate_pop_harness() = fun () ->
  let reg = Random.int 6 in
  let pop_inst = 0x58 + reg in
  if reg = 4 then
    [[0x48; 0x8d; 0x64; 0x24; 0x10]; (* lea rsp, [rsp + 16] *)
     [0x48; 0x8b; 0x04; 0x24]; (* mov rax, [rsp] *)
     [0x48; 0x89; 0x24; 0x24]; (* mov [rsp], rsp *)
     [pop_inst]; (* pop rsp *)
     [0x48; 0x89; 0x04; 0x24]; (* mov [rsp], rax *)
     [0x48; 0x8d; 0x64; 0x24; 0xf0] (* lea rsp, [rsp - 16] *)
    ]
  else
    [[0x48; 0x8d; 0x64; 0x24; 0x10]; (* lea rsp, [rsp + 16] *)
     [pop_inst]; (* pop REG *)
     [0x48; 0x8d; 0x64; 0x24; 0xe8] (* lea rsp, [rsp - 24] *)
    ];;

(* Mode: base + scale*index + displacement
   Fixed: use of registers, displacement size = 8
   Randomized: addressing mode parameters *)
let cosimulate_sse_mov_unaligned_full_harness(pfx, opcode) = fun () ->
   (* disp8 is sign-extended *)
   let base = Random.int 128 in
   let rest = 240 - base in
   let [rest, scale, index] = rand_scale_index 128 rest in
   (* disp8 is sign-extended *)
   let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
   let sib = scale * int_of_float (2.0**6.0) + 0b001011 in
   let rex = if Random.int 2 = 0 then [0x44] else [] in
   [[0x48; 0xc7; 0xc1; index; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
    [0x48; 0x89; 0xda]; (* MOV rdx, rbx *)
    [0x48; 0x8d; 0x5c; 0x24; base]; (* LEA rbx, [rsp+base] *)
    pfx @ rex @ opcode @ [0x4c; sib; disp];  (* INST [rbx + scale*rcx + displacement], imm1/9 *)
    [0x48; 0x89; 0xd3]; (* MOV rbx, rdx *)
   ];;

(* Mode: base + displacement
   Fixed: use of registers, displacement size = 8
   Randomized: addressing mode parameters
   *)
let cosimulate_sse_mov_unaligned_base_disp_harness(pfx, opcode) = fun () ->
  (* disp8 is sign-extended *)
  let stack_start = Random.int 128 in
  let rest = 240 - stack_start in
  let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
  let rex = if Random.int 2 = 0 then [0x44] else [] in
  [[0x48; 0x89; 0xda]; (* MOV rdx, rbx *)
   [0x48; 0x8d; 0x5c; 0x24; stack_start]; (* LEA rbx, [rsp+stack_start] *)
   pfx @ rex @ opcode @ [0x4b; disp];  (* INST [rbx + displacement], imm1/9 *)
   [0x48; 0x89; 0xd3]; (* MOV rbx, rdx *)
  ];;

(* Mode: base (rsp) + scale*index + displacement
   Fixed: use of registers
   Randomized: addressing mode parameters *)
let cosimulate_sse_mov_unaligned_rsp_harness(pfx, opcode) = fun () ->
  let [rest, scale, index] = rand_scale_index 128 240 in
  (* disp8 is a sign-extended *)
  let disp = if rest = 0 then 0 else Random.int (min 128 rest) in
  let sib = scale * int_of_float (2.0**6.0) + 0b001100 in
  let rex = if Random.int 2 = 0 then [0x44] else [] in
  [[0x48; 0xc7; 0xc1; index; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
   pfx @ rex @ opcode @ [0x4c; sib; disp];  (* INST [rsp + scale*rcx + displacement], imm1/9 *)
  ];;

(* Mode: base + scale*index + displacement
   Fixed: use of registers, displacement size = 8
   Randomized: addressing mode parameters
   Note: address should be 16-aligned *)
let cosimulate_sse_mov_aligned_full_harness(pfx, opcode) = fun () ->
   (* Divide 256 by 16 because the address needs to be 16bytes aligned. *)
   let base = Random.int 8 in
   let rest = 15 - base in
   let [rest, scale, index] = rand_scale_index 8 rest in
   (* disp8 is sign-extended *)
   let disp = if rest = 0 then 0 else Random.int (min 8 rest) in
   let sib = scale * int_of_float (2.0**6.0) + 0b001011 in
   let rex = if Random.int 2 = 0 then [0x44] else [] in
   [[0x48; 0xc7; 0xc1; index*16; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
    [0x48; 0x89; 0xda]; (* MOV rdx, rbx *)
    [0x48; 0x8d; 0x5c; 0x24; base*16]; (* LEA rbx, [rsp+base] *)
    pfx @ rex @ opcode @ [0x4c; sib; disp*16];  (* INST [rbx + scale*rcx + displacement], imm1/9 *)
    [0x48; 0x89; 0xd3]; (* MOV rbx, rdx *)
   ];;

(* Mode: base + displacement
   Fixed: use of registers, displacement size = 8
   Randomized: addressing mode parameters
   Note: address should be 16-aligned
   *)
let cosimulate_sse_mov_aligned_base_disp_harness(pfx, opcode) = fun () ->
  (* disp8 is sign-extended *)
  let stack_start = Random.int 8 in
  let rest = 15 - stack_start in
  let disp = if rest = 0 then 0 else Random.int (min 8 rest) in
  let rex = if Random.int 2 = 0 then [0x44] else [] in
  [[0x48; 0x89; 0xda]; (* MOV rdx, rbx *)
   [0x48; 0x8d; 0x5c; 0x24; stack_start*16]; (* LEA rbx, [rsp+stack_start] *)
   pfx @ rex @ opcode @ [0x4b; disp*16];  (* INST [rbx + displacement], imm1/9 *)
   [0x48; 0x89; 0xd3]; (* MOV rbx, rdx *)
  ];;

(* Mode: base (rsp) + scale*index + displacement
   Fixed: use of registers
   Randomized: addressing mode parameters
   Note: address should be 16-aligned
*)
let cosimulate_sse_mov_aligned_rsp_harness(pfx, opcode) = fun () ->
  let [rest, scale, index] = rand_scale_index 8 15 in
  (* disp8 is a sign-extended *)
  let disp = if rest = 0 then 0 else Random.int (min 8 rest) in
  let sib = scale * int_of_float (2.0**6.0) + 0b001100 in
  let rex = if Random.int 2 = 0 then [0x44] else [] in
  [[0x48; 0xc7; 0xc1; index*16; 0x00; 0x00; 0x00]; (* MOV rcx, index *)
   pfx @ rex @ opcode @ [0x4c; sib; disp*16];  (* INST [rsp + scale*rcx + displacement], imm1/9 *)
  ];;

let cosimulate_movsb_full_harness() = fun () ->
  let src = 64 + Random.int 32
  and dest = 64 + Random.int 32
  and count = Random.int 8
  and rep = Random.int 3 in
  [[0x48; 0x8d; 0x7c; 0x24; dest]; (* LEA rdi, [rsp+dest] *)
   [0x48; 0x8d; 0x74; 0x24; src]; (* LEA rsi, [rsp+src] *)
   [0xb9; count; 0x00; 0x00; 0x00]; (* MOV ecx, count *)
   (if rep = 0 then [0xa4] (* MOVSB *)
    else if rep = 1 then [0xf3; 0xa4] (* REPZ MOVSB *)
    else [0xf2; 0xa4] (* REPZ MOVSB *)
   );
   [0x48; 0xf7; 0xd7;]; (* NOT rdi *)
   [0x48; 0xf7; 0xd6;]; (* NOT rsi *)
   [0x48; 0x8d; 0x3c; 0x3c]; (* LEA rdi, [rsp + rdi] *)
   [0x48; 0x8d; 0x34; 0x34]; (* LEA rsi, [rsp + rsi] *)
  ];;

(* Each mem simulation is a pair consists of a list of instructions
  to execute and a bool representing whether additional assumptions
  are needed. Currently the additional assumption is for stack
  alignment for certain instructions. To make the tests more diverse
  the evaluation of harnesses are deferred until an instruction is
  chosen from mem_iclasses *)
let mem_iclasses = [
  (* ADC r/m64, r64 *)
  (cosimulate_mem_full_harness([0x11]), false);
  (cosimulate_mem_base_disp_harness([0x11]), false);
  (cosimulate_mem_rsp_harness([0x11]), false);
  (* ADC r64, r/m64 *)
  (cosimulate_mem_full_harness([0x13]), false);
  (cosimulate_mem_base_disp_harness([0x13]), false);
  (cosimulate_mem_rsp_harness([0x013]), false);
  (* ADD r/m64, r64 *)
  (cosimulate_mem_full_harness([0x01]), false);
  (cosimulate_mem_base_disp_harness([0x01]), false);
  (cosimulate_mem_rsp_harness([0x01]), false);
  (* ADD r64, r/m64 *)
  (cosimulate_mem_full_harness([0x03]), false);
  (cosimulate_mem_base_disp_harness([0x03]), false);
  (cosimulate_mem_rsp_harness([0x03]), false);
  (* CMOVA r64, r/m64 *)
  (cosimulate_mem_full_harness([0x0F; 0x47]), false);
  (cosimulate_mem_base_disp_harness([0x0F; 0x47]), false);
  (cosimulate_mem_rsp_harness([0x0F; 0x47]), false);
  (* CMOVB r64, r/m64 *)
  (cosimulate_mem_full_harness([0x0F; 0x42]), false);
  (cosimulate_mem_base_disp_harness([0x0F; 0x42]), false);
  (cosimulate_mem_rsp_harness([0x0F; 0x42]), false);
  (* MOV r/m64, r64 *)
  (cosimulate_mem_full_harness([0x89]), false);
  (cosimulate_mem_base_disp_harness([0x89]), false);
  (cosimulate_mem_rsp_harness([0x89]), false);
  (* MOV r64, r/m64 *)
  (cosimulate_mem_full_harness([0x8B]), false);
  (cosimulate_mem_base_disp_harness([0x8B]), false);
  (cosimulate_mem_rsp_harness([0x8B]), false);
  (* MOVAPS xmm1, xmm2/m128 *)
  (cosimulate_sse_mov_aligned_full_harness([], [0x0f; 0x28]), true);
  (cosimulate_sse_mov_aligned_base_disp_harness([], [0x0f; 0x28]), true);
  (cosimulate_sse_mov_aligned_rsp_harness([], [0x0f; 0x28]), true);
  (* MOVAPS xmm2/m128, xmm1 *)
  (cosimulate_sse_mov_aligned_full_harness([], [0x0f; 0x29]), true);
  (cosimulate_sse_mov_aligned_base_disp_harness([], [0x0f; 0x29]), true);
  (cosimulate_sse_mov_aligned_rsp_harness([], [0x0f; 0x29]), true);
  (* MOVDQA xmm1, xmm2/m128 *)
  (cosimulate_sse_mov_aligned_full_harness([0x66], [0x0f; 0x6f]), true);
  (cosimulate_sse_mov_aligned_base_disp_harness([0x66], [0x0f; 0x6f]), true);
  (cosimulate_sse_mov_aligned_rsp_harness([0x66], [0x0f; 0x6f]), true);
  (* MOVDQA xmm2/m128, xmm1 *)
  (cosimulate_sse_mov_aligned_full_harness([0x66], [0x0f; 0x7f]), true);
  (cosimulate_sse_mov_aligned_base_disp_harness([0x66], [0x0f; 0x7f]), true);
  (cosimulate_sse_mov_aligned_rsp_harness([0x66], [0x0f; 0x7f]), true);
  (* MOVDQU xmm1, xmm2/m128 *)
  (cosimulate_sse_mov_unaligned_full_harness([0xf3], [0x0f; 0x6f]), false);
  (cosimulate_sse_mov_unaligned_base_disp_harness([0xf3], [0x0f; 0x6f]), false);
  (cosimulate_sse_mov_unaligned_rsp_harness([0xf3], [0x0f; 0x6f]), false);
  (* MOVDQU xmm2/m128, xmm1 *)
  (cosimulate_sse_mov_unaligned_full_harness([0xf3], [0x0f; 0x7f]), false);
  (cosimulate_sse_mov_unaligned_base_disp_harness([0xf3], [0x0f; 0x7f]), false);
  (cosimulate_sse_mov_unaligned_rsp_harness([0xf3], [0x0f; 0x7f]), false);
  (* MOVSB and REP MOVSB *)
  (cosimulate_movsb_full_harness(),false);
  (* MOVUPS xmm1, xmm2/m128 *)
  (cosimulate_sse_mov_unaligned_full_harness([], [0x0f; 0x10]), false);
  (cosimulate_sse_mov_unaligned_base_disp_harness([], [0x0f; 0x10]), false);
  (cosimulate_sse_mov_unaligned_rsp_harness([], [0x0f; 0x10]), false);
  (* MOVUPS xmm2/m128, xmm1 *)
  (cosimulate_sse_mov_unaligned_full_harness([], [0x0f; 0x11]), false);
  (cosimulate_sse_mov_unaligned_base_disp_harness([], [0x0f; 0x11]), false);
  (cosimulate_sse_mov_unaligned_rsp_harness([], [0x0f; 0x11]), false);
  (* MUL r/m64 *)
  (cosimulate_mul_full_harness(), false);
  (cosimulate_mul_base_disp_harness(), false);
  (cosimulate_mul_rsp_harness(), false);
  (* OR r/m64, r64 *)
  (cosimulate_mem_full_harness([0x09]), false);
  (cosimulate_mem_base_disp_harness([0x09]), false);
  (cosimulate_mem_rsp_harness([0x09]), false);
  (* OR r64, r/m64 *)
  (cosimulate_mem_full_harness([0x0B]), false);
  (cosimulate_mem_base_disp_harness([0x0B]), false);
  (cosimulate_mem_rsp_harness([0x0B]), false);
  (* PUSH r64 *)
  (cosimulate_push_harness(), false);
  (* POP r64 *)
  (cosimulate_pop_harness(), false);
  (* SBB r/m64, r64 *)
  (cosimulate_mem_full_harness([0x19]), false);
  (cosimulate_mem_base_disp_harness([0x19]), false);
  (cosimulate_mem_rsp_harness([0x19]), false);
  (* SBB r64, r/m64 *)
  (cosimulate_mem_full_harness([0x1B]), false);
  (cosimulate_mem_base_disp_harness([0x1B]), false);
  (cosimulate_mem_rsp_harness([0x1B]), false);
  (* SUB r/m64, r64 *)
  (cosimulate_mem_full_harness([0x29]), false);
  (cosimulate_mem_base_disp_harness([0x29]), false);
  (cosimulate_mem_rsp_harness([0x29]), false);
  (* SUB r64, r/m64 *)
  (cosimulate_mem_full_harness([0x2B]), false);
  (cosimulate_mem_base_disp_harness([0x2B]), false);
  (cosimulate_mem_rsp_harness([0x2B]), false);
  (* XOR r/m64, r64 *)
  (cosimulate_mem_full_harness([0x31]), false);
  (cosimulate_mem_base_disp_harness([0x31]), false);
  (cosimulate_mem_rsp_harness([0x31]), false);
  (* XOR r64, r/m64 *)
  (cosimulate_mem_full_harness([0x33]), false);
  (cosimulate_mem_base_disp_harness([0x33]), false);
  (cosimulate_mem_rsp_harness([0x33]), false);
  ];;

let run_random_memopsimulation() =
  let deferred_icodes,add_assum =
    el (Random.int (length mem_iclasses)) mem_iclasses in
  let icodes = deferred_icodes() in
  let l = length icodes in
  let _ = assert (l >= 2) in
  let memop_index = if l = 8 then 3 else if l >= 6 then l - 4 else l - 2 in
  cosimulate_instructions
     (Some memop_index)  (if add_assum then 16 else 0) icodes;;

(* ------------------------------------------------------------------------- *)
(* Cosimulation of simple memory instructions with uniform [rsp+32] address  *)
(* ------------------------------------------------------------------------- *)

let simple_memory_iclasses =
[
 (* Address [rsp+32] (into the 256-byte stack buffer the harness sets up),
    matching the model's memory-operand read. Earlier encodings used [rax]/[rcx],
    i.e. raw random register values, which are wild pointers that segfault the
    hardware harness. *)
 [0x62; 0xF3; 0x75; 0x5C; 0x25; 0x44; 0x24; 0x20; 0x96]; (* VPTERNLOGD zmm0{k4}, zmm1, DWORD BCST [rsp+0x20], 0x96 *)
 [0x62; 0xF3; 0x5D; 0xDD; 0x25; 0x5C; 0x24; 0x20; 0x80]; (* VPTERNLOGD zmm3{k5}{z}, zmm4, DWORD BCST [rsp+0x20], 0x80 *)
];;

let simplemem_iclasses =
  map (fun l -> [l],true) simple_memory_iclasses;;

let run_random_simplememopsimulation() =
  let icodes,add_assum =
    el (Random.int (length simplemem_iclasses)) simplemem_iclasses in
  let memop_index = 0 in
  cosimulate_instructions (Some memop_index) 32 icodes;;

(* ------------------------------------------------------------------------- *)
(* Keep running tests till a failure happens then return it.                 *)
(* ------------------------------------------------------------------------- *)

let run_random_simulation() =
  let rn = Random.int 100 in
  if rn < 80 then
    let decoded, result = run_random_regsimulation() in
    decoded,result,0
  (* else if rn < 90 then *)
  (*   let decoded, result = run_random_memopsimulation() in *)
  (*   decoded,result,1 *)
  else
    let decoded, result = run_random_simplememopsimulation() in
    decoded,result,2;;

(* let time_limit_sec = 2400.0;; *)
let time_limit_sec = 60.0;;
let tested_reg_instances = ref 0;;
let tested_mem_instances = ref 0;;
let tested_smp_instances = ref 0;;

let rec run_random_simulations start_t =
  let decoded,result,simty = run_random_simulation() in
  if result then begin
    tested_reg_instances := !tested_reg_instances + (if simty = 0 then 1 else 0);
    tested_mem_instances := !tested_mem_instances + (if simty = 1 then 1 else 0);
    tested_smp_instances := !tested_smp_instances + (if simty = 2 then 1 else 0);
    let fey = if is_numeral decoded
              then " (fails correctly) instruction code " else " " in
    let _ = Format.print_string("OK:" ^ fey ^ string_of_term decoded);
            Format.print_newline() in
    let now_t = Sys.time() in
    if now_t -. start_t > time_limit_sec then
      let _ = Printf.printf "Finished (time limit: %fs, tested register-only: %d, general memory: %d, special memory: %d, total: %d)\n"
          time_limit_sec !tested_reg_instances !tested_mem_instances !tested_smp_instances
          (!tested_reg_instances + !tested_mem_instances + !tested_smp_instances) in
      None
    else run_random_simulations start_t
  end
  else Some (decoded,result);;

(*** Depending on the degree of repeatability wanted.
 *** After a few experiments I'm now going full random.
 ***
 *** Random.init(Hashtbl.hash (Sys.getenv "HOST"));;
 ***)

Random.self_init();;

let start_t = Sys.time() (* unit is sec *) in
  match run_random_simulations start_t with
  | Some (t,_) -> Printf.printf "Error: term `%s`" (string_of_term t); failwith "simulator"
  | None -> ();;
