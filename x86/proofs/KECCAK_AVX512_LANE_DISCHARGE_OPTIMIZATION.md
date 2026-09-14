# AVX-512VL 4× Keccak-f1600 proof: `LANE_TAC` discharge optimization

**TL;DR** — The HOL Light proof of `sha3_keccak4_f1600_avx512vl` was cut from
**3h22m to 60.5min (≈3.3×)**, kernel-clean, all four ABI specs, pure ZMM operand
view. The win comes from a new lane-discharge tactic (`LANE_TAC`) plus per-step
`word_zx` collapse during stepping. Both live in
`x86/proofs/sha3_keccak4_f1600_avx512vl.ml`.

---

## 1. Where the time went

The proof of the round-body lemma `ROUND_CORRECT` dominated the whole build:

| phase | baseline | note |
|---|---|---|
| stepping (142 SIMD instrs) | ~25 min | symbolic execution of the round body |
| **discharge (25 lanes × BITBLAST)** | **~2.7 hr** | the wall |
| M4/M5/wiring/wrappers | ~10 min | transpose, store, loop, ABIs |

The discharge proves, for each of the 25 output registers, that the stepped
256-bit value equals `keccak_round` of the input lanes. Each was one monolithic
`prove(w, BITBLAST_TAC)` over a **~6400-variable** BDD (`~375 s` native / lane).

## 2. Why the obvious ideas didn't help

Documented dead-ends (all measured):

- **Per-bit BITBLAST** — net-neutral. The per-lane *prep* dominates, not the BDD
  solve, so splitting the solve finer changes little.
- **`word_zx`/`word_subword` collapse lemmas** — sped *stepping* only.
- **Deferred packing** — 2× faster stepping, but the per-bit discharge can't split
  a goal whose packing lives in hypotheses.
- **Naïve sublane split** (`INT256_EQ_LANES` then blast each `word_subword L (p,64)`)
  — measured **0.98×** (slightly *worse*): BITBLAST still preps the full 256-bit
  LHS for every sublane, so the work is repeated 4× with no atom reduction.

Crucially, the discharge goal is **not** the problem's size after clean stepping:
one lane goal is only ~1000 DAG nodes with 2 `word_zx` and 5 free vars. The cost
is BITBLAST allocating a bit per distinct input **atom** (`EL k Bj`) — a lane
references all **100** atoms (25 lanes × 4 buffers) = ~6400 bits.

## 3. The insight

The 4× SIMD kernel computes the **same** `keccak_round` lane on **4 independent
buffers** B1..B4, packed into one 256-bit register as

```
word_join (word_join (EL k B4) (EL k B3)) (word_join (EL k B2) (EL k B1))
          ^--- bits 192..255   128..191            64..127    0..63
```

So position `(0,64)→B1`, `(64,64)→B2`, `(128,64)→B3`, `(192,64)→B4`.

Two consequences:

1. **Isolate one buffer per sublane.** If we split a lane into its four 64-bit
   sublanes and *push `word_subword` inward* through the round's bitwise ops
   (`&& || ~~ word_join word_zx`), each sublane collapses to reference only **one**
   buffer's atoms — **25 atoms / ~1600 bits** instead of 100 / ~6400. Because SAT/BDD
   cost is super-linear, the 64-bit sublane blast is **~11× faster** than the lane
   blast (133.8 s vs 1499.6 s, interpreted; BDD 1665 vars vs 6401).

2. **Prove one sublane, get the other three free.** The four pushed sublane goals
   are *exact variable-renamings* of each other
   (`g₁ = g₀[B2/B1]`, `g₂ = g₀[B3/B1]`, `g₃ = g₀[B4/B1]`; verified by `aconv`).
   So we BITBLAST sublane 0 **once** and obtain sublanes 1–3 by `INST` — essentially
   free.

Net per lane: push (~17 s) + **one** blast (134 s) + 3 `INST`s ≈ **154 s** vs
1499.6 s = **~9.7×**. (Reuse is cross-buffer only; the 25 output lanes are distinct
keccak functions, so 25 blasts remain — but each is small.)

`word_rol` (the ρ rotations) needs no special handling: the rotates sit *below* the
`word_join` leaves at 64-bit width, so `word_subword` reaches `word_join` first and
extracts the sublane before ever meeting a rotate.

## 4. The tactic

