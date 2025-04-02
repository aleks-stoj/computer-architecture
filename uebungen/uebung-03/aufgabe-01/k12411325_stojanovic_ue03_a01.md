- Aleksandar Stojanović, K12411325
- Annika Schmidtthaler, K12411307
- Benedikt Zöchmann, K12410383

### Carry Ripple Adder

Besteht aus Full Addern.

$C(FA) = 5$

$Depth(FA) = 3$

8-Bit Carry Ripple Adder:

$C(CRA_8) = 8 \cdot C(FA) = 8 \cdot 5 = 40$

$Depth(CRA_8)= 3 + 2(8-1) = 3 + 14 = 17$

### Conditional Sum Adder

Ein 8-Bit CSA besteht aus 3 4-Bit CRA

$C(CRA_4) = 4 \cdot C(FA) = 5 \cdot 4 = 20$

**3 4-Bit CRA:**

$3 \cdot C(CRA_4) = 60$

**Multiplexer:**

![Datei:Mux-Aufbau DIN40900.svg](https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Mux-Aufbau_DIN40900.svg/213px-Mux-Aufbau_DIN40900.svg.png)

Quelle: [Mux-Aufbau DIN40900.svg – Wikimedia](https://de.wikipedia.org/wiki/Datei:Mux-Aufbau_DIN40900.svg)

Besteht aus $2$ AND-Gates, $1$ OR-Gate und $1$ NOT-Gate = $5$ Gates

$Tiefe(MUX) = 3$

**Tiefe:**

$Tiefe(CRA_4) + Tiefe(MUX) = (3 + 2(4 - 1)) + 3 = 12$

$Kosten(CSA_8) = 65$

$Tiefe(CRA_8) = 12$

---
