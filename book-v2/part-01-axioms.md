# PART I: The Axioms — Audit and Validation (v2)

## Chapter 1: The Superfluid Vacuum

> "I tried to vacuum the superfluid aether, but it just gave me a quantum
> Hamilton-Jacobi headache."

**Axiom 1 [P].** The vacuum admits an effective description as a
compressible superfluid: its long-wavelength excitations reproduce the
observed relativistic fields, and gravity emerges from gradients of
condensate density and flow.

The mathematics behind the postulate is uncontroversial. Write the
condensate's order parameter as Ψ = √ρ · e^{iθ} (the Madelung
decomposition) and the field equations split into a continuity equation
and a quantum Hamilton–Jacobi equation — a fluid with an extra "quantum
potential" term. This is textbook. What is *postulated* is that our
vacuum is such a fluid.

This axiom keeps respectable company. Unruh showed in 1981 that sound in
a flowing fluid obeys the same equations as light near a black hole —
and his "sonic horizons" have since been built in laboratories, where
analog Hawking radiation has been reported in Bose–Einstein condensates.
Volovik's *The Universe in a Helium Droplet* develops the full program.
It remains a minority road in physics, but it is a road, not a ditch.

**What would kill it [P].** Two named falsifiers. First, Lorentz
invariance: a fluid picks out a rest frame, and experiments (gamma-ray
burst timing across billions of light-years) have found *no* frame to
exquisite precision — any surviving version of Axiom 1 must hide its
frame below those bounds. Second, spin-2: gravity's quanta must come out
tensor, not scalar. This remains the axiom's hardest open item, as it
was in v1 (Chapter 31).

**What This Lets Us Build.** Analog-gravity tabletops are real,
published, and shockingly affordable: a water-channel "white hole"
(a kitchen-sink hydraulic jump is genuinely a horizon for surface waves)
scales down to a science-fair demonstration. Kit candidate: *Horizon in
a Sink* — see the kids' kit line.

---

## Chapter 2: The Golden Ratio and Spectral Closure

> "The Golden Ratio: because regular ratios just don't know how to close
> a deal. (It turns out one other number can — meet the family.)"

**Axiom 2a [M — theorem].** Golden-ratio scaling is the arithmetic
signature of icosahedral order. The symmetry groups of the icosahedron
(H₃) and its four-dimensional big sibling (H₄) cannot be written in
whole numbers: their natural ring is ℤ[φ], the integers extended by the
golden ratio. If a structure anywhere in nature has five-fold icosahedral
symmetry, φ is *already inside it* — not as decoration, as arithmetic.
This is a theorem, and it is a stronger foundation than v1's acoustic
argument ever was.

**Axiom 2b [M — corrected].** The heterodyne closure story survives with
one honest correction that makes it more interesting. Ask: which ratio r
lets two adjacent tones f and rf on a geometric ladder produce sum and
difference tones that both land back on the ladder? v1 said "only φ."
The truth: the requirement makes r a **morphic number**, and there are
exactly two of them (Aarts–Fokkink–Kruijtzer, 2001):

- **φ = 1.618…** — closure at *adjacent* rungs: 1+φ = φ², φ−1 = φ⁻¹;
- **ρ = 1.3247…**, the *plastic number* — closure at distant rungs:
  1+ρ = ρ³, ρ−1 = ρ⁻⁴ (both exact).

φ is the unique **nearest-rung** closure — the tightest, most local way
for a wave ladder to be self-referential. Its famous status as the "most
irrational" number (a continued fraction of pure 1s) is the standard
ingredient in stability arguments: φ-related frequencies are the *last*
to lock into destructive resonance. And ρ, far from being an
embarrassment, hands us a perfect experimental control (see Chapter 30):
if coherence effects are about closure in general, ρ should share them;
if they are about *nearest-rung* closure, φ stands alone. Either result
teaches us something. v1 could not lose this bet; v2 can — which is why
v2's version is worth betting on.

