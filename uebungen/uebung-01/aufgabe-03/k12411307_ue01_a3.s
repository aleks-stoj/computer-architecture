.globl main

.data
arr: .word 0x4, 0x8, 0x12, 0x11, 0x5, 0x21, 0x1, 0x99, 0x41, 0xFF

.text

main: la s0, arr		# pointer to address of arr
	lw t1, 0(s0)		# load first word
    
    # set min and max to first word, to guarantee value in arr
    add a0, zero, t1	# a0 = min
    add a1, zero, t1	# a1 = max
    add s2, zero, t1	# s2 = sum
    
    addi s1, zero, 1 	# s1 = i = 1
    addi t2, zero, 10	# t2 = length
    
loop: bge s1, t2, loop_end	# end if i >= length
    # load next word
    slli t0, s1, 2 			# t0 = i * 4 (byte offset)
    add t0, t0, s0 			# t0 = address of array[i]
    lw t1, 0(t0)			# t1 = array[i]
    
    add, s2, s2, t1			# add to sum
    
    blt t1, a0, set_min		# when smaller current min
    blt a1, t1, set_max		# when smaller current max
    
   	jal zero, continue
    
set_min: add a0, zero, t1
	jal zero, continue

set_max: add a1, zero, t1
	jal zero, continue
    
continue: addi s1, s1, 1	# increment
	jal zero, loop
    
loop_end:
	div a2, s2, t2			# summe / anzahl
