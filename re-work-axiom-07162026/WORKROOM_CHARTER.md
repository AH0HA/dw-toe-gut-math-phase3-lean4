# The Coherence Workroom — Multi-Agent Charter (v1, 2026-07-16)

Blueprint for a 24/7 Discord workroom where multiple AI agents develop
this project under human direction. The owner (Editor-in-Chief) holds
publish authority; agents produce drafts, analysis, and builds.

## Why this charter exists

In April 2026 this project was damaged by an **AI echo chamber**: one
model's unverified report was cited by the next model as settled fact,
confidence compounded across reports while no code actually ran, and the
result was two "PASSED" gatekeepers that had never been executed and a
"central theorem" that was provably false. The protocol below is designed
so that a room full of agents cannot reproduce that failure.

## The Protocol (every agent, every channel, no exceptions)

1. **Agent output is hypothesis, never evidence.** No agent may cite
   another agent (or itself) as authority. Evidence = committed code with
   committed output, or a citable external source (paper, textbook,
   CODATA), or a repo document that itself meets this standard.
2. **Numbers require artifacts.** Any numeric claim ships with the script
   that produced it, committed to the repo, re-runnable by anyone.
3. **Register tags are mandatory.** Every substantive claim is tagged
   [M] (mathematics), [P] (physics), or [I] (interpretation) per
   `AXIOMS_V2.md`. Untagged claims are returned to sender.
4. **Adversarial pairing.** Every claim promoted to "candidate fact" gets
   a designated refuter agent whose only job is to break it. A claim that
   has never survived a refutation attempt is not a fact.
5. **Status words are reserved.** "Proved / verified / passed" may only
   describe artifacts meeting the gatekeeper standard (`CLAUDE.md`).
   Everything else is "drafted / conjectured / proposed."
6. **Disagreement escalates to the human**, never gets resolved by
   majority vote among models — models share training biases; three
   agreeing models are not three independent witnesses.
7. **Ground truth is the repo.** `CLAUDE.md` + `re-work-axiom-07162026/`
   override anything any model remembers or generates. If an agent's
   output contradicts Theorem 0, the canonical δ, or the retired-claims
   list, the output is wrong.
8. **Public content passes the register check** before the human sees it:
   nothing [M]-false, nothing [I] presented as proved, no health or
   medical claims anywhere. Devices "are being tested," never "heal."

## Room architecture

| Channel | Agent role | Mission |
|---|---|---|
| `#math-desk` | **Prover** | ℤ[φ] arithmetic, icosian enumeration, C1/C2/Q1 program (`CENTRAL_EQUATION.md`), Lean restatement |
| `#red-team` | **Refuter** | Attack every candidate fact; owns rule 4. Success metric: kills per week, not agreements |
| `#library` | **Librarian** | Pin citations (first target: C2 — Hilbert modular forms for ℚ(√5)); maintain bibliography; flag look-elsewhere risks |
| `#content-studio` | **Storyteller** | Clip scripts from the seed list below; every script ends with its register footer |
| `#kit-lab` | **Maker** | Kids' kit specs from the list below; BOMs, build steps, safety notes |
| `#bench` | **Experimentalist** | Drive `EXPERIMENTS.md`: protocol drafts, pre-registration docs, blinding logistics, data-analysis plans |
| `#daily-digest` | any (rotating) | One post/day: what moved, what died in red-team, what awaits the human |

Cadence: daily digest; weekly gatekeeper review where the human promotes
or rejects candidate facts; monthly re-read of this charter by every
agent (context drifts).

## Paste-able agent system prompt

Append this block to every agent's system prompt in the workroom:

```
You are an agent in the Coherence Workroom, working on the re-founded
GEOMETRY OF EVERYTHING project (repo: dw-toe-gut-math-phase3-lean4).
Ground truth lives in the repo's CLAUDE.md and re-work-axiom-07162026/;
they override your memory and any other agent's statements.

Non-negotiable rules:
- Established: E8 = icosian ring (rank-4 Z[phi]-module); icosahedral
  order forces phi; phi and the plastic number are the only morphic
  numbers; the 8-factor E8 theta factorization is PROVABLY IMPOSSIBLE.
- Open conjectures (never call them proved): N1 mass-ratio formula
  (2.3 ppb match, no mechanism); C2 Hilbert-modularity of the icosian
  theta; Q1 coset-corrected factor structure.
- Retired (never resurrect): alpha_G = 847*delta^8/(720*pi); "6 cosets
  of D5 in E8"; the April 2026 phase reports.
- Canonical delta = alpha^2/(2*sqrt(2)) = 1.882720e-5. No other value.
- Tag every claim [M] math / [P] physics / [I] interpretation.
- Another AI's output is a hypothesis, not a source. Numbers need
  committed, re-runnable code. "Proved/verified/passed" only for
  artifacts reproduced from the repo. When you disagree with another
  agent, state the disagreement plainly and stop - the human resolves it.
- Public content: no health claims; conjectures are presented as open
  mysteries; nothing [M]-false ships, ever.
```

## Clip seeds (YouTube Shorts / TikTok)