```ocaml
(* push word_subword inward: join/zx/duplicate via WORD_SIMPLE_SUBWORD_CONV,
   bitwise via WORD_SUBWORD_AND/OR/XOR, negation via (conditional) WORD_SUBWORD_NOT *)
let SWP : conv =
  let aox  = GEN_REWRITE_CONV I [WORD_SUBWORD_AND; WORD_SUBWORD_OR; WORD_SUBWORD_XOR] in
  let notm = PART_MATCH (lhs o rand) WORD_SUBWORD_NOT in
  let dis  = REWRITE_CONV[DIMINDEX_64;DIMINDEX_128;DIMINDEX_256] THENC NUM_REDUCE_CONV in
  let push1 t =
    (try WORD_SIMPLE_SUBWORD_CONV t with Failure _ ->
     try aox t with Failure _ ->
     let th = notm t in MP th (EQT_ELIM(dis (lhand(concl th))))) in
  TOP_DEPTH_CONV push1;;

let LANE_TAC : tactic =                       (* proves one int256-lane goal *)
  let islist v = match type_of v with Tyapp("list",_) -> true | _ -> false in
  ONCE_REWRITE_TAC[INT256_EQ_LANES] THEN      (* -> 4 int64 sublane conjuncts *)
  CONV_TAC SWP THEN                           (* isolate one buffer per sublane *)
  W(fun (_,w) ->
     let cs = conjuncts w in
     let g0 = hd cs in
     let b0 = find islist (frees g0) in
     let th0 = prove(g0, BITBLAST_TAC) in     (* the ONLY blast *)
     let thms = map (fun g ->
        if g = g0 then th0
        else let bg = find islist (frees g) in
             EQ_MP (ALPHA (concl (INST [bg,b0] th0)) g) (INST [bg,b0] th0)) cs in
     ACCEPT_TAC(end_itlist CONJ thms));;
```

It requires the discharge terms to be *clean and lane-aligned*, which is why the
stepping was switched to collapse `word_zx` round-trips after every step:

```ocaml
MAP_EVERY (fun n -> X86_STEPS_TAC EXEC [n] THEN ZXCOLLAPSE_TAC) (1--142)
```

`ZXCOLLAPSE_TAC` uses `WORD_ZX_ZX` + `WORD_SUBWORD_WORD_ZX` + `dimindex` facts to
keep the 512-bit ZMM-view `word_zx` wrapping from accumulating (without it the
final term is ~4M nodes and `SWP` is impractical).

The discharge tail changed from
`REPEAT CONJ_TAC THEN W(fun (_,w) -> ACCEPT_TAC(prove(w, BITBLAST_TAC)))`
to `REPEAT CONJ_TAC THEN LANE_TAC`. **`ROUND_CORRECT`'s statement is unchanged**,
so the composing loop branch, M4/M5 lemmas, and ABI wrappers are unaffected.

## 5. The harness that made it tractable

Iterating discharge tactics natively costs a ~25-40 min re-step each; an
interpreted checkpoint is ~4× slower and the goal term is huge. The unlock:

1. Restore a post-stepping DMTCP checkpoint once, drive the discharge prefix to the
   25-lane split, and `Marshal.to_channel` the 25 goal terms to disk.
2. Iterate blast strategies standalone against the already-loaded MCP HOL `x86base`
   session (or any fresh `hol.sh`) that `Marshal.from_channel`s them — **no
   re-stepping**, compiled/warm speed, minutes per experiment.

Gotchas: keep every `term`-typed value out of top-level bindings (the toplevel
pretty-printer expands the DAG and hangs / blows the log to 100s of MB — wrap work
in a unit thunk); use `Sys.time`, not `Unix` (not linked in the `hol.sh` toplevel).

All 25 lanes were independently validated via this harness before folding.

## 6. Result

| | baseline | optimized |
|---|---|---|
| full proof (all 4 ABI specs) | 3h22m (12129 s) | **60.5 min (3631 s)** |
| ROUND_CORRECT discharge | ~2.7 hr | ~14 min (25 × ~30-40 s) |
| stepping | ~25 min | ~38 min (per-step ZXCOLLAPSE) |

`check_axioms` clean; specs `SHA3_KECCAK4_F1600_AVX512VL_{NOIBT_SUBROUTINE,
SUBROUTINE, NOIBT_WINDOWS_SUBROUTINE, WINDOWS_SUBROUTINE}_CORRECT` all proven;
pure ZMM operand view (no YMM).

## 7. Where the time is now, and further ideas

Stepping (~38 min) is now the dominant cost — the per-step `ZXCOLLAPSE` is heavier
than plain stepping, but it is what keeps the discharge terms small enough for
`LANE_TAC`, so it more than pays for itself.

- **Deferred (opaque-lane) stepping** runs in ~8 min but leaves the buffer packing
  in hypotheses; `LANE_TAC` needs a self-contained goal, so it would require
  re-substituting (re-bloating) the packing first — not free. A combination that
  keeps stepping cheap *and* the discharge self-contained is the next multi-× lever.
- The 25 output-lane functions are distinct (different ρ/π/ι), so there is no
  cross-lane blast reuse beyond the 4 buffers — 25 blasts is the floor for this
  structure.
