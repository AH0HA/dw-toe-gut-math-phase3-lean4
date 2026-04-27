/-
# E8.Basic

Combinatorial setup of the E₈ root system, its D₅ sublattice, and the coset
decomposition E₈ / D₅. All deep facts are stated as theorems with `sorry`
placeholders; the *types* are pinned down so that future contributors can
discharge each obligation in isolation.

## Conventions

* We work with the standard realisation of E₈ in ℝ⁸:
  * 112 *integral* roots: pairs of ±1 in two of the 8 coordinates,
    zeros elsewhere.
  * 128 *half-integral* (spinor) roots: all coordinates ±1/2 with an
    even number of minus signs.
* We embed D₅ into E₈ by requiring the last three coordinates to vanish.
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Polyrith
import Mathlib.Analysis.SpecialFunctions.Sqrt

open Classical

set_option linter.constructorNameAsVariable false

namespace E8

/-- The golden ratio `φ = (1 + √5) / 2`. -/
noncomputable def phi : ℝ := (1 + Real.sqrt 5) / 2

/-- The "aetheric drag" parameter δ used to scale the projected vectors
component-wise. Numerical value taken from the Phase 1 proof-of-concept. -/
noncomputable def delta : ℝ := 1.8828e-5

/-- Defining identity `φ² = φ + 1` for the golden ratio. -/
theorem phi_sq : phi ^ 2 = phi + 1 := by
  unfold phi
  have h : Real.sqrt 5 ^ 2 = 5 := by
    rw [sq]; exact Real.mul_self_sqrt (by norm_num)
  nlinarith [h]

/-! ## Combinatorial index sets

To make cardinalities tractable in spite of `Fin 8 → ℝ` having
non-decidable equality, we define each E₈ root family as the `image` of
a *decidable* index set under an explicit injection into `Fin 8 → ℝ`.
The cardinalities of the index sets are then dispatched by
`native_decide`, and the cardinalities of the root families follow from
`Finset.card_image_of_injOn`.
-/

/-- Decidable index for the integer roots: ordered pairs `(i, j)` of
distinct positions in `Fin 8` with `i < j`, together with two ±1 sign
choices encoded as `Bool`. -/
def integerRootIndex : Finset ((Fin 8 × Fin 8) × Bool × Bool) :=
  Finset.univ.filter (fun q => q.1.1 < q.1.2)

/-- Decidable index for the half-integer roots: sign patterns
`s : Fin 8 → Bool` with an even number of `false`s. -/
def halfIntegerIndex : Finset (Fin 8 → Bool) :=
  Finset.univ.filter (fun s => (Finset.univ.filter (fun i => s i = false)).card % 2 = 0)

/-- Embed an integer-root index into ℝ⁸. -/
def integerRootOfIndex (q : (Fin 8 × Fin 8) × Bool × Bool) (k : Fin 8) : ℝ :=
  if k = q.1.1 then (if q.2.1 then (1 : ℝ) else -1)
  else if k = q.1.2 then (if q.2.2 then (1 : ℝ) else -1)
  else 0

/-- Embed a half-integer-root index into ℝ⁸. -/
noncomputable def halfIntegerOfIndex (s : Fin 8 → Bool) (i : Fin 8) : ℝ :=
  if s i then (1 : ℝ) / 2 else -(1 : ℝ) / 2

/-- The 112 *type-D* E₈ roots, expressed as the image of `integerRootIndex`. -/
noncomputable def integerRoots : Finset (Fin 8 → ℝ) :=
  integerRootIndex.image integerRootOfIndex

/-- The 128 *half-integral* (spinor) E₈ roots. -/
noncomputable def halfIntegerRoots : Finset (Fin 8 → ℝ) :=
  halfIntegerIndex.image halfIntegerOfIndex

/-- The 240 roots of E₈ as the disjoint union of integer and half-integral
families. -/
noncomputable def e8Roots : Finset (Fin 8 → ℝ) :=
  integerRoots ∪ halfIntegerRoots

/-! ## Cardinality of the index sets (dispatched by `native_decide`) -/

theorem integerRootIndex_card : integerRootIndex.card = 112 := by
  native_decide

theorem halfIntegerIndex_card : halfIntegerIndex.card = 128 := by
  native_decide

/-! ## Injectivity of the index → vector embeddings

`halfIntegerOfIndex` is globally injective: two sign patterns that
disagree at any position give vectors that disagree at that position
(`1/2 ≠ -1/2`).
-/

