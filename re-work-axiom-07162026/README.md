# re-work-axiom-07162026

Re-foundation of the six axioms of *COHERENCE: THE GEOMETRY OF
EVERYTHING* (v1618G03), following the July 2026 audit that found:
the central theta-factorization conjecture provably false as stated, the
Phase 1/2 "gatekeeper passed" reports non-reproducible, the δ⁸ → G bridge
numerically unsound, and the Axiom 2 uniqueness claim refuted — alongside
genuinely solid material (the 2.3 ppb mass-ratio match, the icosahedral
mathematics, the register-separable interpretive content).

## Files

| File | Contents |
|---|---|
| `AXIOMS_V2.md` | The six axioms restated in three registers ([M] math / [P] physics / [I] interpretation) |
| `CENTRAL_EQUATION.md` | Theorem 0 (old conjecture impossible) + the icosian replacement (Θ_𝕀 over ℤ[φ], Claims C1/C2, Question Q1) + verification plan |
| `NUMERICAL_AUDIT.md` | The reproducible numbers behind every verdict |
| `audit.py` | Reproduces every number in the audit (pure Python 3, no deps) |
| `EXPERIMENTS.md` | Blinded experimental designs for the device/bench program |

## Does the rest of the book need rewriting?

Mostly no. The key structural fact: the book's later chapters never
*mathematically depended* on the axioms' quantitative machinery — they
were **interpreted through** it. Interpretation survives a change of
spine; only the specific numeric hooks break. Chapter-by-chapter:

| Chapters | Action | Reason |
|---|---|---|
| Ch. 1 (Axiom 1) | Light edit | Add falsifiers + Lorentz-bound citations (`AXIOMS_V2.md`) |
| Ch. 2 (Axiom 2) | Rewrite core claim | Uniqueness false as stated; replace with ℤ[φ] theorem + morphic-number caveat. Chapter gets *stronger* |
| Ch. 3 (Axiom 3) | Relabel + fix δ | Axiom → Conjecture N1; one canonical δ book-wide |
| Ch. 4 (Axioms 4–6) | Register-split | Per `AXIOMS_V2.md`; Axiom 6 loses its 2nd-law violation |
| Ch. 5 (δ⁸ → G) | Retire to appendix | Fails own accuracy claim; exponent 8 orphaned (`NUMERICAL_AUDIT.md` Table 2) |
| Ch. 6 (emergence) | Light edit | Keep the sequence as interpretation; delete "eighth power of δ" line; "projection" becomes icosian descent |
| Ch. 7–13 (consciousness, hierarchy) | Relabel only | Pure [I] register; carries over intact. Complexity index C = w·N·|G| stays as an explicit heuristic |
| Ch. 14 (planes) | Light edit | Keep the correspondence as an interpretive map; remove the "6 cosets" claim (not well-formed) |
| Ch. 15–28 (death, morality, ceiling, prophecy, cosmology, stargates) | Relabel only | [I]/[P]-speculative register; adjust claims-language from "is" to "the framework reads as" |
| Ch. 29 | **Replace** | With `CENTRAL_EQUATION.md` (Theorem 0 + C1/C2/Q1) |
| Ch. 30 | Upgrade | With the blinded designs in `EXPERIMENTS.md` |
| Ch. 31 (open items) | Update | Factorization: resolved false, replaced. δ derivation: still open. 847/(720π): retired |
| Ch. 32 | Keep | Fair prose gloss of real E₈ facts |
| Ch. 33 | Source or cut | The "1,512 living universes" count has no visible derivation |
| Ch. 34–37 | Relabel only | Practice + interpretation; note 0.1 Hz breathing is mainstream-validated (HRV biofeedback) |
| Ch. 38 (Part XIII) | Reframe | Number-line audits become exploratory analogies; Riemann-zero statistics belong to random matrix theory (GUE); §38.8 replaced by the icosian proof plan |
| Reader's Caution | Rewrite | It did its job: the framework's stated single point of failure failed, and this directory is the contingency it implicitly promised |

Bottom line: ~6 chapters need real work, ~4 need light edits, the rest
need only epistemic relabeling ("proved/verified" → "the framework reads
this as"). The book's honesty devices (Reader's Caution, Ch. 31's open-
items list) were its best feature and made this salvage possible.

## Gatekeeper standard

A phase or claim is "passed" only when the exact script is committed to
this repository, its output is committed next to it, and an independent
re-run reproduces it. Prose reports carry no status. This standard exists
because the April 2026 phase reports asserted outputs their own code
could not produce (`NUMERICAL_AUDIT.md`, final section).

## Relation to the Lean formalization

`E8/Theta.lean`'s current central statement is false (Theorem 0;
`../THETA_STATEMENT_AUDIT.md`) and should not be proven — it should be
restated per `CENTRAL_EQUATION.md`. Natural Lean milestones, in order:
exact ℤ[φ] arithmetic → icosian ring + norm → C1 shell-by-shell → C2.
The existing sorry-free combinatorics in `E8/Basic.lean` and
`E8/Projection.lean` remain valid and reusable.
