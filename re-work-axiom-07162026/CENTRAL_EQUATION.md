# The Central Equation, Replaced (v2 — 2026-07-16)

This document replaces the central conjecture of Ch. 29 / §38.8 of
v1618G03 ("the E₈ theta function, restricted to D₅ and projected onto the
H₃ orbit space, factorizes into eight identical one-dimensional
factors").

## Theorem 0 — the old conjecture is false

No formulation faithful to the E₈ lattice can factor its theta function
into eight rank-1 theta factors.

*Proof.* A lattice theta function factors into eight rank-1 factors only
if the lattice is an orthogonal direct sum L = ℤv₁ ⊥ ⋯ ⊥ ℤv₈, in which
case det L = ∏‖vᵢ‖². E₈ is even (every ‖v‖² is an even integer ≥ 2) and
unimodular (det = 1), so 1 would have to be a product of eight integers
≥ 2. Contradiction. Independently, E₈ is indecomposable, and orthogonal
decompositions of definite lattices are unique (Eichler), so no hidden
rotation evades the argument. ∎

(For the specific finite-sum statement that was formalized in
`E8/Theta.lean`, there is an even simpler refutation by cusp values —
see `../THETA_STATEMENT_AUDIT.md`.)

Two further audit results close out the old pipeline: the sum over
*projected* points of the full lattice diverges for every τ, because the
image of a cut-and-project scheme is dense in ℝ³ (infinitely many lattice
vectors have bounded projected norm); and a uniform (1+δ) scaling of
projected coordinates is a reparameterization of τ, mathematically inert.

## The replacement: descent to the icosians

**Setup (all standard).** Let 𝕀 be the icosian ring: the ℤ[φ]-span of the
120 unit icosians (the binary icosahedral group 2I) inside the
quaternions over ℚ(√5). Let N: 𝕀 → ℤ[φ] be the quaternionic norm
N(x) = x x̄, which takes totally positive values on 𝕀 \ {0}, and let
σ: ℚ(√5) → ℚ(√5) be the Galois conjugation φ ↦ 1 − φ.

**Known theorem (Conway–Sloane, SPLAG §8.2; Moody–Patera; used by
Elser–Sloane 1987).** The icosian ring, equipped with the trace form
Q(x) = N(x) + σ(N(x)) (up to standard normalization, to be pinned exactly
in the Lean formalization), is isometric to the E₈ lattice. In other
words: **E₈ is a free ℤ[φ]-module of rank 4**, and the "internal space"
of the icosahedral cut-and-project scheme is the Galois conjugate — not a
tunable parameter.

**Definition (the central object).** The two-variable icosian theta:

    Θ_𝕀(τ₁, τ₂) := Σ_{x ∈ 𝕀} exp( 2πi ( N(x)·τ₁ + σ(N(x))·τ₂ ) ),
    τ₁, τ₂ in the upper half-plane.

Convergence is immediate: Q(x) = N(x) + σN(x) → ∞ realizes the E₈ norm,
and both exponents contribute decay.

**Claim C1 (theorem grade — diagonal specialization).**

    Θ_𝕀(τ, τ) = Θ_{E₈}(τ) = E₄(τ),

the weight-4 Eisenstein series. This is immediate from the isometry above
and is the exact statement that "the 8-dimensional theta descends to a
4-dimensional arithmetic object over ℚ(√5)."

**Claim C2 (believed known — modularity).** Θ_𝕀 is a Hilbert modular form
of weight 2 for the Hilbert modular group of ℚ(√5) (with the appropriate
level and character), and is expected to be identified with the weight-2
Hilbert Eisenstein series for ℚ(√5). Weight 2 = (ℤ[φ]-rank 4)/2. Status:
this is standard-shaped mathematics with literature behind it (Hilbert
modular forms for ℚ(√5) go back to Hirzebruch's school; theta series of
ℤ[φ]-lattices are classical), but the exact citation must be pinned
before the claim is promoted to "known." **Action item: literature
check.**

**Question Q1 (the honest replacement for "factorization").** Does the
rank-4 norm form of 𝕀 over ℤ[φ] admit a decomposition into rank-1 pieces
plus controlled coset corrections — i.e., a Hurwitz-style identity

    Θ_𝕀 = Σ_{cosets c} ∏_{k=1}^{4} θ_c,k(τ₁, τ₂; ℤ[φ]) ?

Notes for whoever attacks this: (i) the naive 4-factor splitting fails
for the maximal order 𝕀 itself, for the same reason the Hurwitz
quaternions are not ℤ⁴ — but the Hurwitz theta *is* expressible as a
finite sum of product terms over Lipschitz cosets, and the analogous
structure over ℤ[φ] is a well-posed, finitely-checkable question;
(ii) unlike ℤ, the ring ℤ[φ] has infinitely many units (±φⁿ), with
totally positive units φ²ⁿ, so determinant obstructions of the Theorem-0
type do **not** immediately kill rank-1 pieces here — the question is
genuinely open rather than provably hopeless.

## What replaces δ

Nothing needs to. The role v1 assigned to δ — "the internal counterpart /
drag of the projection" — is occupied in this formulation by σ, the
Galois conjugation, which is fixed by arithmetic. The 18.8 ppm quantity
survives only inside Conjecture N1 (mass ratio, see `AXIOMS_V2.md`),
where it must earn its own derivation. The δ⁸ exponent has no analogue
here; natural multiplicities are 4 and 2.

## Verification plan (honest Phase 1, replacing the fabricated one)

1. Enumerate icosians shell-by-shell by trace norm Q ≤ B (finite,
   unambiguous — no projections, no windows, no tolerances).
2. For each x record the pair (N(x), σN(x)) ∈ ℤ[φ]² and build the
   two-variable coefficient table of Θ_𝕀.
3. Check C1: diagonal coefficients must reproduce E₄ = 1 + 240q + 2160q²
   + 6720q³ + …
4. Check C2 numerically: compare against the q-expansion of the weight-2
   Hilbert Eisenstein series for ℚ(√5) (coefficients are divisor sums
   over totally positive elements of ℤ[φ] up to units).
5. Explore Q1: attempt coset decompositions over sublattices of the form
   ℤ[φ]-diagonal; record which corrections appear.

Every step is a finite computation with exact arithmetic in ℤ[φ]
(represent a + bφ as integer pairs; no floating point anywhere). Each
step produces committed code + committed output, per the gatekeeper
standard in `README.md`.

Only after steps 1–4 hold should `E8/Theta.lean` be restated: C1 is the
natural first Lean target (it is theorem-grade and finite-checkable
shell-by-shell), then C2.