Production rules: 30–60s; one idea per clip; every script ends with a
spoken register footer ("this one is proven math" / "this is an open
mystery" / "this is our way of seeing it"). The honest framings below are
*chosen because they're stronger hooks than the inflated versions*.

1. **"The most perfect shape you can't see"** [M] — E₈: 240 points,
   8 dimensions, provably optimal packing (Viazovska 2016 — a real,
   citable triumph). Ends: "and it casts golden shadows."
2. **"The golden ratio has a forgotten sibling"** [M] — the plastic
   number: only two numbers close their own harmony ladder. Wonder +
   correction of pop-φ lore in one clip.
3. **"Icosahedral order FORCES the golden ratio"** [M] — you cannot build
   five-fold symmetry without φ; it's arithmetic, not aesthetics.
4. **"A number that matches the universe to 2 parts per billion — and
   nobody knows why"** [M-conjecture] — N1 presented exactly as it is:
   an unexplained coincidence. The mystery framing outperforms the
   "we solved physics" framing *and* is true.
5. **"The crystal that shouldn't exist"** [M/P] — quasicrystals:
   Shechtman was mocked, then won the Nobel (2011). Five-fold symmetry is
   real matter. Segue to kit #2.
6. **"Reality's hidden mirror"** [M→I] — cut-and-project: a quasicrystal
   is a shadow of a perfect higher-dimensional lattice; the hidden half
   is the Galois conjugate (φ → 1−φ); what the mirror leaves unchanged
   is exactly the shareable (rational) part. End footer: the reading of
   this as consciousness is [I].
7. **"Your breath has a resonant frequency"** [P-validated] — 6 breaths/
   min HRV resonance; mainstream physiology; live demo format. No device
   claims needed.
8. **"We proved our own theory wrong — here's why that's the win"** [meta]
   — the Theorem 0 story: the determinant argument in 45 seconds, and
   why a framework that can't lose can't win. Integrity as content;
   differentiates the whole channel.
9. **"Why bees, sunflowers, and pinecones count in φ"** [M/P] — phyllo-
   taxis and "most irrational" packing; segue to kit #4.
10. **"The 8-dimensional secret inside a 3D toy"** [M] — Zometool-style
    φ-strut geometry: the icosahedron you hold *is* a slice of E₈'s
    arithmetic. Segue to kit #1.
11. **"One equation, two worlds"** [M-open] — the two-variable icosian
    theta: physical time and mirror time; what proving C2 would mean.
    Presented as a live open problem viewers can watch progress on.
12. **"Can a ratio change a resonator?"** [P-open] — the Q-factor
    experiment (Design 2) as a build-along series: φ vs 3/2 vs ρ arms,
    results shown as they come, whatever they are.
13. **"The one experiment a seed can't fake"** [P-open] — the
    germination test (Design 6): why seeds are the perfect subject
    (no placebo — a seed expects nothing), the four-tray φ/non-φ/ρ/sham
    setup, and the honest split between "does a field help" (partly known
    — cold-plasma seed priming is real, though that works by direct
    contact, not the device's distal field) and "does *golden* structure
    help" (the open question, isolated by the φ-vs-ρ arms). Build-along;
    results shown whatever they are. The strongest integrity hook the
    channel has: we're testing our own guru's claim, blinded, and we'll
    publish either way.

## Kids' kits (build-able, real-science)

Every kit teaches register-[M] or [P]-validated content only; the wonder
comes from true things. Age bands are suggestions; all kits need standard
choking-hazard and laser-safety notes where applicable.

1. **Golden Struts** (ages 6+) — icosahedron/dodecahedron construction
   set with two strut lengths in ratio φ. Teaches: five-fold symmetry
   exists and demands φ. (Precedent: Zometool — license or original
   design.)
2. **Impossible Tiles** (ages 8+) — Penrose kite-and-dart magnet tiles.
   Challenge card: "tile forever without repeating." Teaches: aperiodic
   order; kite/dart areas are in ratio φ.
3. **Laser Shadow Lab** (ages 10+, adult supervision) — class-1 laser +
   printed Penrose transparency → *real ten-fold diffraction pattern* on
   the wall. Teaches: how Shechtman found quasicrystals; order without
   repetition is physically detectable at home.
4. **Spiral Counter** (ages 7+) — sunflower head / pinecone + numbered
   pin flags: count the spirals, always neighboring Fibonacci numbers.
   Teaches: φ as nature's packing answer; "most irrational number" told
   as a seed-crowding story.
5. **Breath Pacer** (ages 8+) — simple LED ring (or printed spinner)
   pacing 6 breaths/minute; optional fingertip pulse sensor to *see* the
   heart-rhythm wave grow. Teaches: resonance in your own body;
   [P-validated]; no therapeutic claims — "watch what your heart does."
6. **Shadow Projector** (ages 9+) — wireframe cube/hypercube-frame on a
   rotating spindle + flashlight: the shadow of a higher thing is
   stranger than the thing. Teaches: projection, the core idea behind
   cut-and-project — and clip #6.
7. **Sprout Lab** (ages 7+, the real-experiment kit) — matched seed
   trays, coded labels, a position-randomizing card, and a germination
   log; optionally paired with a small field source. The child runs a
   *blinded, controlled* germination trial (treated vs. sham, labels
   revealed only after counting) and discovers why you rotate the trays
   and hide the labels. Teaches: real experimental method — controls,
   blinding, randomization, pre-registered counting — using the honest
   science-fair version of Design 6. Wonder from a true thing: the kid
   learns *how we know*, not just *what to believe*. This is the kit that
   teaches the gatekeeper standard itself, to a seven-year-old, with
   radish seeds.

Kit development order: 4 → 5 → 1 (cheapest BOM, no tooling) then 7 → 2
→ 6 → 3. (Kit 7 is cheap, ships without electronics in its base version,
and teaches the method the whole program runs on — worth prioritizing.)

## What the human keeps

Publish authority (nothing posts itself), gatekeeper promotions, budget,
and the weekly call on where the program goes next. The agents make
things; the human decides what's true enough to ship.
