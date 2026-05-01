# E8ThetaFactorization

Lean 4 / mathlib4 formalization scaffold for the **Phase 3** conjecture:

> Under the φ-weighted, δ-dragged projection ℝ⁸ → ℝ³ that realizes the
> E₈ → D₅ → H₃ branching observed numerically in Phase 1, the projected
> theta series of E₈ factorizes as
>
> ∏_{k=1}^{8} θ_{1D}(τ; δ_k) .

This repository contains a **compileable skeleton**: every definition
elaborates, every theorem statement type-checks, and the only `sorry`s are
where the actual mathematical content has to be discharged by a working
mathematician.

## Layout

```
lakefile.toml                Lake package config (lib `E8`, exe `e8thetacheck`)
lean-toolchain               Pinned to leanprover/lean4:v4.30.0-rc2
E8.lean                      Library root: `import E8` pulls in all four files
E8/
  Basic.lean                 E₈ roots, D₅ sublattice, coset decomposition
  Projection.lean            φ-weighted projection P : ℝ⁸ → ℝ³, δ scaling
  H3.lean                    H₃ generators (icosahedral, order 120), orbits
  Theta.lean                 thetaE8, theta1D, central factorization theorem
Main.lean                    `e8thetacheck` sanity-check executable
```

## Build

```bash
# 1. Install elan (Lean version manager).
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
export PATH="$HOME/.elan/bin:$PATH"

# 2. Inside this directory, fetch precompiled mathlib oleans and build.
lake exe cache get   # ~8300 cached .olean files from Azure
lake build           # builds the `E8` library (default target)
```

Expected output: `Build completed successfully` followed by `declaration
uses \`sorry\`` warnings — those are the obligations to be discharged.

The `e8thetacheck` executable is **not** in `defaultTargets` because building
it forces clang to compile every mathlib `*.c.o` shard (~16 000 jobs, hours
on a single CPU). To run it: `lake build e8thetacheck && ./.lake/build/bin/e8thetacheck`.

## Outstanding obligations (the `sorry`s)

| File             | Obligation                                                                            |
|------------------|---------------------------------------------------------------------------------------|
| `E8/H3.lean`     | `h3Group` as the multiplicative closure of `h3Gens`.                                  |
| `E8/H3.lean`     | `h3_group_card : h3Group.card = 120`.                                                  |
| `E8/H3.lean`     | `h3RotationSubgroup` and `h3_rotation_subgroup_card : … = 60`.                        |
| `E8/H3.lean`     | `orbit_sizes_are_icosahedral` for orbits in `projectedRoots`.                         |
| `E8/Theta.lean`  | `e8_theta_factorizes_over_h3` — the central factorization theorem.                    |

### Towards the H₃ obligations: power relations proved

Four of the seven generating Coxeter-style relations are now proved
end-to-end (no `sorry`):

```
h3Inv_sq               : h3Inv * h3Inv = 1                    -- order 2
h3Rot2_sq              : h3Rot2 * h3Rot2 = 1                  -- order 2
h3Rot3_cubed           : h3Rot3 * h3Rot3 * h3Rot3 = 1         -- order 3
h3Rot2_mul_h3Rot3_sq   : (h3Rot2 * h3Rot3)² = 1               -- order 2
```

Plus the scalar inputs needed for the remaining h3Rot5 relations:

```
cos_two_pi_div_five    : cos(2π/5) = (√5 − 1) / 4
sin_two_pi_div_five_sq : sin(2π/5)² = (10 + 2√5) / 16
uy_sq_add_uz_sq        : (1/√(2+φ))² + (φ/√(2+φ))² = 1
```

The remaining matrix-level relations (`h3Rot5^5 = 1`,
`(h3Rot2·h3Rot5)^? = 1`, `(h3Rot3·h3Rot5)^? = 1`) are tractable in
principle via either Cayley–Hamilton or conjugation to a z-axis
rotation; both are multi-day formalisation efforts. See
`NEXT_SESSION.md` for the recommended path and pitfalls.

**`E8/Basic.lean` is sorry-free.** Both cardinality theorems

