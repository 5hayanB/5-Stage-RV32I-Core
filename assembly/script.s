addi x6, x0, 1
FIBONACCI_LOOP:
add x7, x6, x5
add x5, x6, x0
add x6, x7, x0
jal FIBONACCI_LOOP
