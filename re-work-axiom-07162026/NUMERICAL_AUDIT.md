# Numerical Audit of the Load-Bearing Formulas (2026-07-16)

All numbers below are reproducible by running `audit.py` in this
directory (pure Python 3, no dependencies). CODATA 2018 constants
throughout.

## Table 1 — Conjecture N1 (mass ratio): CONFIRMED as a numerical match

| Quantity | Value |
|---|---|
| 6π⁵ | 1836.1181087 |
| gap vs CODATA m_p/m_e | 18.825 ppm |
| δ = α²/(2√2) | 1.882720 × 10⁻⁵ |
| δ needed for exact match | 1.882489 × 10⁻⁵ |
| 6π⁵(1 + α²/2√2) | 1836.1526777 |
| CODATA m_p/m_e | 1836.15267343 |
| **residual** | **2.3 ppb** |

Verdict: the match is real and striking. It remains an unexplained
numerical observation (no mechanism; look-elsewhere effect applies) —
see `AXIOMS_V2.md`, Conjecture N1.

## Table 2 — the δ⁸ → G bridge: FAILS its own accuracy claim

Formula (v1618G03 Ch. 5): α_G = 847 δ⁸ / (720π).
Target: α_G = G·m_p²/(ħc) = 5.90615 × 10⁻³⁹ (CODATA; G rel. uncertainty
≈ 22 ppm).

| δ used | source | predicted α_G | error |
|---|---|---|---|
| 1.88272 × 10⁻⁵ | α²/2√2 (the "derived" value) | 5.91135 × 10⁻³⁹ | **+880 ppm** |
| 1.88249 × 10⁻⁵ | value making N1 exact | 5.90555 × 10⁻³⁹ | −102 ppm |
| 1.88254 × 10⁻⁵ | Ch. 5's own value | 5.90683 × 10⁻³⁹ | **+116 ppm** |
| 1.8828 × 10⁻⁵ | Ch. 3's value | 5.91336 × 10⁻³⁹ | +1221 ppm |

Findings:

1. With Ch. 5's own δ, agreement is +116 ppm — not the claimed ~50 ppm,
   and 5× outside CODATA's stated G uncertainty (22 ppm). The v1 claim
   "within G's measurement uncertainty" is incorrect. (It is inside the
   historical spread *between* G experiments, which is a much weaker
   statement.)
2. The eighth power amplifies the 4th decimal of δ into ~1,000 ppm swings
   of the prediction: the book's own δ values span a 2,100 ppm range of
   α_G. The formula's apparent success depends on which underived input
   is chosen, i.e., it is a fit.
3. The coefficient 847/(720π) is itself underived (v1 Ch. 31 lists it as
   a critical open item, correctly).

Verdict: retired to open curiosities. See `AXIOMS_V2.md`, Axiom 4.

## Table 3 — Axiom 2 uniqueness: REFUTED by the plastic number

The plastic number ρ = 1.324717957… (real root of x³ = x + 1) satisfies
both heterodyne closure conditions on its own geometric ladder, exactly:

| Condition | Identity | Check (double precision) |
|---|---|---|
| sum closure | 1 + ρ = ρ³ | 0.0 |
| difference closure | ρ − 1 = ρ⁻⁴ (⇔ ρ⁵ = ρ⁴ + 1) | 0.0 |

φ and ρ are the only two such "morphic numbers"
(Aarts–Fokkink–Kruijtzer, *Morphic numbers*, 2001). φ is unique only as
the *nearest-rung* (quadratic) closure. See `AXIOMS_V2.md`, Axiom 2, for
the corrected statement and the stronger ℤ[φ] grounding.

## Prior audit results incorporated by reference

- The eight-factor theta conjecture is provably false
  (`CENTRAL_EQUATION.md`, Theorem 0; `../THETA_STATEMENT_AUDIT.md`).
- The Phase 1/Phase 2 "gatekeeper PASSED" reports of April 2026 are not
  reproducible: the Phase 1 script generates 368 vectors (not 240, due to
  an always-true parity test), never populates its projection matrix, and
  contains no factorization test; the Phase 2 script yields 27 coset keys
  (not 6) and 83 "D₅ roots" (not 40), and its three "H₃ generators"
  generate an infinite group (its 3-fold axis is a 2-fold axis of the
  icosahedron in the chosen orientation), so the reported order-120
  closure and orbit counts cannot be outputs of that code.

## Gatekeeper standard going forward

A phase is "passed" only when: (1) the exact script is committed to this
repository, (2) its output is committed next to it, and (3) an
independent re-run reproduces that output. Claims in prose documents
carry no status.
