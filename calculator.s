.global _start
_start:
    li a0, 39450

    call print_num
    call print_new_line

    li a7, 93
    ecall
