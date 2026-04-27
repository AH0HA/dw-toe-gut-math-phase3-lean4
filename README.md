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
| `E8/Basic.lean`  | `e8_card : e8Roots.card = 240` (via 112 + 128 disjoint union; *not* `decide`-able).    |
| `E8/Basic.lean`  | `d5_has_40_roots : (e8Roots.filter InD5).card = 40`.                                  |
| `E8/H3.lean`     | `h3Group` as the multiplicative closure of `h3Gens`.                                  |
| `E8/H3.lean`     | `h3_group_card : h3Group.card = 120`.                                                  |
| `E8/H3.lean`     | `h3RotationSubgroup` and `h3_rotation_subgroup_card : … = 60`.                        |
| `E8/H3.lean`     | `orbit_sizes_are_icosahedral` for orbits in `projectedRoots`.                         |
| `E8/Theta.lean`  | `e8_theta_factorizes_over_h3` — the central factorization theorem.                    |

The 240 E₈ roots are now constructed explicitly in `E8/Basic.lean` as a
disjoint union of `integerRoots` (112 vectors with two ±1 entries) and
`halfIntegerRoots` (128 vectors with all coordinates ±1/2 and an even
number of minus signs).

The H₃ generators are now concrete in `E8/H3.lean`: three rotations
(`h3Rot2`, `h3Rot3`, `h3Rot5` — orders 2, 3, 5) plus central inversion
`h3Inv`. The three rotations alone generate the proper rotation
subgroup I ≅ A₅ of order 60; adjoining `h3Inv` gives the full Coxeter
group H₃ of order 120.

> **Note on `decide`.** `e8_card` cannot be discharged by `decide` /
> `native_decide` because `Finset.card` on `Fin 8 → ℝ` ultimately rests on
> `Classical.decEq ℝ`, which is non-computable. The proof has to go via a
> bijection from each side to a decidable index set
> (e.g. `Sym2 (Fin 8) × (Bool × Bool)` for `integerRoots` and
> `{s : Fin 8 → Bool // (#{i | ¬s i}) % 2 = 0}` for `halfIntegerRoots`).

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
