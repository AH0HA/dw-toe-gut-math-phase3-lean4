/-
# E8.H3

The non-crystallographic Coxeter group H₃ (icosahedral symmetry, order 120)
acting on ℝ³, plus the orbit-counting lemmas needed by the theta
factorization.

We model H₃ as the closure of three reflection generators inside the group
of 3×3 real matrices. The concrete generators are taken from the Phase 1
Python script.
-/

import E8.Projection
import Mathlib.GroupTheory.GroupAction.Basic
import Mathlib.Data.Fintype.Basic

open Classical

namespace E8

/-- First reflection generator of H₃ (placeholder — copy from Python POC). -/
noncomputable def h3Gen1 : Matrix (Fin 3) (Fin 3) ℝ := sorry

/-- Second reflection generator of H₃. -/
noncomputable def h3Gen2 : Matrix (Fin 3) (Fin 3) ℝ := sorry

/-- Third reflection generator of H₃. -/
noncomputable def h3Gen3 : Matrix (Fin 3) (Fin 3) ℝ := sorry

/-- The set of H₃ generators. -/
noncomputable def h3Gens : Finset (Matrix (Fin 3) (Fin 3) ℝ) :=
  {h3Gen1, h3Gen2, h3Gen3}

/-- The H₃ group as a finite subset of GL₃(ℝ). Built as the closure of
`h3Gens` under matrix multiplication. -/
noncomputable def h3Group : Finset (Matrix (Fin 3) (Fin 3) ℝ) := sorry

/-- |H₃| = 120. This is the icosahedral order. -/
theorem h3_group_card : h3Group.card = 120 := sorry

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
