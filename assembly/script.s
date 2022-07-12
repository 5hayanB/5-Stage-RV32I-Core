# addi x6, x0, 1
# addi x28, x0, 10
# FIBONACCI_LOOP:
# addi x29, x29, 1
# blt x28, x29, END
# add x7, x6, x5
# add x5, x6, x0
# add x6, x7, x0
# jal FIBONACCI_LOOP
# END:

addi x2, x0, 5
addi x7, x0, 6
addi x8, x0, 9
sw x2, 0(x0)
lw x3, 0(x0)
