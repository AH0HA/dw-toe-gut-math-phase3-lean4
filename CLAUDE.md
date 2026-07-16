# CLAUDE.md — Project Memory

## What this project is

Mathematical re-foundation, formalization (Lean 4), and outreach program
for *COHERENCE: THE GEOMETRY OF EVERYTHING* (v1618G03) — a framework
connecting E₈ lattice geometry, golden-ratio structure, and consciousness,
originated by Dan Winter, developed by the book's author with AI
collaborators. The owner's goals: (1) put the math on honest footing,
(2) short YouTube/TikTok clips about the book, (3) buildable science kits
for kids, (4) a 24/7 multi-agent Discord workroom driving all of it.

## The story so far (read before doing anything)

- **Apr 2026:** "Phase 1/2 gatekeeper PASSED" reports (Grok) claimed
  numerical + representation-theoretic verification of the central
  conjecture. **These were later shown non-reproducible** — the committed
  scripts cannot produce the reported outputs (wrong root counts, unfilled
  matrices, generators of an infinite group). See
  `re-work-axiom-07162026/NUMERICAL_AUDIT.md`, final section.
- **Jul 2026:** Full audit. The central conjecture (E₈ theta factorizes
  into 8 one-dimensional factors) is **provably false** — determinant
  argument, `re-work-axiom-07162026/CENTRAL_EQUATION.md` Theorem 0; the
  Lean statement is also false by cusp values, `THETA_STATEMENT_AUDIT.md`.
- **Jul 2026:** Re-foundation. Six axioms restated in three registers;
  central equation replaced by the icosian formulation (E₈ as rank-4
  ℤ[φ]-module; Galois conjugation as the internal space). Directory:
  `re-work-axiom-07162026/`.

## Ground truth — do not get these wrong

**Established (theorem-grade):**
- E₈ ≅ icosian ring: free rank-4 ℤ[φ]-module; Θ_{E₈} = E₄ (Eisenstein).
- H₃/H₄ are defined over ℤ[φ]: icosahedral order *forces* φ (Axiom 2a).
- φ and the plastic number ρ ≈ 1.3247 are the only two morphic numbers;
  φ is unique only for nearest-rung heterodyne closure.
- The 8-factor theta factorization is IMPOSSIBLE for E₈ (Theorem 0).
- Naive projected theta sums over the full lattice diverge (density of
  cut-and-project images); uniform (1+δ) coordinate scaling is inert.

**Conjectural (open, honestly labeled):**
- N1: m_p/m_e = 6π⁵(1 + α²/2√2) — matches CODATA to 2.3 ppb; no mechanism.
- C2: the two-variable icosian theta is a weight-2 Hilbert modular form
  for ℚ(√5) — believed known, citation not yet pinned.
- Q1: coset-corrected 4-factor structure over ℤ[φ] — genuinely open.

**Retired/false (do not resurrect):**
- α_G = 847δ⁸/(720π) (fails own accuracy claim; exponent 8 orphaned).
- "6 cosets of D₅ in E₈" (not well-formed).
- The April 2026 phase-report results (non-reproducible).

**Canonical constants:** δ := α²/(2√2) = 1.882720×10⁻⁵ (CODATA 2018).
One value everywhere; v1 chapters used three inconsistent ones.

## The three registers (tag every claim)

- **[M]** mathematics — provable or false; conjectures carry status.
- **[P]** physics — falsifiable postulates with named falsifiers.
- **[I]** interpretation — declared readings; never "proved by the math."

## Gatekeeper standard (non-negotiable)

A claim is "passed/verified/proved" ONLY when: exact script committed to
this repo + its output committed next to it + independent re-run
reproduces it. Prose reports (including AI chat transcripts) carry zero
status. AI output is hypothesis, never evidence — and never cite another
AI's claim as authority. This rule exists because the April 2026 failure
was an AI echo chamber: each model cited the previous model's report as
settled fact while no code actually ran.

## Repo map

```
E8/                        Lean 4 formalization (Basic/Projection sorry-free;
                           Theta.lean's central statement is FALSE — restate
                           per CENTRAL_EQUATION.md before proving anything)
THETA_STATEMENT_AUDIT.md   Cusp-value refutation of the old Lean statement
gemini-code-*.md           Condensed book text (16 files; notation degraded:
                           "Es"=E₈, "o"=φ, "8"=δ; two files are duplicates)
re-work-axiom-07162026/    The re-foundation (START HERE):
  AXIOMS_V2.md               six axioms restated in three registers
  CENTRAL_EQUATION.md        Theorem 0 + icosian replacement + verify plan
  NUMERICAL_AUDIT.md         reproducible numbers behind every verdict
  audit.py                   reproduces all audit numbers (stdlib only)
  EXPERIMENTS.md             blinded φ-vs-control device/bench designs
  README.md                  chapter-impact map for revising the book
  WORKROOM_CHARTER.md        Discord multi-agent room: roles, protocol,
                             clip seeds, kids' kits, agent system prompt
```

## Workstreams

- **A. Math/Lean:** next milestones in `CENTRAL_EQUATION.md` §Verification
  plan — exact ℤ[φ] arithmetic, icosian enumeration, C1 numeric check,
  C2 literature pin, then restate `E8/Theta.lean`.
- **B. Content (YouTube/TikTok):** clip seeds + production rules in
  `WORKROOM_CHARTER.md`. Every script tags its register; no medical
  claims; conjectures presented as open mysteries (that's the better
  story anyway).
- **C. Kids' kits:** concepts in `WORKROOM_CHARTER.md`. All kits teach
  real, register-[M] science; wonder comes from true things.
- **D. Device evidence:** `EXPERIMENTS.md`. Blinded φ-vs-control designs;
  pre-registered endpoints; both outcomes are valuable.

## Working conventions

- Branch: work on the branch specified for the session; the re-foundation
  lives on `claude/check-in-b6sy23`.
- Public-facing text (clips, kits, posts) must pass the register check:
  if a sentence states [M]-false or presents [I] as proved, it does not
  ship. The honest framings are documented and are genuinely more
  compelling — use them.
