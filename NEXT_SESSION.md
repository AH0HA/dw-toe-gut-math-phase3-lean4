# Next-session continuation prompt

Copy-paste the section below into a fresh Claude Code session to resume
work on the Phase 3 Lean 4 formalisation.

---

## Prompt to paste

> I'm continuing the Phase 3 Lean 4 formalisation of the E₈ → H₃ theta
> factorisation. Working directory `/home/user/dw-toe-gut-math-phase3-lean4`,
> branch `claude/lean4-setup-Otgd0`. Read `NEXT_SESSION.md` for the full
> state and the next concrete task. After you've read it, either start
> on the **next concrete task** (the two scalar trig identities for
> `2π/5`) or, if you'd prefer to verify the build first, run
> `lake build E8` and confirm it's still green.

---

## Project state at the end of the previous session

* Branch: `claude/lean4-setup-Otgd0` on `origin/AH0HA/dw-toe-gut-math-phase3-lean4`.
* Latest commit: `179a7b7 Phase 3: prove h3Rot2_mul_h3Rot3_sq -- order-2 product relation`.
* `lake build E8` is green, 6 `sorry`s total:
  * `E8/Basic.lean` — 0
  * `E8/Projection.lean` — 0
  * `E8/H3.lean` — 5 (`h3Group`, `h3_group_card`, `h3RotationSubgroup`, `h3_rotation_subgroup_card`, `orbit_sizes_are_icosahedral`)
  * `E8/Theta.lean` — 1 (`e8_theta_factorizes_over_h3`, conditional on `h3_card`)

## H₃ Coxeter relations — 4 of 7 proved (no `sorry`)

```
✓ h3Inv_sq               : h3Inv * h3Inv = 1                    -- order 2
✓ h3Rot2_sq              : h3Rot2 * h3Rot2 = 1                  -- order 2
✓ h3Rot3_cubed           : h3Rot3 * h3Rot3 * h3Rot3 = 1         -- order 3
✓ h3Rot2_mul_h3Rot3_sq   : (h3Rot2 * h3Rot3)² = 1               -- order 2

Pending (all involve h3Rot5):
· h3Rot5^5 = 1
· (h3Rot2 · h3Rot5)^? = 1
· (h3Rot3 · h3Rot5)^? = 1
```

## Next concrete task

The blocker for the `h3Rot5` relations is two scalar identities:

```lean
Real.cos (2 * Real.pi / 5) = (Real.sqrt 5 - 1) / 4
Real.sin (2 * Real.pi / 5) ^ 2 = (10 + 2 * Real.sqrt 5) / 16
```

Mathlib has `Real.cos_pi_div_five` and `Real.sin_pi_div_five` (verify
the exact names against the local mathlib copy). The derivations:

* `cos(2π/5) = 2 · cos(π/5)² − 1 = 2 · ((√5 + 1)/4)² − 1`. Closes via
  `cos_two_mul` and `Real.sq_sqrt`.
* `sin(2π/5)² = 1 − cos(2π/5)²`. Closes via `Real.sin_sq + Real.cos_sq`.

Once those two are in hand, the matrix-level proof of `h3Rot5^5 = 1`
follows the same template as `h3Rot3_cubed`: a stepping-stone form
(`h3Rot5^2 = !![…]`), then a chain of `Matrix.mul_fin_three` rewrites,
then `ext i j; fin_cases i <;> fin_cases j <;> simp <;> nlinarith [trig
identities, sqrt5_mul_self, etc.]`. Expect the `nlinarith` invocations
to need substantial hint sets given the nested-radical entries.

## Environment notes

* Lean toolchain: `leanprover/lean4:v4.30.0-rc2` installed at
  `~/.elan/toolchains/leanprover--lean4---v4.30.0-rc2/`. Side-loaded
  from GitHub releases because `releases.lean-lang.org` was returning
  503 at install time.
* Mathlib cache: pre-fetched via `lake exe cache get` (8322 oleans).
  Avoid `import Mathlib` (top-level) — it forces a full clang IR build.
  Use targeted imports as in the existing files.
* `lake build E8` uses ~5 s after the cache; `lake build` (no target)
  also avoids the executable target which would otherwise force native
  compilation of the entire mathlib runtime.

## Files to consult

* `E8/H3.lean` — site of all remaining power-relation work.
* `E8/Basic.lean` — sorry-free, useful as a reference for the
  `native_decide` + `Set.InjOn` pattern.
* `README.md` — high-level project description and obligation table.
* `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Trigonometric/Basic.lean`
  — search here for the existing `cos_pi_div_five`, `sin_pi_div_five`,
  `cos_two_mul`, `cos_sq + sin_sq` infrastructure.

## Things to avoid

* Pasting Grok-supplied patches verbatim. They have consistently
  contained markdown corruption (e.g. `[Mathlib.Data](http://Mathlib.Data).…`),
  type errors (`Subgroup (Matrix _ _ ℝ)` — Matrix isn't a group),
  fictional API calls (`raw.rowSumSq`, `(M i j).round 8`), and
  vacuous-`True`-via-`sorry` regressions of meaningful theorems. Audit
  every block before applying.
* `import Mathlib` (top-level) — pulls in a 16k-job native build.
* `<;> norm_num` chained after a goal-closing `simp` — fails with "no
  goals to be solved".

## Suggested workflow for the next session

1. `lake build E8` to confirm baseline is still green (~5 s).
2. Pick one of the two scalar trig identities. Try `cos_two_pi_div_five`
   first using `Real.cos_two_mul` + `Real.cos_pi_div_five`.
3. Once both scalars are in hand, attempt `h3Rot5_sq_form` (the
   stepping stone) before `h3Rot5_pow_five`.
4. Commit each lemma as a separate small commit so progress is
   reviewable.
