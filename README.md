# Exercise 2.4 – C Compilation Toolchain Exploration

This exercise corresponds to section 2.4 of the book *Introduction to Compilers and Language Design*.

## Objective

To practically explore the different stages of the C compilation toolchain:

1.  **Preprocessor**
2.  **Compiler**
3.  **Assembler**
4.  **Linker**

Additionally, this project aims to observe the impact of various optimization levels on the generated assembly code.

---

## Program Description

The program implements a **1D convolution** over a large data array (`N = 5,000,000`) with the following characteristics:

* **No external inputs:** Ensures consistent behavior across runs.
* **Deterministic computation:** The output is predictable and repeatable.
* **Checksum included:** Prevents the compiler from optimizing away the entire calculation as "dead code."
* **Optimization comparison:** Designed to analyze code generation under different flags (`-O0`, `-O1`, `-O3`, `-Os`).

This design forces the compiler to generate meaningful code at every stage of the process.

---

## Directory Structure

```text
2.4-toolchain/
├── src/            # Source code (.c)
├── preprocessed/   # Preprocessor output (.i)
├── assembly/       # Assembly code (.s)
├── object/         # Object files (.o)
└── bin/            # Final executables


## Commands used - Standard Compilation Steps
### 1. Preprocessor:

```Bash
gcc -E src/main.c > preprocessed/main.i

### 2. Compilation to Assembly:
```Bash
gcc -S src/main.c -o assembly/main.s

### 3. Assembly to Object File:
```Bash
gcc -c assembly/main.s -o object/main.o

### 4. Linking:
```Bash
gcc object/main.o -o bin/main.exe

## Optimization Levels Comparison
To compare how the compiler handles the code, use the following commands:

```Bash
gcc -O0 src/main.c -o bin/main_O0.exe
gcc -O1 src/main.c -o bin/main_O1.exe
gcc -O3 src/main.c -o bin/main_O3.exe
gcc -Os src/main.c -o bin/main_Os.exe
