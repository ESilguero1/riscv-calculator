# RISC-V Four-Function Calculator

This project implements a basic four-function calculator entirely in RISC-V assembly language. It provides a command-line interface for users to perform addition, subtraction, multiplication, and division operations on 32-bit integers.

## Features

* **Arithmetic Operations:** Supports addition (+), subtraction (-), multiplication (\*), and division (/).

* **Positive Integer Support:** **Currently, the calculator only handles positive integer inputs and produces positive integer results.**

* **Custom Multiplication:** Implements a binary shift-and-add algorithm for multiplication.

* **Custom Division:** Implements a non-restoring division algorithm to calculate quotient and remainder.

* **User Input/Output:**

  * Prompts for two integer operands and an operator.

  * Prints the expression and the calculated result.

  * Displays remainder (R) for division operations.

* **Interactive Loop:** Allows for multiple calculations until the user chooses to exit.

* **Modular Design:** Code is organized into separate files for operations, I/O, and the main calculator logic.

* **Recursive Number Printing:** Utilizes a recursive subroutine to print multi-digit numbers to the console.

## How to Build and Run

To build and run this project, you will need a RISC-V GNU toolchain and QEMU (or another RISC-V simulator like Spike or RARS).

**1. Set up your Environment (e.g., in Gitpod or Ubuntu-based system):**

First, ensure you have the necessary RISC-V cross-compilation tools and QEMU installed. If you're in a Gitpod environment or a fresh Ubuntu-based system, you can typically install them with:

```bash
sudo apt update
sudo apt install gcc-riscv64-linux-gnu qemu-user -y
```

**2. Build the Executable:**

Navigate to the project directory containing the `Makefile`. Then, simply run `make`:

```bash
make
```

This will use `riscv64-linux-gnu-gcc` to assemble and link `calculator.s`, `IO.s`, and `operations.s` into a single executable file named `calculator.elf`.

**3. Run the Calculator:**

You can run the compiled RISC-V executable using QEMU:

```bash
qemu-riscv64 calculator.elf
```

Alternatively, if you prefer a different simulator like Spike or RARS, you would use their respective commands (e.g., `spike pk calculator.elf` for Spike).

## Code Structure

The project is divided into three main assembly files:

* **`calculator.s`**: Contains the main program logic, user interaction (prompts, input, output), and calls to the `evaluate` function. This is the entry point (`_start`).

* **`operations.s`**: Implements the core arithmetic subroutines:

  * `mult`: Multiplies two 32-bit integers using a binary shift-and-add algorithm.

  * `divmod`: Divides two 32-bit integers using a non-restoring division algorithm, returning both quotient and remainder.

* **`IO.s`**: Handles all input/output operations, including:

  * `print_string`: Prints a null-terminated string.

  * `print_char`: Prints a single character.

  * `print_num`: Prints a 32-bit integer (using recursion).

  * `read_char`: Reads a single character from input.

  * `read_num`: Reads a multi-digit integer from input.

## Future Enhancements

I plan to expand this project to include:

* **Negative Number Support:** Implement logic to handle arithmetic operations involving negative integers.

* **Robust Edge Case Handling:** Improve error handling for scenarios like division by zero and invalid input.

* **Floating-Point Arithmetic:** Potentially extend the calculator to support floating-point numbers, requiring software implementations of floating-point operations if hardware support is not available.

## Author

Elijah Silguero
