# Computer Architecture

---

## Übung 08

### Aufgabe 01 - Leistungsbewertung

---

## Teammitglieder

- Aleksandar Stojanović, K12411325
- Annika Schmidthaler, K12411307
- Benedikt Zöchmann, K12410383

---

> Wir analysieren die drei RISC-V Prozessoren aus der Vorlesung:
> 
> - **Single-cycle** Prozessor $P_1$ mit einer Taktfrequenz von $1 \ GHz$
> 
> - **Pipelined** Prozessor $P_2$ mit 5-stufiger Pipeline und einer Taktfrequenz von $2 \ Ghz$
>   
>   - Jumps und Branches werden in `execute` ausgeführt.
>   
>   - Bei **Kontrollkonflikten** werden Befehle aus der Pipeline gelöscht.
>   
>   - Aufgrund von **Datenanhängigkeiten** muss nach jeder **siebten** arithmetischen Operation (`R-Type` & `addi`) ein Takt angehalten werden (wie NOP)
>   
>   - Beachte für $P_2$ auch, dass die Pipeline initial befüllt werden muss bevor mehrere Befehle parallel ausgeführt werden können.
> 
> - **Multicycle** Prozessor $P_3$ mit einer Taktfrequenz von $2 \ GHz$
>   
>   - Die Zyklen sollen aus der FSM extrahiert werden
> 
> a.) Berechne **CPI-Wert** und **Ausführungszeit** für jeden der drei Prozessoren für ein Programm mit **2,0 Milliarden Instruktionen** und dem in Table 1 gegebenen Instruktions-Mix. Gib den Rechenweg an.
> 
> b.) Bestimme den **MIPS-Wert** der Prozessoren $P_1, P_2$ und $P_3$. Gib den Rechenweg mit an.
> 
> <img title="" src="file:///C:/Users/MSI/AppData/Roaming/marktext/images/2025-06-05-18-12-35-image.png" alt="" width="395">
> 
> | Befehl              | rel. Häufigkeit |
> | ------------------- | --------------- |
> | `R-Type` & `I-Type` | $27 \ \%$       |
> | `lw`                | $18 \ \%$       |
> | `beq`$^1$           | $23 \ \%$       |
> | `sw`                | $9 \ \%$        |
> | `jal`               | $23 \%$         |
> 
> $^1$Bei $41 \ \%$ der `beq` Befehle wird der Sprung getätigt.

### Single-Cycle Prozessor

**CPI-Wert:**

Da es sich hier um einen Single Cycle Prozessor handelt, hat man hier einen **CPI-Wert** von $1$.

**Ausführungszeit:**

$I_c = 2 \ 000 \ 000 \ 000$

$CPI_{P_1} = 1$

$T_{P_1} = \frac{1}{1 \ GHz} = 1 \ ns$

$T_{exe}^{SC} = I_c \cdot CPI_{P_1} \cdot T_{P_1} = 2 \ s$

**MIPS-Wert:**

$MIPS_{P_{1}} = \frac{I_c}{T_{exe}^{SC} \cdot 10^6} = 1000$

### Pipelined Prozessor

**CPI-Wert:**

$Cycles = 4 + I_c + \frac{I_c \cdot 0.27}{7} + I_c \cdot 0.23 \cdot 0.41 \cdot 2 + I_c \cdot 0.23 \cdot 2 = 3374342861$

$CPI_{P_2} = \frac{Cycles}{I_c} = 1.687171431$

**Ausführungszeit:**

$CPI_{P_2} = 1.687171431$

$T_{P_2} = \frac{1}{2 \ GHz} = 0.5 \ ns$

$T_{exe}^{PL} = I_c \cdot CPI_{P_2} \cdot T_{P_2} = 1.687171431 \ s$

**MIPS-Wert:**

$MIPS_{P_2} = \frac{I_c}{T_{exe}^{PL} \cdot 10^6} = 1185.415995$

### Multicycle Prozessor

**CPI-Wert:**

$CPI_{P_3} = 0.23 \cdot 4 + 0.09 \cdot 4 + 0.23 \cdot 3 + 0.18 \cdot 5 + 0.27 \cdot 4 = 3.95$

**Ausführungszeit:**

$CPI_{P_3} = 3.95$

$T_{P_3} = \frac{1}{2 \ GHz} = 0.5 \ ns$

$T_{exe}^{MC} = I_c \cdot CPI_{P_3} \cdot T_{P_3} = 3.95 \ s$

**MIPS-Wert:**

$MIPS_{P_3} = \frac{I_c}{T_{exe}^{MC} \cdot 10^6} = 506.329$

---
