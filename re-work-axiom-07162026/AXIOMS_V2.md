# The Six Axioms, Restated (v2 — 2026-07-16)

Reworking of the six axioms of *COHERENCE: THE GEOMETRY OF EVERYTHING*
(v1618G03), following the numerical and mathematical audit of July 2026
(see `NUMERICAL_AUDIT.md` and `../THETA_STATEMENT_AUDIT.md`).

## The three registers

Every claim in the framework is now tagged with exactly one register, and
each register is held to its own standard:

| Tag | Register | Standard |
|-----|----------|----------|
| **[M]** | Mathematics | Provable or false. No axioms allowed here — only definitions, theorems (proved), and conjectures (open, with status). |
| **[P]** | Physics | Falsifiable postulates. Each must name its falsifiers and reduce to established physics in the tested regimes. |
| **[I]** | Interpretation | Declared readings. Legitimate content, but never presented as something the mathematics proves. |

The original axioms failed not because their content was worthless but
because each one fused all three registers into a single sentence, so a
falsified detail in one register silently discredited the others.

---

## Axiom 1 — The Medium [P]

**Original.** "The vacuum is a compressible, non-viscous superfluid aether."

**Restated.** The vacuum admits an effective description as a compressible
superfluid: its long-wavelength excitations reproduce the observed
relativistic fields, and gravity emerges from gradients of condensate
density and flow (the Madelung / quantum-potential sector).

**Obligations and falsifiers.**
- Must recover local Lorentz invariance. Current experimental bounds
  (e.g. Fermi-LAT gamma-ray-burst dispersion limits) already exclude naive
  preferred-frame models; the postulate survives only in parameter ranges
  compatible with those nulls.
- Must recover a spin-2 graviton in the weak-field limit (open item,
  correctly flagged as such in Ch. 31 of v1618G03).

**Lineage.** Madelung (1927); Unruh, *Experimental Black-Hole
Evaporation?* (1981); Volovik, *The Universe in a Helium Droplet* (2003).
This is a minority but methodologically respectable effective-theory
program.

**Effect of the icosian reformulation.** None. This axiom is about the
medium, not the lattice. Unchanged.

---

## Axiom 2 — The Ratio [M]

**Original.** "The Golden Ratio is the unique solution for non-destructive
wave interference."

**Restated — clause (a), theorem grade.** Golden-ratio scaling is the
arithmetic signature of icosahedral order: the non-crystallographic
Coxeter groups H₃ and H₄ are defined over ℤ[φ] and over no smaller ring.
Any structure with icosahedral symmetry is therefore necessarily golden.
φ is *forced* by the geometry — it is not a modelling choice.

**Restated — clause (b), corrected closure claim.** On a geometric
frequency ladder, requiring both the sum tone f(1+r) and the difference
tone f(r−1) of adjacent tones to land back on the ladder forces r to be a
*morphic number*. Exactly two exist (Aarts–Fokkink–Kruijtzer, 2001):

- φ ≈ 1.618…, closing at adjacent rungs: 1+φ = φ², φ−1 = φ⁻¹;
- the plastic number ρ ≈ 1.3247…, closing at distant rungs:
  1+ρ = ρ³, ρ−1 = ρ⁻⁴ (both exact; verified numerically in
  `NUMERICAL_AUDIT.md`).

φ is the **unique nearest-rung** closure. The v1 uniqueness claim without
that qualifier is false.

**What changed.** The uniqueness claim is corrected, and the grounding is
upgraded from an acoustic argument to an arithmetic theorem. This axiom
comes out of the audit *stronger* than it went in. A supporting fact worth
keeping from v1: φ is the "most irrational" number (continued fraction of
all 1s), which is the standard ingredient in KAM-type stability arguments.

---

## Axiom 3 — demoted to Conjecture N1: The Mass Ratio [M, conjecture]

**Original.** "Axiom 3: m_p/m_e = 6π⁵", rehabilitated with the δ
correction.

**Restated.** *Conjecture N1.* m_p/m_e = 6π⁵ (1 + α²/2√2).
With CODATA 2018 inputs this evaluates to 1836.1526777 against the
measured 1836.15267343 — a residual of **2.3 parts per billion** with no
free parameters. Verified in `NUMERICAL_AUDIT.md`.

**Canonical δ.** The framework now defines **one** value, book-wide:

    δ := α²/(2√2) = 1.882720 × 10⁻⁵   (CODATA 2018 α)

v1618G03 used three inconsistent values (1.8828 in Ch. 3, 1.88254 in
Ch. 5, 1.88272 implied by the α formula). Because downstream formulas
raised δ to the 8th power, that inconsistency silently moved predictions
by ~1,000 ppm. One value, stated to full precision, everywhere.

