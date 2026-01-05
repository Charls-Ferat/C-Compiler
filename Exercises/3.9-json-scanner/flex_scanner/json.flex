%option yylineno

%{
#include "tokens.h"
#include <stdio.h>
#include <stdlib.h>
%}

%%
[ \t\n\r]+   {}
"{"        { return LBRACE; }
"}"        { return RBRACE; }
"["        { return LBRACKET; }
"]"        { return RBRACKET; }
":"        { return COLON; }
","        { return COMMA; }
"true"     { return TRUE; }
"false"    { return FALSE; }
"null"     { return NULL_TOKEN; }

\"([^\"\\]|\\(["\\/bfnrt]|u[0-9A-Fa-f]{4}))*\"      { return STRING; }

-?(([1-9][0-9]*)|0)(\.[0-9]+)?([eE][+-]?[0-9]+)?    { return NUMBER; }

. {
    fprintf(stderr,
        "Lexical error at line %d: unexpected '%s'\n",
        yylineno, yytext);
    return ERROR;
}

%%
int yywrap(void) { return 1; }
