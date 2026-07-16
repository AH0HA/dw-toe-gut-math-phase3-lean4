#!/usr/bin/env python3
"""Reproduces every number in NUMERICAL_AUDIT.md. Pure stdlib, CODATA 2018."""
import math

alpha = 7.2973525693e-3      # fine-structure constant
mpme  = 1836.15267343        # proton-electron mass ratio
G     = 6.67430e-11          # gravitational constant (rel. unc. ~2.2e-5)
m_p   = 1.67262192369e-27    # proton mass, kg
hbar  = 1.054571817e-34
c     = 2.99792458e8

print("=== Table 1: Conjecture N1 (mass ratio) ===")
base = 6 * math.pi**5
delta_alpha = alpha**2 / (2 * math.sqrt(2))
delta_star = mpme / base - 1
pred = base * (1 + delta_alpha)
print(f"6*pi^5                    = {base:.7f}")
print(f"gap vs CODATA             = {(mpme/base - 1)*1e6:.3f} ppm")
print(f"delta = alpha^2/(2 sqrt2) = {delta_alpha:.6e}")
print(f"delta for exact match     = {delta_star:.6e}")
print(f"6pi^5(1+delta)            = {pred:.7f}")
print(f"residual                  = {(pred/mpme - 1)*1e9:.2f} ppb")

print("\n=== Table 2: the delta^8 -> G bridge ===")
aG_actual = G * m_p**2 / (hbar * c)
print(f"alpha_G actual (G m_p^2 / hbar c) = {aG_actual:.5e}")
for label, d in [("alpha^2/2sqrt2 ", delta_alpha),
                 ("N1-exact       ", delta_star),
                 ("Ch.5 value     ", 1.88254e-5),
                 ("Ch.3 value     ", 1.8828e-5)]:
    aG = 847 * d**8 / (720 * math.pi)
    print(f"delta = {d:.5e} ({label}) -> alpha_G = {aG:.5e}"
          f"  error {(aG/aG_actual - 1)*1e6:+8.0f} ppm")

print("\n=== Table 3: plastic number closes both heterodyne conditions ===")
rho = 1.0
for _ in range(200):
    rho = (rho + 1) ** (1 / 3)          # fixed-point iteration for x^3 = x+1
print(f"rho                = {rho:.12f}")
print(f"1+rho - rho^3      = {(1 + rho) - rho**3:.2e}   (sum closure, k=3)")
print(f"rho^5 - (rho^4+1)  = {rho**5 - (rho**4 + 1):.2e}   (difference closure, r-1 = r^-4)")

print("\n=== Theorem 0 sanity: even unimodular determinant obstruction ===")
print("det(E8) = 1; any orthogonal split into 8 rank-1 pieces needs")
print("prod(|v_i|^2) = 1 with each |v_i|^2 an even integer >= 2: impossible.")
