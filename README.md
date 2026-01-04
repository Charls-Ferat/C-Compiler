# C Compiler (from Scratch)

This repository documents the progressive development of a C compiler,
following the book *Introduction to Compilers and Language Design*.

The goal of this project is to **understand and implement** the fundamental
phases of a modern compiler, from lexical analysis to code generation,
with an emphasis on both theoretical foundations (automata, grammars, IRs)
and their practical realization in C/C++.

---

## Repository Structure

```text
c-compiler/
├── Exercises/     # Exercises and mini-projects from the book
├── Compiler/       # Final compiler implementation
├── Docs/           # Theoretical notes and references
└── Scripts/        # Auxiliary scripts

---


### Exercises/

```text
Contains self-contained exercises whose purpose is to explore fundamental
concepts of compiler design, such as:

- toolchains
- regular expressions
- scanners
- automata

Each exercise includes:

- source code
- generated artifacts
- minimal documentation describing the objective and conclusions

---

### Compiler/

Incremental implementation of the final compiler.

This directory contains only stable code that is correct, documented,
and intended to be clear and easy to understand.


## References
- Introduction to Compilers and Language Design
- https://json.org
