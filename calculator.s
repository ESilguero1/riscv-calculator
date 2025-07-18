.section .data
welcome_message: .asciz "Welcome to my epic four-function calculator!\n"

.section .text
.global _start
_start:
    call read_num
    call print_num
    call print_new_line

    li a7, 93
    ecall
