# Makefile

all: calculator.elf

calculator.elf: calculator.s IO.s operations.s
	riscv64-linux-gnu-gcc -nostdlib -static -g -o calculator.elf calculator.s IO.s operations.s

clean:
	rm -f calculator.elf