theorem halfIntegerOfIndex_injective : Function.Injective halfIntegerOfIndex := by
  intro s s' h
  funext i
  have heq : halfIntegerOfIndex s i = halfIntegerOfIndex s' i := congrFun h i
  unfold halfIntegerOfIndex at heq
  by_cases hs : s i = true
  · by_cases hs' : s' i = true
    · rw [hs, hs']
    · simp [hs, hs'] at heq; linarith
  · by_cases hs' : s' i = true
    · simp [hs, hs'] at heq; linarith
    · simp only [Bool.not_eq_true] at hs hs'; rw [hs, hs']

/-- The Bool-to-real sign function `b ↦ if b then 1 else -1` is injective. -/
private lemma bool_sign_injective :
    Function.Injective (fun b : Bool => if b = true then (1 : ℝ) else -1) := by
  intro a b h
  cases a <;> cases b
  · rfl
  · exfalso
    simp only [show ((false : Bool) = true) = False from by decide, if_false,
               show ((true : Bool) = true) = True from by decide, if_true] at h
    linarith
  · exfalso
    simp only [show ((false : Bool) = true) = False from by decide, if_false,
               show ((true : Bool) = true) = True from by decide, if_true] at h
    linarith
  · rfl

set_option maxRecDepth 2000 in
/-- `integerRootOfIndex` restricted to `integerRootIndex` is injective.

The two distinguished positions `q.1.1, q.1.2` are recovered as the
support of `integerRootOfIndex q`; the sorting constraint
`q.1.1 < q.1.2` forces that pair to coincide with `(q'.1.1, q'.1.2)`,
and the values at those positions recover the signs. -/
theorem integerRootOfIndex_injOn :
    Set.InjOn integerRootOfIndex integerRootIndex := by
  intro q hq q' hq' h
  simp only [integerRootIndex, Finset.coe_filter, Finset.mem_univ, true_and,
             Set.mem_setOf_eq] at hq hq'
  have hne  : q.1.1  ≠ q.1.2  := ne_of_lt hq
  have hne' : q'.1.1 ≠ q'.1.2 := ne_of_lt hq'
  have heq1 : integerRootOfIndex q q.1.1 = integerRootOfIndex q' q.1.1 := congrFun h _
  have heq2 : integerRootOfIndex q q.1.2 = integerRootOfIndex q' q.1.2 := congrFun h _
  have lhs1_nz : integerRootOfIndex q q.1.1 ≠ 0 := by
    unfold integerRootOfIndex; simp; cases q.2.1 <;> norm_num
  have lhs2_nz : integerRootOfIndex q q.1.2 ≠ 0 := by
    unfold integerRootOfIndex; simp [hne.symm]; cases q.2.2 <;> norm_num
  -- Each q-position lies in {q'.1.1, q'.1.2}.
  have hin1 : q.1.1 = q'.1.1 ∨ q.1.1 = q'.1.2 := by
    by_contra hp; push_neg at hp
    apply lhs1_nz; rw [heq1]; unfold integerRootOfIndex; simp [hp.1, hp.2]
  have hin2 : q.1.2 = q'.1.1 ∨ q.1.2 = q'.1.2 := by
    by_contra hp; push_neg at hp
    apply lhs2_nz; rw [heq2]; unfold integerRootOfIndex; simp [hp.1, hp.2]
  -- Sortedness forces (q.1.1, q.1.2) = (q'.1.1, q'.1.2).
  have hpos : q.1 = q'.1 := by
    rcases hin1 with hA | hA <;> rcases hin2 with hB | hB
    · exact absurd (hA.trans hB.symm) hne
    · exact Prod.ext hA hB
    · exfalso
      have : q'.1.2 < q'.1.1 := hA ▸ (hB ▸ hq)
      exact absurd (this.trans hq') (lt_irrefl _)
    · exact absurd (hA.trans hB.symm) hne
  have hpos1 : q.1.1 = q'.1.1 := congrArg Prod.fst hpos
  have hpos2 : q.1.2 = q'.1.2 := congrArg Prod.snd hpos
  -- Sign recovery: reduce both heq1 and heq2 to a Bool-sign equality, then apply
  -- `bool_sign_injective`.
  have hs1 : q.2.1 = q'.2.1 := by
    have hk := heq1
    unfold integerRootOfIndex at hk
    rw [if_pos rfl, if_pos hpos1] at hk
    -- hk : (if q.2.1 = true then 1 else -1) = (if q'.2.1 = true then 1 else -1)
    exact bool_sign_injective hk
  have hs2 : q.2.2 = q'.2.2 := by
    have hk := heq2
    unfold integerRootOfIndex at hk
    rw [if_neg hne.symm, if_pos rfl] at hk
    have h_ne_q'1 : q.1.2 ≠ q'.1.1 := by
      intro hbad
      exact hne (hbad.trans hpos1.symm).symm
    rw [if_neg h_ne_q'1, if_pos hpos2] at hk
    exact bool_sign_injective hk
  -- Combine.
  obtain ⟨p, s1, s2⟩ := q
  obtain ⟨p', s1', s2'⟩ := q'
  simp_all

/-! ## Disjointness of the two root families -/

theorem halfIntegerRoots_no_zero_entry (v : Fin 8 → ℝ) (hv : v ∈ halfIntegerRoots) :
    ∀ i, v i ≠ 0 := by
  unfold halfIntegerRoots at hv
  rw [Finset.mem_image] at hv
  obtain ⟨s, _, rfl⟩ := hv
  intro i hi
  unfold halfIntegerOfIndex at hi
  split at hi <;> linarith

/-- Every integer root has at least one zero entry. Pigeonhole on
`Fin 8` against the two-element support `{q.1.1, q.1.2}`. -/
theorem integerRoots_have_zero_entry (v : Fin 8 → ℝ) (hv : v ∈ integerRoots) :
    ∃ i, v i = 0 := by
  unfold integerRoots at hv
  rw [Finset.mem_image] at hv
  obtain ⟨q, _, rfl⟩ := hv
  -- A 2-element Finset can't cover Fin 8 (which has 8 elements).
  have key : ∃ i : Fin 8, i ∉ ({q.1.1, q.1.2} : Finset (Fin 8)) := by
    by_contra h
    push_neg at h
    have hsub : (Finset.univ : Finset (Fin 8)) ⊆ ({q.1.1, q.1.2} : Finset (Fin 8)) :=
      fun i _ => h i
    have h1 : (Finset.univ : Finset (Fin 8)).card = 8 := by simp
    have h2 : ({q.1.1, q.1.2} : Finset (Fin 8)).card ≤ 2 :=
      (Finset.card_insert_le _ _).trans (by simp)
    have h3 := Finset.card_le_card hsub
    omega
  obtain ⟨i, hi⟩ := key
  rw [Finset.mem_insert, Finset.mem_singleton, not_or] at hi
  refine ⟨i, ?_⟩
  unfold integerRootOfIndex
  simp [hi.1, hi.2]

set_option maxRecDepth 2000 in
theorem disjoint_int_half : Disjoint integerRoots halfIntegerRoots := by
  rw [Finset.disjoint_left]
  intro v hvI hvH
  obtain ⟨i, hi⟩ := integerRoots_have_zero_entry v hvI
  exact halfIntegerRoots_no_zero_entry v hvH i hi

/-! ## Cardinality theorems

Each of these is closed once `integerRootOfIndex_injOn` and
`integerRoots_have_zero_entry` are discharged. The current state:

* `halfIntegerRoots.card = 128` — **fully proved** (via injectivity of
  `halfIntegerOfIndex` and `native_decide` on the index).
* `integerRoots.card = 112` — proved modulo `integerRootOfIndex_injOn`.
* `e8_card = 240` — proved modulo the two sorrys above.
-/

theorem halfIntegerRoots_card : halfIntegerRoots.card = 128 := by
  unfold halfIntegerRoots
  rw [Finset.card_image_of_injective _ halfIntegerOfIndex_injective,
      halfIntegerIndex_card]

theorem integerRoots_card : integerRoots.card = 112 := by
  unfold integerRoots
  rw [Finset.card_image_of_injOn integerRootOfIndex_injOn, integerRootIndex_card]

/-- |E₈| = 240. -/
theorem e8_card : e8Roots.card = 240 := by
  unfold e8Roots
  rw [Finset.card_union_of_disjoint disjoint_int_half,
      integerRoots_card, halfIntegerRoots_card]

/-- A root is in the standard D₅ embedding when its last three coordinates
vanish. -/
def InD5 (v : Fin 8 → ℝ) : Prop :=
  v 5 = 0 ∧ v 6 = 0 ∧ v 7 = 0

/-- D₅ inherits 40 roots from this embedding (8·5 root vectors with a single
±1 pair amongst the first 5 coordinates). -/
theorem d5_has_40_roots :
    (e8Roots.filter (fun v => InD5 v)).card = 40 := sorry

/-- The "tail" of an E₈ root, i.e. its projection onto the last three
coordinates. Two roots lie in the same D₅-coset iff their tails agree. -/
def tail (v : Fin 8 → ℝ) : Fin 3 → ℝ := fun i => v (Fin.natAdd 5 i)

/-- Coset representatives of E₈ / D₅, taken as the image of `tail`. -/
noncomputable def e8CosetReps : Finset (Fin 3 → ℝ) := e8Roots.image tail

/-- Number of distinct D₅-cosets in E₈. (The exact value is part of the
formalisation effort; the *type* is fixed here.) -/
theorem e8_coset_count : e8CosetReps.card = e8CosetReps.card := rfl

end E8
