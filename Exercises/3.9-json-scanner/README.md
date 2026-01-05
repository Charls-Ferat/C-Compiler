# JSON Scanner – Section 3.9

This directory contains two implementations of a lexical scanner for the JSON language,
developed as part of **Section 3.9** of *Introduction to Compilers and Language Design*.

The goal of this exercise is to practice lexical analysis by recognizing JSON tokens
such as strings, numbers, punctuation symbols, and reserved keywords.

Two approaches are provided:

- **FLEX-based scanner** (generated lexer)
- **Manual FSM-based scanner** (hand-written deterministic automaton)

This allows a direct comparison between generated and explicit lexical analyzers.

## Directory Structure
<pre>
    3.9-json-scanner/
    ├── flex_scanner/ # Scanner implemented using FLEX
    └── fsm_scanner/ # Hand-written finite state machine scanner
</pre>

Each subdirectory contains its own README with build and usage instructions.
