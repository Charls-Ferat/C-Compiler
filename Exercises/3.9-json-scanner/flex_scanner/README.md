# JSON Scanner – FLEX Implementation

This directory contains a JSON lexical scanner implemented using **FLEX**.
The scanner recognizes all JSON tokens defined in the specification, including:

- Structural tokens: `{ } [ ] : ,`
- Literals: `true`, `false`, `null`
- Strings (with escape sequences)
- Numbers (integer, fractional, and exponential forms)

## Files

- `json.flex` – FLEX specification of the scanner
- `main.c` – Driver program that prints recognized tokens
- `tokens.h` – Token definitions shared between the scanner and the driver
- `test.json` – Sample JSON input file

## Build Instructions

Generate the scanner and compile:

```bash
flex json.flex
gcc lex.yy.c main.c -o scanner
```

## Usage

```bash
./scanner
```
The program reads `test.json`and prints each recognized token along with its lexeme.

## Notes
* This implementation relies on FLEX to generate the DFA from regular expressions.
* It closely follows the formal JSON lexical rules.
* Error handling reports unexpected characters with line numbers.
