# Next-session continuation prompt

Copy-paste the section below into a fresh Claude Code session to resume
work on the Phase 3 Lean 4 formalisation.

---

## Prompt to paste

> I'm continuing the Phase 3 Lean 4 formalisation of the E₈ → H₃ theta
> factorisation. Working directory `/home/user/dw-toe-gut-math-phase3-lean4`,
> branch `claude/lean4-setup-Otgd0`. Read `NEXT_SESSION.md` for the full
> state and the next concrete task. After you've read it, either start
> on the **next concrete task** (the matrix-level `h3Rot5^5 = 1` via
> Cayley–Hamilton) or, if you'd prefer to verify the build first, run
> `lake build E8` and confirm it's still green.

---

## Project state at the end of the previous session

* Branch: `claude/lean4-setup-Otgd0` on `origin/AH0HA/dw-toe-gut-math-phase3-lean4`.
* Latest commit: `6561c51 Phase 3: prove unit-axis identity uy^2 + uz^2 = 1 for icosahedral axis`.
* `lake build E8` is green, 6 `sorry`s total (unchanged):
  * `E8/Basic.lean` — 0
  * `E8/Projection.lean` — 0
  * `E8/H3.lean` — 5 (`h3Group`, `h3_group_card`, `h3RotationSubgroup`, `h3_rotation_subgroup_card`, `orbit_sizes_are_icosahedral`)
  * `E8/Theta.lean` — 1 (`e8_theta_factorizes_over_h3`, conditional on `h3_card`)

## Coxeter / power relations status

```
✓ h3Inv_sq               : h3Inv * h3Inv = 1                    -- order 2
✓ h3Rot2_sq              : h3Rot2 * h3Rot2 = 1                  -- order 2
✓ h3Rot3_cubed           : h3Rot3 * h3Rot3 * h3Rot3 = 1         -- order 3
✓ h3Rot2_mul_h3Rot3_sq   : (h3Rot2 * h3Rot3)² = 1               -- order 2
✓ cos_two_pi_div_five    : cos(2π/5) = (√5 − 1) / 4             [scalar input]
✓ sin_two_pi_div_five_sq : sin(2π/5)² = (10 + 2√5) / 16         [scalar input]
✓ uy_sq_add_uz_sq        : (1/√(2+φ))² + (φ/√(2+φ))² = 1        [unit-axis identity]

Pending:
· h3Rot5^5 = 1
· (h3Rot2 · h3Rot5)^? = 1
· (h3Rot3 · h3Rot5)^? = 1
```

## Next concrete task: Cayley–Hamilton path for `h3Rot5^5 = 1`

The brute-force approach (5 chained `Matrix.mul_fin_three` then
`nlinarith` with ~10 hints) blows up polynomially: each entry of
`h3Rot5^k` is a degree-`k` polynomial in `{c, s, uy, uz}`, and by
`k = 5` the entries have hundreds of terms each. Don't try this.

The clean mathematical path uses Cayley–Hamilton. For a 3×3 rotation
matrix `M` by angle `θ` about a unit axis, the characteristic
polynomial is `(X − 1)(X² − 2c X + 1)` where `c = cos θ`. With
`c = (√5 − 1)/4` and `2c + 1 = (√5 + 1)/2 = φ`, Cayley–Hamilton gives:

```
M³ = φ M² − φ M + I
```

Iterating the recurrence (using `φ² = φ + 1` from `phi_sq`):

```
M⁴ = M² − φ M + φ I
M⁵ = M · M⁴ = M³ − φ M² + φ M = (φ M² − φ M + I) − φ M² + φ M = I
```

So `M⁵ = I` follows from Cayley–Hamilton + `φ² = φ + 1` + the trace
identity `tr(h3Rot5) = 1 + 2c = φ`. This is the cleanest known
approach, but it requires substantial mathlib infrastructure:

1. `Matrix.charpoly h3Rot5 = (X − 1) * (X² − φ X + 1)` — proving the
   characteristic polynomial of the explicit Rodrigues matrix.
2. `Matrix.aeval_self_charpoly` (Cayley–Hamilton in mathlib) — apply to
   get the matrix recurrence.
3. The polynomial recurrence in the matrix ring.

Step 1 is the hard one: computing the characteristic polynomial
symbolically with the messy Rodrigues entries. This is multi-day work.

### Alternative path: conjugation to z-axis rotation

Define `P = !![1, 0, 0; 0, φ/√(2+φ), 1/√(2+φ); 0, -1/√(2+φ), φ/√(2+φ)]`
(orthonormal basis with last column = unit axis `(0, 1, φ)/√(2+φ)`).
Then:

```
h3Rot5 = P · R_z(2π/5) · Pᵀ
```

