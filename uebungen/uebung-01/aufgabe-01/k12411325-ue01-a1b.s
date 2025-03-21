.data

.globl main

.text

main:
    lui t0, 0xCAFEB
    addi t0, t0, 0xABE # int a  = 0xCAFEBABE;
    lui t1, 0xDEADB # int b  = 0xDEADBEEF;
    addi t1, t1, 0xEEF
    
    sub t2, zero, t0 # negate int a
    sub t3, zero, t1 # negate int b
    xor t4, t2, t1 # (~a ^ b)
    or t5, t0, t3 # (a | ~b)
    and a0, t4, t5 # a0 = (~a ^ b) & (a | ~b)