**What This Lets Us Build.** The three-arm resonator experiment
(φ vs. 3/2 vs. ρ — Chapter 30, Design 2) and the *Golden Struts* and
*Impossible Tiles* kits. The plastic number arm is the single cheapest
piece of new science this book proposes.

---

## Chapter 3: The Proton–Electron Mass Ratio

> "2.3 parts per billion: close enough to keep you up at night, unexplained
> enough to keep you honest."

**Conjecture N1 [M — open].** (Demoted from axiom, and prouder for it.)

    m_p/m_e = 6π⁵ (1 + α²/2√2)

Compute it: 6π⁵ = 1836.1181087, which misses the measured ratio by
18.8 parts per million. Apply the correction term built from the
fine-structure constant — δ := α²/(2√2) = 1.882720×10⁻⁵, the **one
canonical δ of this book** (v1 used three slightly different values in
different chapters; that ends here) — and you land on 1836.1526777
against the measured 1836.15267343. Residual: **2.3 parts per billion.**
No free parameters. Anyone can check it in five lines of Python; the
repository ships the script (`re-work-axiom-07162026/audit.py`).

Now the honesty. This is an *unexplained numerical observation*. The
proton's mass is overwhelmingly QCD binding energy, so no known mechanism
delivers a closed form in π and α — and simple-constant searches produce
ppb-level coincidences more often than intuition suggests (the
look-elsewhere effect: the number-theory casino pays out small jackpots
regularly). The conjecture earns evidential weight only if a mechanism
*predicts* it, or it survives future CODATA digits it did not help
choose. Until then it is filed exactly where a mystery belongs: in plain
sight, labeled.

**What This Lets Us Build.** Nothing physical — yet. What it builds is
readers: run `audit.py` yourself; the formula either lands on your
machine or the book is lying to you. That is the relationship this
edition wants with its audience.

---

## Chapter 4: Gravity, the Still Point, and Metabolism

> "Gravity: it's not just a law, it's a centripetal hug for your charge —
> pending peer review."

Three axioms lived in this chapter in v1, fused across registers. Here
they are, separated.

**Axiom 4 [P].** Gravitational attraction emerges as the
quantum-potential gradient of condensate density enhancements around
coherent standing-wave structures. In the weak-field limit this must
reproduce Newton and the post-Newtonian tests of general relativity —
those tests are its falsifiers. The v1 quantitative bridge from δ to G
is retired; Chapter 5 tells that story in full, because how it failed is
one of the most instructive things in this book.

**Axiom 5 [I], with one mathematical footnote [M].** The framework reads
the invariants — what remains unchanged under the mirror — as the locus
of awareness. This is a declared reading, not a result; v2 no longer
pretends otherwise. The footnote is new and real: in the icosian
formulation (Chapter 29), the mirror between the physical and the hidden
half of the projection is *Galois conjugation*, the map φ ↦ 1−φ. And the
quantities left fixed by that mirror are exactly the **rational
numbers** — the shareable ones. "The still point is what the mirror
cannot move" is now a sentence with precise mathematical content, which
the reader may take as resonance [I] or coincidence, as conscience
dictates.

**Axiom 6 [P — corrected].** Coherent systems maintain and grow internal
order by *exporting entropy* to their environment across a coupling
surface; "charge metabolism" is the framework's name for that local
exchange. v1's strong form — entropy converted back into order, full
stop — violated the second law and has been dropped; nothing downstream
ever needed it. The corrected form is Schrödinger's negentropy and
Prigogine's dissipative structures: standard, true, and measurable
system-by-system. Your body is not a perpetual-motion machine. It is
something more interesting: a vortex that eats gradients.

**What This Lets Us Build.** Axiom 6 in its corrected form is
instrumentable *today*: heart-rate-variability biofeedback is a
window on an organism actively managing its coherence budget. See the
*Breath Pacer* kit and Chapter 34.
