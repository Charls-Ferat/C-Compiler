// FINITE AUTOMATON JSON scanner
# include <ctype.h>
# include <stdio.h>
# include <string.h>


// State definitions
typedef enum {
    S_START,
    S_STRING,
    S_STRING_ESCAPE,
    S_NUMBER,
    S_IDENT,
    S_NULL,
    S_ERROR
} State;

// Token definitions
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

// Token names
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

// Scanner function declarations & globals
int next_token(void);
static int next_char(void);
static void push_char(int c);

static FILE *in;
static int current_char;
static int line = 1;

static char lexeme[1024];
static int lexeme_len = 0;


int main () {
    // Read the input
    in = fopen("test.json", "r");
    if (!in) {
        perror("test.json");
        return 1;
    }

    // Loop trough every token
    token_t t;
    while((t = next_token()) != TOKEN_EOF)
        printf("token %-8s lexeme: %s\n", tokname(t), lexeme);

    fclose(in);
    return 0;
}

// Scanner implementation
int next_token(void){
    static State state = S_START;
    lexeme_len = 0;

    int c;

    // Loop trough the file
    while((c = next_char()) != EOF){
        switch (state){
            // Cases
            case S_START:
                // Ignore spaces
                if (isspace(c)) continue;
                // Filter single char expressions
                if (c == '{') { lexeme[0] = '\0'; return LBRACE; }
                if (c == '}') { lexeme[0] = '\0'; return RBRACE; }
                if (c == '[') { lexeme[0] = '\0'; return LBRACKET; }
                if (c == ']') { lexeme[0] = '\0'; return RBRACKET; }
                if (c == ':') { lexeme[0] = '\0'; return COLON; }
                if (c == ',') { lexeme[0] = '\0'; return COMMA; }

                // Multi char buffering
                if (c == '"'){                  // Strings
                    state = S_STRING;
                    continue;
                }

                if (isdigit(c) || c == '-'){    // Numbers
                    lexeme[lexeme_len++] = c;
                    state = S_NUMBER;
                    continue;
                }

                if (isalpha(c)){                // Identifiers
                    lexeme[lexeme_len++] = c;
                    state = S_IDENT;
                    continue;
                }

                return ERROR;   // No character match

            case S_STRING:
                if (c == '"'){
                    lexeme[lexeme_len] = '\0';
                    state = S_START;
                    return STRING;
                }
                if (c == '\\'){
                    state = S_STRING_ESCAPE;
                }
                else {
                    lexeme[lexeme_len++] = c;
                }
                break;

            case S_STRING_ESCAPE:
                if (c == '"' || c == '\\' || c == '/' ||
                    c == 'b' || c == 'f' || c == 'n' ||
                    c == 'r' || c == 't'){
                    lexeme[lexeme_len++] = c;
                    state = S_STRING;
                } else {
                    return ERROR;
                }

                break;

            case S_NUMBER:
                if (isdigit(c) || c == '.' || c == 'e' || c == 'E' || c == '+' || c == '-'){
                    lexeme[lexeme_len++] = c;
                } else {
                    lexeme[lexeme_len] = '\0';
                    push_char(c);
                    state = S_START;
                    return NUMBER;
                }
                break;

            case S_IDENT:
                if(isalpha(c)){
                    lexeme[lexeme_len++] = c;
                } else {
                    lexeme[lexeme_len] = '\0';
                    push_char(c);
                    state = S_START;

                    // Check Identifiers
                    if(strcmp(lexeme, "true") == 0) return TRUE;
                    if(strcmp(lexeme, "false") == 0) return FALSE;
                    if(strcmp(lexeme, "null") == 0) return NULL_TOKEN;

                    return ERROR; // NO match
                }
                break;

            // Default
            default:
                return ERROR;
        }
    }

    return TOKEN_EOF; // Finished the file
}

static int next_char(void){
    int c = fgetc(in);
    if (c == '\n') line++;
    return c;
}

static void push_char(int c){
    if (c == '\n') line--;
    ungetc(c, in);
}
