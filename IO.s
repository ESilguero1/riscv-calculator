.section .data
space: .asciz " "
digit_buf: .byte 0x00
new_line: .asciz "\n"
char_buf: .byte 0x00
.global input_char_buf
input_char_buf: .byte 0x00
.global input_buf
input_buf: .space 32

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

# Prints a single character to terminal
# Input: Character in a0
# Output: None
.global print_char

print_char:
    la a1, char_buf
    sb a0, 0(a1)

    li a0, 1
    li a2, 1
    li a7, 64
    ecall
    ret

# Prints a null-terminated string to terminal
# Input: Address to string in a0
# Output: None
.global print_string

print_string:
    # Push s0 and ra to stack
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    # Store address so it doesn't get lost in subroutines
    mv s0, a0

sloop:
    lb a0, 0(s0)
    beq a0, zero, sdone
    call print_char
    addi s0, s0, 1
    j sloop

sdone:
    # Pop s0 and ra from stack
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8

    ret

# Prints a number to the terminal
# Input: Number to print in a0
# Output: None
.global print_num

print_num:
    # Push ra to stack
    addi sp, sp, -4
    sw ra, 0(sp)

    # Handle negative numbers
    bge a0, zero, pos
    neg a0, a0

    # Push number to stack
    addi sp, sp, -4
    sw a0, 0(sp)

    # Print negative sign
    li a0, '-'
    call print_char

    # Pop number from stack
    lw a0, 0(sp)
    addi sp, sp, 4

pos:
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

# Reads a character from the terminal
# Input: None
# Output: Character in a0
.global read_char

read_char:
    li a0, 0
    la a1, input_char_buf
    li a2, 2    # Read two bytes to account for newline character
    li a7, 63

    ecall

    la t0, input_char_buf
    lb a0, 0(t0)

    ret

# Reads a number from the terminal
# Input: None
# Output: Integer input in a0
.global read_num

read_num:
    # Push ra and s0-s3 to stack
    addi sp, sp, -20
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)

    # Get input from terminal
    li a0, 0
    la a1, input_buf
    li a2, 32
    li a7, 63

    ecall

    # Convert string to integer value
    li s1, 0
    li s3, 0
    la s0, input_buf

    # Check for '-' character to indicate negative number
    li t0, '-'
    lb t1, 0(s0)
    bne t1, t0, loop # proceed to loop if it's positive
    li s3, 1         # otherwise, set flag in s3 to indicate number should be negative
    addi s0, s0, 1   # "consume" the dash character to allow for regular processing

loop:
    li t1, '\n'
    lb t2, 0(s0)
    beq t2, t1, rdone

    # Convert character to integer
    addi s2, t2, -48 

    # "Append" digit to integer
    mv a0, s1
    li a1, 10
    call mult
    add s1, a0, s2

    addi s0, s0, 1
    j loop

rdone:
    mv a0, s1

    # Negate number if s3 is set
    beq s3, zero, return
    neg a0, a0

return:
    # Pop ra and s0-s3 from stack
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    addi sp, sp, 20

    ret
