# Computer Architecture

---

## Übung 06

### Aufgabe 02c - Multicycle RISC-V Analyse

---

> Betrachte den Multicycle RISC-V Prozessor aus der Vorlesung.
> 
> c) Vergleiche die maximale Taktfrequenz des Multicycle Prozessors mit der maximalen Taktfrequenz des **Single-Cycle Prozessor** aus der Vorlesung in *Abb.4*. Dazu muss auch für diesen Prozessor der kritische Pfad ermittelt werden. Nimm an, dass für beide Prozessoren $ALU(a)$ verwendet wird. Welcher Prozessor hat die **höhere Taktfrequenz**? Welcher Prozessor ist **schneller**?

#### Single Cycle Prozessor

<img title="" src="file:///C:/Users/MSI/AppData/Roaming/marktext/images/2025-05-20-11-06-54-image.png" alt="" width="573">

| Komponente           | Parameter       | Delay [ps] |
| -------------------- | --------------- | ---------- |
| Register: Clock-to-Q | $t_{pcq}$       | 35         |
| Register: Setup      | $t_{setup}$     | 60         |
| Multiplexer          | $t_{mux}$       | 40         |
| ALU(a)               | $t_{ALU}$       | 200        |
| Addierer             | $t_{adder}$     | 130        |
| Extended Einheit     | $t_{ext}$       | 40         |
| Memory: Lesen        | $t_{mem-read}$  | 225        |
| Memory: Setup        | $t_{mem-setup}$ | 50         |
| Register File: Lesen | $t_{RF-read}$   | 130        |
| Register File: Setup | $t_{RF-setup}$  | 70         |

Da jede Instruction im Single Cycle Prozessor in einem Taktzyklus ausgeführt wird, und wir wissen, dass `lw` der "längste" Befehl ist, ermitteln wir den kritischen Pfad des I-Types.

**I-Type:**

    **Fetch: Instruktion holen**

    $t_{fetch} = t_{pcq} = 35 \ ps$

    **Read Register: Quelloperand $rs1$ aus Register File lesen**

    $t_{reg-read} = t_{RF-read} = 130 \ ps$

    **Sign Extension**

    $t_{sign-ext} = t_{ext} = 40 \ ps$

    **Speicheradresse berechnen:**

    $t_{address} = t_{mux} + t_{ALU} = 40 \ ps + 200 \ ps = 240 \ ps$

    **Speicheradresse lesen und ins Register speichern:**

    $t_{reg-write} = t_{mem-read} + t_{mux} = 265 \ ps$

    **PC erhöhen:**

    $t_{pc-increment} = t_{adder} + t_{mux} + t_{setup} = 230 \ ps$

    **Pfad berechnen:**

    $t_{SCP-lw} = t_{fetch} + t_{reg-read} + t_{sign-ext} + t_{address} + t_{reg-write} + t_{pc-increment} = 940 \ ps$

**Instruktionslänge `lw` beim Multi Cycle Prozessor:**

$t_{MCP-lw} = t_{fetch} + t_{decode} + t_{memAdr} + t_{memRead} + t_{memWB} = 375 \ ps + 225 \ ps + 335 \ ps + 360 \ ps + 145 \ ps = 1140 \ ps $

**Maximale Frequenzen berechnen:**

    **Single Cycle Prozessor:**

    $f_{SCP} = \frac{1}{t_{lw}} = 1.063 \ GHz$

    **Multi Cycle Prozessor:**

    $f_{MCP} = \frac{1}{375 \ ps} = 2.66 \ GHz$

Somit hat der Multicycle Prozessor eine höhere Taktfrequenz, er ist jedoch langsamer da der berechnet Pfad ($t_{MCP-lw}$) länger ist als der vom Single Cycle Prozessor ($t_{SCP-lw}$).

---
