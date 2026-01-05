# JSON Scanner – FSM Implementation

This directory contains a **hand-written JSON scanner** implemented using an explicit
finite state machine (FSM).

The scanner manually encodes the DFA logic using states and transitions,
without relying on lexer generators such as FLEX.

## Files

- `scanner.c` – FSM-based JSON scanner
- `test.json` – Sample JSON input file

## Supported Tokens

- Structural tokens: `{ } [ ] : ,`
- Literals: `true`, `false`, `null`
- Strings (with basic escape sequences)
- Numbers (accepted using a permissive numeric FSM)

## Build Instructions

```bash
gcc scanner.c -o scanner
```

## Usage
```bash
./scanner
```
The program scans `test.json` and prints each token with its associated lexeme.


## Notes
* This implementation emphasizes clarity over strict numeric validation.
* Unicode escape sequences (\uXXXX) are not fully validated.
* The scanner demonstrates:
  * Manual state transitions
  * Lookahead via character pushback
  * Longest-match token recognition

This version closely follows the educational intent of the textbook by making
the automaton logic explicit.
