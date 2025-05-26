# Computer Architecture

---

## Übung 06

### Aufgabe 02cd - Datenabhängigkeiten und Pipeline-Konflikte

---

## Teammitglieder

- Aleksandar Stojanović, K12411325
- Annika Schmidtthaler, K12411307
- Benedikt Zöchmann, K12410383

---

> Betrachte das folgende RISC-V Programm und nimm an, dass es auf einem RISC-V Prozessor (siehe Abbildung 1) ausgeführt werden soll.
> 
> ```
> main:
>     addi t0, zero, 10
>     addi t1, zero, 20
>     add t2, t0, t1
>     and t0, t1, t0
>     beq t0, zero, skip
>     addi t3, zero, 1
> skip:
>     add t3, t2, t3
> ```
> 
> c) Behebe alle Pipeline-Konflikte durch Einfügen der minimalen Anzahl an NOP-Befehlen.
> d) Minimiere die Anzahl der NOP-Befehle durch Umordnen der Befehle (ohne die Semantik des Programms zu verändern). Nimm dabei an, dass der Prozessor auch das Löschen (flushen) von Pipeline-Registern unterstützt.

c.)

**Augangsposition**

|     | Fetch | Decode | Execute | Memory | Writeback |
| --- | ----- | ------ | ------- | ------ | --------- |
| 1   | addi  |        |         |        |           |
| 2   | addi  | addi   |         |        |           |
| 3   | add   | addi   | addi    |        |           |
| 4   | and   | add    | addi    | addi   |           |
| 5   | beq   | and    | add     | addi   | addi      |
| 6   | addi  | beq    | and     | add    | addi      |
| 7   | add   | addi   | beq     | and    | add       |
| 8   |       | add    | addi    | beq    | and       |
| 9   |       |        | add     | addi   | beq       |
| 10  |       |        |         | add    | addi      |
| 11  |       |        |         |        | and       |

**Einfügen von NOPs:**

|     | Fetch | Decode | Execute | Memory | Writeback |
| --- | ----- | ------ | ------- | ------ | --------- |
| 1   | addi  |        |         |        |           |
| 2   | addi  | addi   |         |        |           |
| 3   | nop   | addi   | addi    |        |           |
| 4   | nop   | nop    | addi    | addi   |           |
| 5   | nop   | nop    | nop     | addi   | addi      |
| 6   | add   | nop    | nop     | nop    | addi      |
| 7   | nop   | add    | nop     | nop    | nop       |
| 8   | and   | nop    | add     | nop    | nop       |
| 9   | nop   | and    | nop     | add    | nop       |
| 10  | nop   | nop    | and     | nop    | add       |
| 11  | nop   | nop    | nop     | and    | nop       |
| 12  | nop   | nop    | nop     | nop    | and       |
| 13  | beq   | nop    | nop     | nop    | nop       |
| 14  | nop   | beq    | nop     | nop    | nop       |
| 15  | addi  | nop    | beq     | nop    | nop       |
| 16  | nop   | addi   | nop     | beq    | nop       |
| 17  | add   | nop    | addi    | nop    | beq       |
| 18  |       | add    | nop     | addi   | nop       |
| 19  |       |        | add     | nop    | addi      |
| 20  |       |        |         | add    | nop       |
| 21  |       |        |         |        | add       |

**Es braucht 10 NOPs**

d.)

**Originalform**

```
main:
    addi t0, zero, 10
    addi t1, zero, 20
    add t2, t0, t1
    and t0, t1, t0
    beq t0, zero, skip
    addi t3, zero, 1
skip:
    add t3, t2, t3
```

**Abgeänderte Form unter Berücksichtigung der Abhängigkeiten:**

```
main:
    addi t0, zero, 10
    addi t1, zero, 20
    addi t3, zero, 1
    add t2, t0, t1
    and t0, t1, t0
    beq t0, zero, skip
skip:
    add t3, t2, t3
```

|     | Fetch | Decode | Execute | Memory | Writeback |
| --- | ----- | ------ | ------- | ------ | --------- |
| 1   | addi  |        |         |        |           |
| 2   | addi  | addi   |         |        |           |
| 3   | addi  | addi   | addi    |        |           |
| 4   | nop   | addi   | addi    | addi   |           |
| 5   | add   | nop    | addi    | addi   | addi      |
| 6   | nop   | add    | nop     | addi   | addi      |
| 7   | beq   | nop    | add     | nop    | addi      |
| 8   | nop   | beq    | nop     | add    | nop       |
| 9   | add   | nop    | beq     | nop    | add       |
| 10  |       | add    | nop     | beq    | nop       |
| 11  |       |        | add     | nop    | beq       |
| 12  |       |        |         | add    | nop       |
| 13  |       |        |         |        | add       |

Durch die Umordnung konnten wir die benötigten NOPs auf 3 reduzieren.

---
