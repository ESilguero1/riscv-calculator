.section .data
welcome_message: .asciz "Welcome to my epic four-function calculator!\n"

.section .text
.global _start
_start:
    la a0, welcome_message

    call print_string

    li a7, 93
    ecall