```
e8_card        : e8Roots.card = 240
d5_has_40_roots: (e8Roots.filter InD5).card = 40
```

are fully proved end-to-end via the same template:

1. Refactor each E₈ root family as the image of a *decidable* index
   set under an explicit injection into `Fin 8 → ℝ`.
2. Compute the cardinalities of the index sets via `native_decide`.
3. Prove the embeddings are injective on their domains.
4. Combine via `Finset.card_image_of_injOn`,
   `Finset.card_union_of_disjoint`, and `Finset.filter_union`.

Supporting lemmas (all fully proved, no `sorry`):

* `integerRootIndex_card = 112`, `halfIntegerIndex_card = 128`,
  `integerRootIndexD5_card = 40` — by `native_decide`.
* `bool_sign_injective` — the Bool→ℝ sign function is injective.
* `halfIntegerOfIndex_injective`, `integerRootOfIndex_injOn` — embedding
  injectivity.
* `halfIntegerRoots_card = 128`, `integerRoots_card = 112` — image cards.
* `integerRoots_have_zero_entry`, `halfIntegerRoots_no_zero_entry` —
  pigeonhole / direct case split.
* `disjoint_int_half` — combines the two zero-entry lemmas.
* `halfIntegerRoots_filter_InD5 = ∅`,
  `integerRootOfIndex_InD5_iff`,
  `integerRoots_filter_InD5_eq` — the D₅ filter analysis.

The H₃ generators are concrete in `E8/H3.lean`: three rotations
(`h3Rot2`, `h3Rot3`, `h3Rot5` — orders 2, 3, 5) plus central inversion
`h3Inv`. The three rotations alone generate the proper rotation
subgroup I ≅ A₅ of order 60; adjoining `h3Inv` gives the full Coxeter
group H₃ of order 120.

### Difficulty assessment of the remaining work

* **Hard** (research-level formalisation): `h3Group` /
  `h3_group_card = 120` and the rotation subgroup analogue. These
  require either (a) Mathlib's `CoxeterGroup` machinery, (b) explicit
  matrix-group enumeration with ℝ-equality discharged via algebraic
  identities for `cos(2π/5)`, `√3`, `√(2+φ)`, or (c) construction of an
  isomorphism with a known group of order 120. Days–weeks of work.
* **Hard** (representation theory): `e8_theta_factorizes_over_h3`. The
  central conjecture; needs the Phase-2 decoupling argument formalised
  end-to-end.

## Suggested order of attack

1. Replace the placeholder `e8Roots` in `E8/Basic.lean` with the explicit
   list from the Phase 1 Python script (112 D-type + 128 spinor roots),
   then `e8_card` and `d5_has_40_roots` follow by `decide` / `rfl`.
2. Tighten `P` in `E8/Projection.lean` so its rows are unit vectors and
   prove its kernel is the D₅ sublattice. The numerics in Phase 1 give
   the exact entries.
3. Fill in the H₃ generators in `E8/H3.lean`; build `h3Group` by iterated
   closure of `h3Gens` until the size stabilises (Phase 1 confirms
   stabilisation at 120 elements).
4. Prove `e8_theta_factorizes_over_h3` using the representation-theoretic
   decoupling from Phase 2: the eight E₈ coordinates are independent under
   the H₃-equivariant projection, so the sum splits into a product.

## Notes on the build environment

* `lake exe cache get` downloads precompiled `.olean` files from
  `leanprover-community/mathlib4` Azure cache. C IR (`*.c.o`) files for
  native compilation are **not** cached and must be built locally if you
  invoke a target that links against mathlib's runtime (e.g. an executable
  with `import Mathlib`).
* If `releases.lean-lang.org` returns 503 (as observed in this session
  on 2026-04-27), `elan` falls back to GitHub releases for the toolchain
  tarball. The same workaround is used in
  [`leanprover/lean4` Issue #5421](https://github.com/leanprover/lean4/issues/5421).

## Status

Phases 1 and 2 produced the numerical evidence and representation-theoretic
explanation. Phase 3 (this repository) lifts the conjecture into Lean 4
with a compiling type signature for every component. The remaining work is
to discharge the 9 `sorry`s above.
