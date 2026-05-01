/-
# E8.H3

The non-crystallographic Coxeter group H₃ (icosahedral symmetry, order 120)
acting on ℝ³, plus the orbit-counting lemmas needed by the theta
factorization.

## Generating set

Following the Phase 1 Python POC we use three rotation generators
together with inversion `-I`. **The three rotations alone generate only
the proper rotation subgroup I ≅ A₅ of order 60** (every rotation has
determinant +1). Adjoining `-I` flips orientation and extends to the
full Coxeter group H₃ of order 120.

* `h3Rot2`  — 180° rotation about the x-axis: `diag(1, -1, -1)`.
* `h3Rot3`  — 120° rotation about the z-axis.
* `h3Rot5`  — 72° (= 2π/5) rotation about the icosahedral axis (0, 1, φ).
* `h3Inv`   — central inversion.

Replacing the rotations with three Coxeter reflections satisfying
`s_i² = 1` and `(s_1 s_2)^5 = (s_2 s_3)^3 = (s_1 s_3)^2 = 1` is an
equally valid and perhaps cleaner formalisation; we leave that as an
alternative to be filled in if the relations-based proof of
`h3_group_card = 120` is preferred.
-/

import E8.Projection
import Mathlib.GroupTheory.GroupAction.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

open Classical Matrix

namespace E8

/-- 180° rotation about the x-axis: `diag(1, -1, -1)`. `det = +1`. -/
noncomputable def h3Rot2 : Matrix (Fin 3) (Fin 3) ℝ :=
  Matrix.diagonal ![1, -1, -1]

/-- 120° (= 2π/3) rotation about the z-axis. `det = +1`. -/
noncomputable def h3Rot3 : Matrix (Fin 3) (Fin 3) ℝ :=
  !![(-1 : ℝ)/2, -Real.sqrt 3 / 2, 0;
     Real.sqrt 3 / 2, (-1 : ℝ)/2, 0;
     0, 0, 1]

/-- 72° (= 2π/5) rotation about the icosahedral axis `(0, 1, φ)`.

Constructed via Rodrigues' formula. The axis has squared length
`1 + φ² = 2 + φ` (cf. `phi_sq`), so the unit-axis components are
`u_y = 1 / √(2+φ)` and `u_z = φ / √(2+φ)`. With `c = cos(2π/5)` and
`s = sin(2π/5)` the rotation matrix has the form below. -/
noncomputable def h3Rot5 : Matrix (Fin 3) (Fin 3) ℝ :=
  let n  : ℝ := 2 + phi
  let uy : ℝ := 1 / Real.sqrt n
  let uz : ℝ := phi / Real.sqrt n
  let c  : ℝ := Real.cos (2 * Real.pi / 5)
  let s  : ℝ := Real.sin (2 * Real.pi / 5)
  !![c,         -uz * s,                      uy * s;
     uz * s,    c + (1 - c) * uy ^ 2,         (1 - c) * uy * uz;
     -uy * s,   (1 - c) * uy * uz,            c + (1 - c) * uz ^ 2]

/-- Central inversion `-I`. `det = -1`. Required to lift the rotation
subgroup of order 60 to the full H₃ of order 120. -/
def h3Inv : Matrix (Fin 3) (Fin 3) ℝ := -1

/-- Backwards-compatible aliases under the names used elsewhere in the
skeleton. The first three are the rotation generators; `h3Inv` is now
also part of the generating set. -/
noncomputable def h3Gen1 : Matrix (Fin 3) (Fin 3) ℝ := h3Rot2
noncomputable def h3Gen2 : Matrix (Fin 3) (Fin 3) ℝ := h3Rot3
noncomputable def h3Gen3 : Matrix (Fin 3) (Fin 3) ℝ := h3Rot5

/-- The four generators of H₃: three rotations plus inversion. -/
noncomputable def h3Gens : Finset (Matrix (Fin 3) (Fin 3) ℝ) :=
  {h3Rot2, h3Rot3, h3Rot5, h3Inv}

/-! ## Order-2 power relations

These are the easiest matrix-power identities in the Coxeter
presentation of H₃. They are the first concrete steps of the multi-week
work-stream that closes `h3_group_card = 120`.

The proofs use mathlib's `Matrix.mul_fin_three` and `Matrix.one_fin_three`
to reduce the question to scalar arithmetic over ℝ. -/

