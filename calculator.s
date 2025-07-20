.section .data
welcome_message: .asciz "Welcome to my epic four-function calculator!\n"
first_num_prompt: .asciz "Enter the first number: "
op_prompt: .asciz "Enter the operation you'd like to perform (+, -, /, or *): "
second_num_prompt: .asciz "Enter the second number: "
end_prompt: .asciz "Enter e to exit, or any other key to perform a new calculation: "
exit_message: .asciz "Thank you for using my epic four-function calculator! Have a great day!\n"

op_char: .byte 0x00

.section .text

# Evaluates a given expression
# Input: First operand in a0, second operand in a1, operator character in a2
# Output: Numerical result of operation in a0, possible remainder in a1
evaluate:
    # Push ra to stack
    addi sp, sp, -4
    sw ra, 0(sp)

    li t0, '+'
    li t1, '-'
    li t2, '*'
    li t3, '/'

    # Perform needed operation
    beq a2, t0, addition
    beq a2, t1, subtraction
    beq a2, t2, multiplication
    beq a2, t3, division

addition:
    add a0, a0, a1
    li a1, 0
    j res

subtraction:
    sub a0, a0, a1
    li a1, 0
    j res

multiplication:
    call mult
    li a1, 0
    j res

division:
    call divmod

res:
    # Pop ra from stack
    lw ra, 0(sp)
    addi sp, sp, 4

    ret

.global _start
_start:
    # Print welcome message
    la a0, welcome_message
    call print_string
    li s2, 1

main_loop:
    beq s2, zero, end
    call print_new_line
    # Prompt for first number
    la a0, first_num_prompt
    call print_string

    # Get first number input
    call read_num
    mv s0, a0   # Store first operand in s0

    # Prompt for operator
    la a0, op_prompt
    call print_string

    # Get operator input
    call read_char

    # Store operator
    la t0, op_char
    sb a0, 0(t0)

    # Prompt for second number
    la a0, second_num_prompt
    call print_string

    # Get second number input
    call read_num
    mv s1, a0   # Store second operand in s1

    # Print expression
    mv a0, s0
    call print_num
    call print_space
    la t0, op_char
    lb a0, 0(t0)
    call print_char
    call print_space
    mv a0, s1
    call print_num
    call print_space
    li a0, '='
    call print_char
    call print_space

    # Evaluate expression
    mv a0, s0
    mv a1, s1
    la t0, op_char
    lb a2, 0(t0)

    call evaluate

    # Save remainder if there is one
    mv s3, a1

    call print_num

    # Print remainder if there is one
    beq s3, zero, no_rem
    call print_space
    li a0, 'R'
    call print_char
    mv a0, s3
    call print_num

no_rem:
    call print_new_line

    # Prompt to exit or continue
    la a0, end_prompt
    call print_string

    # Get input
    call read_char
    li t0, 'e'

    beq a0, t0, end

    j main_loop

end:
    la a0, exit_message
    call print_string
    li a7, 93
    ecall
