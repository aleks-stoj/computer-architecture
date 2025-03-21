# Aleksandar Stojanović, 12411325
# Annika Schmidthaler, 12411307
# Benedikt Zöchmann, 12410383

.data

.globl main

.text

main:
# Code um Speicher wie in der Angabe zu setzten
auipc a0, 65536
addi t0, zero, 21
sb t0, 0(a0)
addi t0, zero, 69
sb t0, 1(a0)
addi t0, zero, 38
sb t0, 2(a0)
addi t0, zero, 9
sb t0, 3(a0)
addi t0, zero, 31
sb t0, 4(a0)
addi t0, zero, 70
sb t0, 5(a0)
addi t0, zero, 100
sb t0, 6(a0)
addi t0, zero, 44
sb t0, 7(a0)

auipc a0, 65536		# a0 = 0x10000000 (1. Speicheradresse)
addi a0, a0, -68	# eigentlich ist statt -68 hier 0, aber durch die Memory setup Befehle ist PC dann zu hoch wegen den 17 Befehlen davor
addi a1, zero, 8	# a1 = 8
auipc a2, 65536		# a2 = 0x1000000C
addi a2, a2, -72	# a2 = 0x10000008 	auch hier, eigentlich ist es -4, aber ich muss wieder zusätzlich -68 rechnen
jal ra, jump 		# PC + 12
addi a0, zero, 10	# a0 = 10
ecall

jump:
add t0, zero, zero	# t0 = 0

loop:
bge t0, a1, return 	# t0 >= a1 -> PC+32

lb t2, 0(a0)		# ladet byte vom Speicher in t2
xori t1, t2, -1		# t1 = t2 invertiert
sh t1, 0(a2)		# speichert die untersten 2 byte von t1 an die adresse von a2
addi t0, t0, 1		# t0++
addi a0, a0, 1		# a0++
addi a2, a2, 2		# a2+=2
jal zero, loop 		# PC -28

return:
jalr zero, ra, 0	# Kehrt zum Hauptprogramm zurück