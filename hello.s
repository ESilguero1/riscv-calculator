.section .data
digit_buf: .byte 0x00
new_line: .asciz "\n"
space: .asciz " "

.section .text
.global print_new_line

print_new_line:
    la a1, new_line
    li a0, 1
    li a2, 1
    li a7, 64

    ecall

    ret

.global print_space

print_space:
    la a1, space
    li a0, 1
    li a2, 1
    li a7, 64

    ecall

    ret

# Prints a single digit to terminal
# Input: Digit in a0
# Output: None
.global print_a0_digit
print_a0_digit:
    li t0, 48
    add t1, a0, t0
    la a1, digit_buf
    sb t1, 0(a1)

    li a0, 1
    li a2, 1
    li a7, 64
    ecall
    ret

# Prints a number to the terminal
# Input: Number to print in a0
# Output: None
.global print_num

print_num:
    # Push ra to stack
    addi sp, sp, -4
    sw ra, 0(sp)

    # Divide number by 10 to get last digit (as remainder)
    li a1, 10
    call divmod

    # Push digit to stack
    addi sp, sp, -4
    sw a1, 0(sp)

    # Check base case
    beq a0, zero, base

    # Recursive call
    call print_num

base:
    # Pop digit from stack
    lw a0, 0(sp)
    addi sp, sp, 4

    call print_a0_digit

    # Pop ra from stack
    lw ra, 0(sp)
    addi sp, sp, 4

    ret
    