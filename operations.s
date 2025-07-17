.section .text

# Multiplies two 32-bit integers
# Input: Multiplier in a0, multiplicand in a1
# Output: Product in a0
.global mult
mult:
    mv t0, a0
    mv t1, a1
    li a0, 0

lp:
    beq t1, zero, res
    andi t2, t1, 1
    beq t2, zero, noadd
    add a0, a0, t0

noadd:
    slli t0, t0, 1
    srli t1, t1, 1
    j lp

res:
    ret


# Divides two 32-bit integers
# Input: Dividend in a0, divisor in a1
# Output: Quotient in a0, remainder in a1
.global divmod
divmod:
    mv t0, a0   # t0 is now dividend
    mv t1, a1   # t1 is now divisor
    li a0, 0    # a0 is now quotient
    li a1, 0    # a1 is now remainder
    li t2, 31

dloop:
    blt t2, zero, ddone
    slli a1, a1, 1
    srl t3, t0, t2
    andi t3, t3, 1
    or a1, a1, t3
    blt a1, t1, nosub
    sub a1, a1, t1
    li t3, 1
    sll t3, t3, t2
    or a0, a0, t3

nosub:
    addi t2, t2, -1
    j dloop

ddone:
    ret