**Status and evidential policy.** This is an unexplained numerical
observation, not a result. The proton mass is overwhelmingly QCD binding
energy, so a closed form in π and α alone currently has no candidate
mechanism; and searches over simple-constant expressions produce
ppb-level matches more often than intuition suggests (look-elsewhere
effect). The conjecture gains evidential weight only if a mechanism
*predicts* it, or if it survives future CODATA digit revisions it did not
help choose. Until then it is a remarkable curiosity, honestly labeled.

---

## Axiom 4 — Gravity [P]

**Original.** "Gravity is centripetal acceleration of charge toward a
Still Point created by fractal nesting", quantified by
α_G = 847 δ⁸/(720π).

**Restated.** Gravitational attraction emerges as the quantum-potential
gradient of condensate density enhancements around coherent standing-wave
structures. In the weak-field limit this must reproduce Newtonian gravity
and the post-Newtonian parameters of general relativity, which are its
falsifiers (equivalence-principle tests, PPN bounds).

**The δ⁸ → G bridge is retired** to the open-curiosities appendix, for
three independent reasons established in the audit:

1. The rationale for the exponent 8 ("one δ per lost E₈ dimension") died
   with the eight-factor theta conjecture, which is provably false
   (`CENTRAL_EQUATION.md`, Theorem 0).
2. The icosian structure of E₈ makes the natural multiplicities 4
   (ℤ[φ]-rank) and 2 (quaternionic), not 8.
3. Numerically, the formula fails its own accuracy claim: with Ch. 5's
   own δ it lands +116 ppm from CODATA α_G (claimed: ~50 ppm; CODATA G
   uncertainty: 22 ppm), and the prediction swings by ~2,100 ppm across
   the δ values used in different chapters of v1 — the eighth power
   amplifies the 4th decimal of an underived input. See
   `NUMERICAL_AUDIT.md`, Table 2.

---

## Axiom 5 — The Still Point [I], with one mathematical footnote [M]

**Original.** "Consciousness is a phase-conjugate still point — the fixed
point where Ψ = Ψ*, velocity is zero, density is maximal, and the mirror
reflects."

**Restated.** *Interpretive principle:* the framework reads the
invariants — what remains unchanged under the mirror — as the locus of
awareness. This is a declared reading. The mathematics is compatible with
it; the mathematics does not prove it, and the framework no longer claims
that it does.

**Mathematical footnote.** Two true statements sit behind the image:

- Fixed points of phase conjugation Ψ → Ψ* are where the field is real
  and the velocity field vanishes. True, elementary, and carrying no
  explanatory force by itself (every linear projection fixes the origin;
  every wave field has nodes).
- **New, from the icosian reformulation:** the physical/internal mirror
  of the E₈ → 3D projection is Galois conjugation σ: φ ↦ 1−φ of the field
  ℚ(√5), and the fixed field of σ is exactly ℚ — the *rational*, i.e.
  shareable, quantities. "The still point is what the mirror leaves
  unchanged" now has a precise arithmetic incarnation. This upgrade came
  directly out of replacing the broken projection pipeline.

---

## Axiom 6 — Metabolism [P]

**Original.** "Charge metabolism: the conversion of normal-fluid entropy
back into superfluid condensate at the still point."

**Restated.** Coherent systems maintain and grow internal order by
exporting entropy to their environment across a coupling surface.
"Charge metabolism" is the framework's name for this local negentropic
exchange.

**What changed.** The strong form — net conversion of entropy back into
order — violated the second law and was unnecessary for every downstream
use in the book. The restated form is standard nonequilibrium
thermodynamics (Schrödinger's negentropy, 1944; Prigogine's dissipative
structures), true, and falsifiable system-by-system by measuring entropy
budgets. The second law is honored globally.

---

## Summary table

| Axiom | v1 status | v2 status | Change |
|-------|-----------|-----------|--------|
| 1 Medium | asserted | [P] postulate with named falsifiers | light edit |
| 2 Ratio | uniqueness false as stated | [M] theorem (ℤ[φ]) + corrected closure | **strengthened** |
| 3 Mass ratio | axiom | [M] Conjecture N1, canonical δ fixed | demoted, preserved |
| 4 Gravity | axiom + δ⁸ formula | [P] postulate; δ⁸ bridge retired | pruned |
| 5 Still point | axiom | [I] reading + arithmetic footnote | register-split, enriched |
| 6 Metabolism | violated 2nd law | [P] entropy-export form | corrected |
