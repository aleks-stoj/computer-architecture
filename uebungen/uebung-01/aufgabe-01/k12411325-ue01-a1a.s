.data

.globl main

.text

main:
    addi t0, zero, 0xFFFFFFF3 # int a  = 0xFFFFFFF3;
    addi t1, zero, 0x2 # int b  = 0x2;
    addi t2, zero, 0xFFFFFFF3 # unsigned int c = 0xFFFFFFF3;
    addi t3, zero, 0x2 # unsigned int d  = 0x2;
    
    # int y = (a << b) + (a >> b)
    sll a0, t0, t1 # a0 = (a << b)
    sra t4, t0, t1 # t4 = (a >> b)
    add a0, a0, t4 # a0 = a0 + t4
    
    # unsigned int z = (a << b) + (a >> b)
    sll a1, t2, t3 # a0 = (a << b)
    srl t4, t2, t3 # t4 = (a >> b), reusing local var t4
    add a1, a1, t4 # a1 = a1 + t4