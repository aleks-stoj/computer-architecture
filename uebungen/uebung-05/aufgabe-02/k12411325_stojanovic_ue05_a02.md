# Computer Architecture

---

## Übung 05

### Aufgabe 02 - Extrema und Zahlenverteilung

---

> Betrachte das IEEE-754 Format für Single Precision Zahlen. Gib deine Ergebnisse sowohl im IEEE-754-Format (binär) als auch im Dezimalsystem an.
> a) Ermittle die kleinste Zahl $ε$, sodass $4 + ε > 4$.
> b) Ermittle die kleinste darstellbare positive Zahl `minreal`.
> c) Ermittle die größte darstellbare positive Zahl `maxreal`.

a.)

$4$ im IEEE-754 Format:

**Sign Bit:**

$4$ ist positiv, weswegen das Sign Bit $0$ ist

**Exponent:**

$4_{10} = 100,0_2$

*Wie oft shiften um `1,...` zu erhalten?*

$100,0_2 = 1,000 \cdot 2^2$

$E = (2+127)_{10} = 129_{10} = 10000001_2$

**Mantisse:**

$M = (1,)000 = 00000000000000000000000$

**$4_{10}$ in IEEE-754**

| Sign | Exponent   | Mantisse                                 |
| ---- | ---------- | ---------------------------------------- |
| $0$  | $10000001$ | $0000 \ 0000 \ 0000 \ 0000 \ 0000 \ 000$ |

**Kleinstes $\epsilon$:**

Wir brauchen eine kleinste Erhöhung in der Mantisse. Wir fügen also `1` an der letzten Stelle der Mantisse dazu. D.h. wir müssen $1,000 \cdot 2^2$ um $23$ Stellen nach rechts verschieben, sodass wird dann $1,000 \cdot 2^{2-23} = 1,000 \cdot 2^{-21}$ erhalten.

$\epsilon = 2^{-21} = 4,768371582 \cdot 10^{-7}$

**$\epsilon$ in IEEE-754**

| Sign | Exponent   | Mantisse                                 |
| ---- | ---------- | ---------------------------------------- |
| $0$  | $10000001$ | $0000 \ 0000 \ 0000 \ 0000 \ 0000 \ 001$ |

b.)

Bei der kleinst möglichen positiven Zahl ist nur die letzte Stelle der ist nur das letzte Bit gesetzt.

| Sign | Exponent   | Mantisse                                 |
| ---- | ---------- | ---------------------------------------- |
| $0$  | $00000000$ | $0000 \ 0000 \ 0000 \ 0000 \ 0000 \ 001$ |

Dezimalumrechnung (Mantisse $\times$ Exponent mit Bias): $2^{-23} \cdot 2^{-126} = 2^{-149} = 1,401298464 \cdot 10^{-45}$

c.)

Bei der größt möglichen positiven Zahl muss die Mantisse voller $1$ sein und es muss der größte Exponent verwendet werden

| Sign | Exponent   | Mantisse                                 |
| ---- | ---------- | ---------------------------------------- |
| $0$  | $11111110$ | $1111 \ 1111 \ 1111 \ 1111 \ 1111 \ 111$ |

Dezimalumrechnung : $(2-2^{-23}) \cdot 2^{127} = 3,402823466 \cdot 10^{38}$

---