/-- `h3Inv = -I`, so `h3Inv * h3Inv = (-1) * (-1) = 1` in the matrix ring. -/
theorem h3Inv_sq : h3Inv * h3Inv = (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  show (-1 : Matrix (Fin 3) (Fin 3) ℝ) * (-1) = 1
  rw [neg_mul_neg, mul_one]

/-- `h3Rot2 = diag(1, -1, -1)`, so `h3Rot2 * h3Rot2 = diag(1, 1, 1) = 1`. -/
theorem h3Rot2_sq : h3Rot2 * h3Rot2 = (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  show Matrix.diagonal ![1, -1, -1] * Matrix.diagonal ![1, -1, -1] = 1
  rw [Matrix.diagonal_mul_diagonal]
  have h : (fun i : Fin 3 => (![(1 : ℝ), -1, -1] : Fin 3 → ℝ) i *
                              (![(1 : ℝ), -1, -1] : Fin 3 → ℝ) i) = fun _ => 1 := by
    funext i
    fin_cases i <;> simp
  rw [h, Matrix.diagonal_one]

/-- `(√3)² = 3`. Helper for the order-3 matrix relation. -/
private lemma sqrt3_mul_self : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

/-- `(h3Rot3)² = !![-1/2, √3/2, 0; -√3/2, -1/2, 0; 0, 0, 1]`,
i.e. the 240° rotation. Stepping stone to `h3Rot3_cubed`. -/
theorem h3Rot3_sq_form :
    h3Rot3 * h3Rot3 =
      !![(-1 : ℝ)/2, Real.sqrt 3 / 2, 0;
         -Real.sqrt 3 / 2, (-1 : ℝ)/2, 0;
         0, 0, 1] := by
  unfold h3Rot3
  rw [Matrix.mul_fin_three]
  have h := sqrt3_mul_self
  ext i j
  fin_cases i <;> fin_cases j <;> simp <;> nlinarith [h]

/-- `(h3Rot3)³ = I`. The 120° rotation about the z-axis has order 3. -/
theorem h3Rot3_cubed : h3Rot3 * h3Rot3 * h3Rot3 = (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  rw [h3Rot3_sq_form]
  unfold h3Rot3
  rw [Matrix.mul_fin_three, Matrix.one_fin_three]
  have h := sqrt3_mul_self
  ext i j
  fin_cases i <;> fin_cases j <;> simp <;> nlinarith [h]

/-- `h3Rot2` rewritten in `!![…]` form, for use with `Matrix.mul_fin_three`. -/
private lemma h3Rot2_eq_matrix :
    h3Rot2 = !![(1 : ℝ), 0, 0; 0, -1, 0; 0, 0, -1] := by
  unfold h3Rot2
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.diagonal]

/-- Explicit form of `h3Rot2 * h3Rot3`. Stepping stone. -/
private lemma h3Rot2_mul_h3Rot3_form :
    h3Rot2 * h3Rot3 =
      !![(-1 : ℝ)/2, -Real.sqrt 3 / 2, 0;
         -Real.sqrt 3 / 2, (1 : ℝ)/2, 0;
         0, 0, -1] := by
  rw [h3Rot2_eq_matrix]
  unfold h3Rot3
  rw [Matrix.mul_fin_three]
  ext i j
  fin_cases i <;> fin_cases j <;> simp <;> ring

/-- `(h3Rot2 · h3Rot3)² = I`. The product of the 180° x-axis rotation with
the 120° z-axis rotation has trace `-1` and determinant `+1`, hence is a
180° rotation about some axis — order 2. -/
theorem h3Rot2_mul_h3Rot3_sq :
    (h3Rot2 * h3Rot3) * (h3Rot2 * h3Rot3) = (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  rw [h3Rot2_mul_h3Rot3_form]
  rw [Matrix.mul_fin_three, Matrix.one_fin_three]
  have h := sqrt3_mul_self
  ext i j
  fin_cases i <;> fin_cases j <;> simp <;> nlinarith [h]

/-- The H₃ group as a finite subset of GL₃(ℝ). Built as the closure of
`h3Gens` under matrix multiplication. -/
noncomputable def h3Group : Finset (Matrix (Fin 3) (Fin 3) ℝ) := sorry

/-- |H₃| = 120. This is the icosahedral Coxeter order. -/
theorem h3_group_card : h3Group.card = 120 := sorry

/-- |I| = 60. The proper rotation subgroup A₅ generated by the three
rotations alone. -/
noncomputable def h3RotationSubgroup : Finset (Matrix (Fin 3) (Fin 3) ℝ) := sorry

theorem h3_rotation_subgroup_card : h3RotationSubgroup.card = 60 := sorry

/-- Action of an H₃ element on a point in ℝ³. -/
noncomputable def h3Act
    (g : Matrix (Fin 3) (Fin 3) ℝ) (p : Fin 3 → ℝ) : Fin 3 → ℝ :=
  g.mulVec p

/-- The H₃ orbit of a point in ℝ³. -/
noncomputable def orbitOf (p : Fin 3 → ℝ) : Finset (Fin 3 → ℝ) :=
  h3Group.image (fun g => h3Act g p)

/-- The image of the E₈ roots under the φ-weighted projection. -/
noncomputable def projectedRoots : Finset (Fin 3 → ℝ) := e8Roots.image project

/-- The orbits of the projected E₈ roots under H₃ all have icosahedral size.

This is the Phase 1 numerical observation lifted to a Lean statement;
the proof is the central representation-theoretic content of Phase 3. -/
theorem orbit_sizes_are_icosahedral
    (o : Finset (Fin 3 → ℝ))
    (ho : ∃ p ∈ projectedRoots, o = orbitOf p) :
    o.card = 12 ∨ o.card = 20 ∨ o.card = 30 ∨ o.card = 60 ∨ o.card = 120 := by
  sorry

end E8