where `R_z(2π/5) = !![c, -s, 0; s, c, 0; 0, 0, 1]`. Since `R_z` is
diagonal-block, `R_z^5 = !![cos(10π/5), -sin(10π/5), 0; …; …; 0, 0, 1]`
= `!![1, 0, 0; 0, 1, 0; 0, 0, 1]` (using `cos(2π) = 1`, `sin(2π) = 0`).
So:

```
h3Rot5^5 = P · R_z^5 · Pᵀ = P · I · Pᵀ = P · Pᵀ = I
```

This requires:
1. Define `P` and prove `P · Pᵀ = I` (orthogonality).
2. Prove `R_z(2π/5)^5 = I` via the `cos(10π/5) = 1` and
   `sin(10π/5) = 0` scalar identities.
3. Prove `h3Rot5 = P · R_z(2π/5) · Pᵀ` (the Rodrigues definition matches
   the conjugate form).

Step 3 is again a non-trivial matrix algebra calculation but each entry
is a *polynomial* identity in `{c, s, uy, uz}` (no transcendental
substitutions), so `ring` should close it after sufficient unfolding.

### Recommendation

Try the conjugation path first. It is more elementary (no charpoly
machinery) and the matrix identity `h3Rot5 = P · R_z · Pᵀ` is provable
by `ring` once both sides are unfolded. Multi-day estimate stands.

## Already-proved scalar inputs

Available in `E8/H3.lean` for use in the matrix proofs:

* `phi_sq : phi^2 = phi + 1`  (in `E8/Basic.lean`)
* `sqrt3_mul_self : √3 · √3 = 3`
* `sqrt5_mul_self : √5 · √5 = 5`
* `sqrt5_sq : √5^2 = 5`
* `two_plus_phi_pos : 0 < 2 + phi`
* `sq_sqrt_two_plus_phi : √(2+phi)^2 = 2 + phi`
* `sqrt_two_plus_phi_ne_zero : √(2+phi) ≠ 0`
* `cos_two_pi_div_five : cos(2π/5) = (√5 − 1)/4`
* `sin_two_pi_div_five_sq : sin(2π/5)^2 = (10 + 2√5)/16`
* `uy_sq_add_uz_sq : (1/√(2+phi))^2 + (phi/√(2+phi))^2 = 1`

## Environment notes

* Lean toolchain: `leanprover/lean4:v4.30.0-rc2` installed at
  `~/.elan/toolchains/leanprover--lean4---v4.30.0-rc2/`. Side-loaded
  from GitHub releases because `releases.lean-lang.org` was returning
  503 at install time.
* Mathlib cache: pre-fetched via `lake exe cache get` (8322 oleans).
  Avoid `import Mathlib` (top-level) — it forces a full clang IR build.
* `lake build E8` uses ~5 s after the cache.

## Files to consult

* `E8/H3.lean` — site of all remaining power-relation work.
* `E8/Basic.lean` — sorry-free, reference for the
  `native_decide` + `Set.InjOn` pattern.
* `README.md` — high-level project description and obligation table.
* `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Trigonometric/Basic.lean`
  — `cos_pi_div_five`, `cos_two_mul`, `sin_sq_add_cos_sq` infrastructure.
* `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Charpoly/` —
  Cayley–Hamilton infrastructure if the charpoly route is preferred.

## Things to avoid

* Pasting Grok-supplied patches verbatim. They have consistently
  contained markdown corruption (e.g. `[Mathlib.Data](http://Mathlib.Data).…`),
  type errors (`Subgroup (Matrix _ _ ℝ)` — Matrix isn't a group),
  fictional API calls (`raw.rowSumSq`, `(M i j).round 8`), and
  vacuous-`True`-via-`sorry` regressions of meaningful theorems.
* `import Mathlib` (top-level) — pulls in a 16k-job native build.
* `<;> norm_num` chained after a goal-closing `simp` — fails with "no
  goals to be solved".
* Brute-force `h3Rot5^5 = 1` via 5 chained `Matrix.mul_fin_three` then
  `nlinarith`. The polynomial expansion by step 5 has hundreds of
  terms per entry; `nlinarith` will time out or run out of memory.

## Suggested workflow for the next session

1. `lake build E8` to confirm baseline is still green (~5 s).
2. Try the conjugation-to-z-axis approach first (easier than charpoly):
   a. Define `P` orthonormal basis matrix.
   b. Prove `P · Pᵀ = I` via diagonal-form computation.
   c. Prove `R_z(2π/5)^5 = I` via the trig closed forms (analogous to
      the existing `h3Rot3_cubed` template, just two more rounds of
      `Matrix.mul_fin_three`).
   d. Prove `h3Rot5 = P · R_z(2π/5) · Pᵀ` via `ring` on each entry.
   e. Conclude `h3Rot5^5 = I` by conjugation.
3. Commit each lemma as a separate small commit.
