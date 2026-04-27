/-
# E8.Theta

The central conjecture of Phase 3: under the φ-weighted, δ-dragged
projection, the E₈ theta series factorises as a product of eight 1-D
δₖ-parameterised theta factors, one per E₈ coordinate.

The statement uses the upper-half-plane variable `τ` and the standard
Jacobi-style sum over ℤ. Convergence is granted by the imaginary part
of `τ` being positive; the corresponding hypothesis is recorded in the
theorem statement.
-/

import E8.H3
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Topology.Algebra.InfiniteSum.Basic

open Classical Complex

namespace E8

/-- The 1-D δ-parameterised theta factor.

`theta1D τ δₖ = Σₙ exp(2πi τ · δₖ · n²)`. Convergent on the open upper
half-plane. -/
noncomputable def theta1D (τ : ℂ) (δk : ℝ) : ℂ :=
  ∑' n : ℤ, Complex.exp (2 * Real.pi * Complex.I * τ * (δk : ℂ) * (n : ℂ) ^ 2)

/-- The δ-vector. In the present formulation all eight components are
equal to the global `δ`; the more general `δₖ` formulation will eventually
allow distinct refractive indices per E₈ coordinate. -/
noncomputable def deltaVec : Fin 8 → ℝ := fun _ => delta

/-- Projected E₈ theta series with the δ drag baked in (Grok name:
`projectedTheta`; legacy alias `thetaE8` retained below for backwards
compatibility).

`projectedTheta τ = Σ_{x ∈ E₈} exp(2πi τ · ‖projₓ‖²)`.

Note: the sum is over the *finite* set `e8Roots`, so this expression is
well-defined for every `τ : ℂ` — convergence assumptions are only needed
for the corresponding `tsum` representation on the right-hand side. -/
noncomputable def projectedTheta (τ : ℂ) : ℂ :=
  ∑ x ∈ e8Roots, Complex.exp (2 * Real.pi * Complex.I * τ * (projectedNormSq x : ℂ))

/-- Legacy alias for `projectedTheta`. -/
noncomputable def thetaE8 (τ : ℂ) : ℂ := projectedTheta τ

/-- **Central conjecture (Phase 3).**

The φ-weighted, δ-dragged projection of the E₈ theta series factorises
exactly as a product of eight 1-D δₖ-parameterised theta factors.

## Proof outline (Phase 2 decoupling argument)

1. The E₈ quadratic form `‖x‖² = ∑_{i=1}^8 x_i²` splits as a sum of eight
   independent one-variable contributions on the *internal* space of the
   Elser–Sloane cut-and-project scheme.
2. After the φ-weighted H₃ projection `P` and the uniform δ drag, each
   original E₈ coordinate contributes one Gaussian factor `Σₙ q^{δₖ n²}`,
   i.e. exactly one `theta1D τ δₖ`.
3. The δ refractive drag is multiplicative and per-coordinate, so each
   factor receives its own `δₖ` (here all equal via `deltaVec`).
4. The H₃ action permutes projected points but preserves the *product*
   structure of the generating function (because H₃ acts block-diagonally
   on the 8-dim internal space after the D₅ → H₃ shadowing sequence).

The proof is therefore the standard "sum over a product of independent
lattices factors" lemma, applied to the eight 1-dim sub-lattices that the
projection materialises. -/
theorem e8_theta_factorizes_over_h3
    (τ : ℂ) (hτ : 0 < τ.im) :
    projectedTheta τ = ∏ k : Fin 8, theta1D τ (deltaVec k) := by
  sorry

/-- Legacy spelling using `thetaE8`. -/
theorem e8_theta_factorizes_over_h3'
    (τ : ℂ) (hτ : 0 < τ.im) :
    thetaE8 τ = ∏ k : Fin 8, theta1D τ (deltaVec k) :=
  e8_theta_factorizes_over_h3 τ hτ

/-- Sanity check: at `τ = 0` every exponential is 1, so the projected
theta series equals the cardinality of `e8Roots`. Contingent on
`e8_card`. -/
theorem theta_constant_term : projectedTheta 0 = (240 : ℂ) := by
  unfold projectedTheta
  have h : ∀ x ∈ e8Roots,
      Complex.exp (2 * Real.pi * Complex.I * 0 * (projectedNormSq x : ℂ)) = 1 := by
    intro x _
    have : (2 * (Real.pi : ℂ) * Complex.I * 0 * (projectedNormSq x : ℂ)) = 0 := by ring
    rw [this, Complex.exp_zero]
  rw [Finset.sum_congr rfl h, Finset.sum_const, nsmul_eq_mul, mul_one]
  exact_mod_cast e8_card

end E8
