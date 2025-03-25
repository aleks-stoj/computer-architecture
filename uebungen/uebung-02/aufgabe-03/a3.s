# Aleksandar Stojanović, 12411325
# Annika Schmidthaler, 12411307
# Benedikt Zöchmann, 12410383

.globl main
.text
toh: # --- CALLER CONVENTIONS ---
	addi sp, sp, -12 # make space for 6 words on the stack
    sh a0, 0(sp) # save number of discs on stack, int n
    sh a1, 2(sp) # save name of 1st rod on stack, char src
    sh a2, 4(sp) # save name of 2nd rod on stack, char dest
    sh a3, 6(sp) # save name of 3rd rod on stack, char spare
    sh ra, 8(sp) # save return address on stack
    
    addi t0, zero, 1 # int count = 1;
    
    beq a0, zero, return_zero # if(n == 0)
    
    addi a0, a0, -1 # n = n-1
    jal ra toh # toh(n−1, src, spare, dest)
    add a0, a0, t0
    sh a0, 10(sp) # store result of toh(n−1, src, spare, dest)
    
    lh a0, 0(sp) # restore a0 (int n)
    addi a0, a0, -1 # n = n-1
    
    lh a1, 6(sp) # change src to spare
    lh a2, 4(sp) # change spare to dest
    lh a3, 2(sp) # change dest to src
    jal ra, toh
    
    lh t2, 10(sp) # restore result of (n−1, src, spare, dest)
    add a0, a0, t2
    
    lh ra, 8(sp) # restore return address 
	addi sp, sp, 12 # restore stack pointer
	jalr zero, ra, 0
    
return_zero:
	lh ra, 8(sp) # restore return address 
	addi sp, sp, 12 # restore stack pointer
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
