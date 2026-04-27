/-
# E8.Projection

The φ-weighted projection ℝ⁸ → ℝ³ that, after a uniform δ-rescaling,
realises the E₈ → H₃ branching numerically observed in Phase 1.

The exact projection matrix is taken as a *placeholder* below: the entries
match the Python POC up to row normalisation. Replacing the placeholder with
a fully normalised version (and proving its kernel is the D₅ sublattice) is
one of the first concrete obligations of the formalisation.
-/

import E8.Basic
import Mathlib.LinearAlgebra.Matrix.DotProduct
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Matrix.Basic

open Classical Matrix

namespace E8

/-- The φ-weighted projection ℝ⁸ → ℝ³. Rows are the candidate H₃ axes
generated in the Phase 1 numerical experiment. -/
noncomputable def P : Matrix (Fin 3) (Fin 8) ℝ :=
  !![1, phi,   0,   0, 0,   0,       0, 0;
     0,   0,   1, phi, 0,   0,       0, 0;
     0,   0,   0,   0, 1, phi, phi ^ 2, 0]

/-- Apply the projection then the uniform δ-scaling.

The "δ drag" implements the aetheric refractive index: every projected
component is stretched by `1 + δ`. This is the computationally cheap
analogue of what in Phase 2 was a representation-theoretic decoupling. -/
noncomputable def project (x : Fin 8 → ℝ) : Fin 3 → ℝ :=
  fun i => (P.mulVec x) i * (1 + delta)

/-- Squared Euclidean norm of the projected vector. This is the exponent
appearing in the projected theta series. -/
noncomputable def projectedNormSq (x : Fin 8 → ℝ) : ℝ :=
  ∑ i : Fin 3, (project x i) ^ 2

/-- Sanity lemma: `projectedNormSq` is non-negative. -/
lemma projectedNormSq_nonneg (x : Fin 8 → ℝ) : 0 ≤ projectedNormSq x := by
  unfold projectedNormSq
  exact Finset.sum_nonneg (fun i _ => sq_nonneg _)

/-- The projection respects the φ-power scaling that makes `P` an icosian
projector. (Stated; proof to be filled in.) -/
theorem P_phi_scaling (x : Fin 8 → ℝ) :
    P.mulVec (phi • x) = phi • (P.mulVec x) := by
  simp [Matrix.mulVec_smul]

/-- The origin maps to the origin. Sanity lemma. -/
theorem origin_is_fixed_point : projectedNormSq (fun _ => 0) = 0 := by
  have hzero : P.mulVec (fun _ => 0 : Fin 8 → ℝ) = 0 := Matrix.mulVec_zero P
  unfold projectedNormSq project
  simp [hzero]

/-- Squared 2-norm of row 0 of `P`: `1 + φ² = 2 + φ`. -/
theorem P_row0_normSq : (1 : ℝ) ^ 2 + phi ^ 2 = 2 + phi := by
  have h := phi_sq
  linarith

/-- Squared 2-norm of row 1 of `P`: same as row 0. -/
theorem P_row1_normSq : (1 : ℝ) ^ 2 + phi ^ 2 = 2 + phi := P_row0_normSq

/-- Squared 2-norm of row 2 of `P`: `1 + φ² + φ⁴ = 4(φ + 1) = 4 φ²`.
Uses the fact that `φ² = φ + 1` twice. -/
theorem P_row2_normSq : (1 : ℝ) ^ 2 + phi ^ 2 + (phi ^ 2) ^ 2 = 4 * (phi + 1) := by
  have h := phi_sq
  nlinarith [h]

end E8
