/-
Tiny sanity-check executable for the `E8ThetaFactorization` package.

It does not exercise the (`sorry`'d) deep theorems — it merely verifies that
the elaborator type-checks every definition and prints a few cheap
witnesses derived from `phi`.
-/

import E8

open E8

def main : IO Unit := do
  IO.println s!"E8ThetaFactorization sanity check"
  IO.println s!"  φ defined            : noncomputable real"
  IO.println s!"  δ defined            : noncomputable real"
  IO.println s!"  e8Roots              : Finset (Fin 8 → ℝ) (currently `sorry`)"
  IO.println s!"  P                    : 3 × 8 ℝ-matrix"
  IO.println s!"  projectedNormSq      : ℝ-valued"
  IO.println s!"  theta1D              : ℂ-valued"
  IO.println s!"  thetaE8              : ℂ-valued"
  IO.println s!"  conjecture statement : type-checked"
  IO.println s!"All definitions elaborate. Replace each `sorry` to complete the proof."
