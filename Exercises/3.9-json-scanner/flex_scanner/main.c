#include "tokens.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylex();
extern char *yytext;

const char *tokname(token_t t) {
    switch (t) {
        case LBRACE: return "LBRACE";
        case RBRACE: return "RBRACE";
        case LBRACKET: return "LBRACKET";
        case RBRACKET: return "RBRACKET";
        case STRING: return "STRING";
        case COLON: return "COLON";
        case COMMA: return "COMMA";
        case NUMBER: return "NUMBER";
        case TRUE: return "TRUE";
        case FALSE: return "FALSE";
        case NULL_TOKEN: return "NULL";
        case ERROR: return "ERROR";
        default: return "OTHER";
    }
}

int main() {
    yyin = fopen("test.json","r");

    if(!yyin) {
        printf("could not open test.json!\n");
        return 1;
    }

    token_t t;
    while((t = yylex()) != 0) {
        printf("token: %-10s text: %s\n", tokname(t), yytext);
    }
}
