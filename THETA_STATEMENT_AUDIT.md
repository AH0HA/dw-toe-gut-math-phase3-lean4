# Audit of the central theorem statement

## Problem statement

The current `E8/Theta.lean` defines:

```lean
noncomputable def projectedTheta (τ : ℂ) : ℂ :=
  ∑ x ∈ e8Roots, Complex.exp (2 * Real.pi * Complex.I * τ * (projectedNormSq x : ℂ))

theorem e8_theta_factorizes_over_h3
    (τ : ℂ) (hτ : 0 < τ.im) (h3_card : h3Group.card = 120) :
    projectedTheta τ = ∏ k : Fin 8, theta1D τ (deltaVec k)
```

with `theta1D τ δ_k = ∑' n : ℤ, exp(2πi τ · δ_k · n²)` and `deltaVec` constant
equal to the global `delta`.

## The math doesn't work as stated

Set `α = (1 + δ)²` so `projectedNormSq x = α · ‖P x‖²`. Then the LHS is

```
LHS(τ) = Σ_{x ∈ 240 roots} exp(2πi τ · α · ‖Px‖²)
```

The RHS, with all δ_k equal to δ, simplifies:

```
RHS(τ) = (∑_{n ∈ ℤ} exp(2πi τ · δ · n²))⁸ = θ(τ δ)⁸
```

where `θ` is the classical Jacobi theta function.

**Behaviour at the cusp** (`Im τ → ∞`, `q := exp(2πi τ) → 0`):

* LHS: every term `exp(2πi τ · α · ‖Px‖²)` has positive `‖Px‖² > 0` (no zero
  vector among the roots), so each term `→ 0` and LHS `→ 0`.
* RHS: each θ factor has the `n = 0` term contributing `1`, all other terms
  `→ 0`, so each factor `→ 1` and RHS `→ 1⁸ = 1`.

`0 ≠ 1`. **The current theorem statement is false.**

## What it probably should be

The standard E₈ theta function in number theory is the sum over the **entire
E₈ lattice** `Λ_{E₈}` (infinite, includes `0` and infinitely many vectors of
each shell):

```
Θ_{Λ_{E₈}}(τ) = ∑_{v ∈ Λ_{E₈}} q^{(v,v)/2}
            = 1 + 240 q + 2160 q² + 6720 q³ + ...   (as q-series; equals E₄(τ))
```

The `1` comes from `v = 0`; the `240q` from the 240 roots; later coefficients
from longer lattice vectors.

For the projected, δ-dragged version, the conjecture probably is:

```
Σ_{v ∈ Λ_{E₈}} exp(2πi τ · α · ‖Pv‖²) = ∏_{k=1}^8 θ₁ᴅ(τ; δ_k)
```

with the `v = 0` term contributing `1` to the LHS, matching the cusp value
of the RHS. This is consistent with Phase 1 having "numerically verified"
the factorisation: a truncated lattice sum (cut off at some shell radius)
matches the truncated product to floating-point precision.

## Three concrete restatements

### Option 1 — Sum over the full E₈ lattice (analytic)

Replace `e8Roots : Finset (Fin 8 → ℝ)` with an additive subgroup
`E8Lattice : AddSubgroup (Fin 8 → ℝ)` (infinite). The projected theta
becomes a `tsum`:

```lean
noncomputable def projectedTheta (τ : ℂ) : ℂ :=
  ∑' (v : E8Lattice), Complex.exp (2 * π * I * τ * (projectedNormSq v.val : ℂ))
```

Convergence requires `0 < τ.im` (already in our hypothesis). Pros:
mathematically correct; matches the standard theta-function literature.
Cons: a substantial refactor — the existing combinatorial machinery
(integerRoots / halfIntegerRoots / e8_card) becomes secondary, and the
new lattice definition needs a generating-set + decidability story.
**Effort: 1–2 sessions.**

### Option 2 — Formal power series in `q = exp(2πi τ)` (algebraic)

Both sides are formal `q`-series; equality is coefficient-wise. Mathlib
has `PowerSeries` and `LaurentSeries`. The shells of the E₈ lattice
contribute integer coefficients; the projected version twists the
exponents by `α = (1+δ)²`. Pros: completely sidesteps convergence; no
analytic hypotheses needed. Cons: requires `α · ‖Pv‖²` to take values in
some discrete set (e.g., `α · ℤ` or `α · ℤ[φ]`); fractional exponents may
need a Puiseux-series formulation. **Effort: 2–3 sessions to set up.**

### Option 3 — Keep the finite sum but correct the equality

The current LHS `Σ_{x ∈ 240 roots}` is the *first non-trivial shell* of
the lattice theta. The factorisation identity for a *single shell*
isn't standard; the RHS would have to be replaced with the
corresponding shell of the product. Specifically:

```
Σ_{x ∈ 240 roots} q^{α ‖Px‖²}
  =  the [α ‖Px‖²]-th coefficient block of  ∏_k θ₁ᴅ(τ; δ_k)  -  1
```

That's a coefficient-extraction identity, not a function identity. Could
be stated and proved combinatorially (count multi-indices `(n_1, …, n_8)`
with `Σ δ_k n_k² = α‖Px‖²`). Pros: keeps the existing combinatorial
infrastructure; statement is provably true if Phase 1 numerics support
it. Cons: changes the theorem's character from "function identity" to
"shell-by-shell coefficient identity"; requires checking that the
underlying claim is what Phase 1 actually verified. **Effort: depends on
what coefficients Phase 1 checked.**

## Recommendation

**Option 1** is the most likely-correct restatement and matches standard
number-theoretic conventions. The refactoring cost is real but the
existing `e8Roots` material survives as a lemma about the first shell
(`integerRoots ∪ halfIntegerRoots ⊂ Λ_{E₈}` and contributes `240q` to
the q-expansion of `Θ_{E₈}`). The convergence side is supported by
mathlib's `tsum` infrastructure.

If you can find the Phase 1 Python and confirm what was actually
computed (truncated lattice theta? shell-by-shell coefficients?), the
choice between Options 1, 2, 3 becomes deterministic. Without that, my
recommendation is to start by **rewriting `projectedTheta` to include
the zero vector** — a one-line change that fixes the cusp-value
mismatch — and see whether downstream work makes sense from there:

```lean
noncomputable def e8RootsAndZero : Finset (Fin 8 → ℝ) :=
  insert (fun _ => 0) e8Roots

noncomputable def projectedTheta (τ : ℂ) : ℂ :=
  ∑ x ∈ e8RootsAndZero, Complex.exp (... * projectedNormSq x ...)
```

That makes the cusp value `1` (from `x = 0`) match RHS `→ 1`, and gives
us a sanity check that goes beyond the original 240-term statement.
It's still a *finite* sum (not the full lattice), so the equality is
still mathematically suspect — but at least the cusp value matches and
the statement isn't trivially false.

The full Option-1 refactor should follow if/when there's appetite for
it.
