# Aleksandar Stojanović, 12411325
# Annika Schmidthaler, 12411307
# Benedikt Zöchmann, 12410383

.globl main
.text
toh: # --- CALLER CONVENTIONS ---
	addi sp, sp, -24 # make space for 6 words on the stack
    sw a0, 0(sp) # save number of discs on stack, int n
    sw a1, 4(sp) # save name of 1st rod on stack, char src
    sw a2, 8(sp) # save name of 2nd rod on stack, char dest
    sw a3, 12(sp) # save name of 3rd rod on stack, char spare
    sw ra, 16(sp) # save return address on stack
    
    addi t0, zero, 1 # int count = 1;
    
    beq a0, zero, return_zero # if(n == 0)
    
    addi a0, a0, -1 # n = n-1
    jal ra toh # toh(n−1, src, spare, dest)
    sw a0, 20(sp) # store result of toh(n−1, src, spare, dest)
    
    lw t1, 20(sp) # load result of toh(n−1, src, spare, dest) into local var t1
    add t0, t0, t1 # count += toh(n−1, src, spare, dest)
    
    lw a0, 0(sp) # restore a0 (int n)
    addi a0, a0, -1 # n = n-1
    
    lw a1, 12(sp) # change src to spare
	lw a2, 4(sp) # change dest to src
    lw a3, 8(sp) # change spare to dest
    jal ra, toh
    sw a0, 24(sp)
    
    lw t2, 20(sp) # restore result of (n−1, src, spare, dest)
    add a0, t1, t2
    
	# <TODO> code goes here
    lw ra, 16(sp) # restore return address 
	addi sp, sp, 24 # restore stack pointer
	jalr zero, ra, 0
    
return_zero:
	lui a0, 0 # set n = 0
    addi a0, a0, 0
    
    lw ra, 16(sp) # restore return address 
	addi sp, sp, 24 # restore stack pointer
    jalr zero, ra, 0 # return
    
main: addi a0, zero, 5 # number of discs
	addi a1, zero, 'A' # name of 1st rod
	addi a2, zero, 'C' # name of 2nd rod
	addi a3, zero, 'B' # name of 3rd rod
    
	jal ra, toh
    
	addi a1, a0, 0 # move count to a1
	addi a0, zero, 1 # ecall print int
	ecall
    
	addi a0, zero, 10 # ecall exit
	ecall