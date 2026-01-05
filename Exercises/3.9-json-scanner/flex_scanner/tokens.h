# pragma once

typedef enum {
    TOKEN_EOF = 0,
    LBRACE = 256,
    RBRACE,
    LBRACKET,
    RBRACKET,
    COLON,
    COMMA,
    TRUE,
    FALSE,
    NULL_TOKEN,
    STRING,
    NUMBER,
    ERROR
} token_t;
