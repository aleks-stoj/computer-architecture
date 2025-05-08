# Aleksandar Stojanović, 12411325
# Annika Schmidthaler, 12411307
# Benedikt Zöchmann, 12410383

.data
data0: .float 0.0 0.0 0.0 0.0 0.0 0.0
data1: .float 0.0 0.0 0.0 0.0 0.0 0.0
.text
.globl main

main:
la a0, data0            # a0 = pointer to data0 float array
la a1, data1            # a1 = pointer to data1 float array
addi a2, zero, 6        # a2 = 6
addi t0, zero, 0        # t0 = 0
addi t5, zero, 2        # t5 = 2
fcvt.s.wu ft3, t5       # ft3 = t5 (2.0)
lui t6, 263313          # t6 = 263313 << 12, t6 = 263313*4096=1078339584=0x40492000
addi t6, t6, -37        # t6 -= 37 , 0x40492000-37=0x40491FDB (erstellt bit pattern für π)
fmv.s.x ft0, t6         # ft0 = t6 (move to float register, ft0 = π)

loop:
bge t0, a2, end_loop    # t0 >= a2 -> break
fcvt.s.wu ft1, t0       # ft1 = t0 (as float)
fmul.s ft2, ft1, ft1
fmul.s ft2, ft2, ft0    # ft2 = ft1 ^ 2 * fth0
fsw ft2, 0(a0)          # safe in array, data0[0] = ft2
fmul.s ft2, ft1, ft3    
fmul.s ft2, ft2, ft0    # ft2 = ft1*ft3*ft0
fsw ft2, 0(a1)          # safe in array, data1[0] = ft2
addi a0, a0, 4          # shift pointer to next array entry
addi a1, a1, 4          # shift pointer to next array entry
addi t0, t0, 1          # t0++
jal zero, loop          # jump to start of loop

end_loop:
addi a0, zero, 10       # ecall 10
ecall