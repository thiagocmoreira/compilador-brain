%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "lib/functions.c"
    #include "global.h"
    extern int lineCounter;
    FILE *file = NULL;
    void openOutputFile(char *algorithm_name) {
        if (!file) {
            char file_name[60];
            sprintf(file_name, "%s.c", algorithm_name);
            file = fopen(file_name, "w");
        }
    }
    void closeOutputFile() {
        if (file != NULL) {
            fclose(file);
        }
    }


%}
%union {
    int ival;
    double dval;
    char* strval;
}
//token declarations
    %token RESERVEDS_WORDS
    %token AND
    %token BEGIN_STATEMENT
    %token CASE
    %token CHAR
    %token CONST
    %token DIV
    %token DO
    %token ELSE
    %token END
    %token FALSE
    %token FOR
    %token FUNCTION
    %token IF
    %token INTEGER
    %token INTERFACE
    %token NOT
    %token OR
    %token PROCEDURE
    %token PROGRAM
    %token STRING_RESERVED
    %token THEN
    %token TO
    %token TYPE
    %token TRUE
    %token UNTIL
    %token VAR
    %token WHILE
    %token BOOLEAN
    %token REAL
    %token SIMPLE_WORD
    %token <strval> IDENTIFIER
    %token STRING
    %token NATURAL_NUMBER
    %token REAL_NUMBER
    %token POINT
    %token POWER
    %token SEMICOLON
    %token LEFT_PARENTHESIS
    %token RIGHT_PARENTHESIS
    %token COLON
    %token ASSIGNMENT
    %token PLUS
    %token MINUS
    %token TIMES
    %token DIVIDE
    %token EQUAL
    %token DIFFERENT
    %token SMALLER
    %token SMALLER_EQUAL
    %token BIGGER
    %token BIGGER_EQUAL

    %start PROGRAM_BEGGINING

%%
    PROGRAM_BEGGINING:
        Header Body END POINT { writeEndMain(file);
                                closeOutputFile();
                              }
        ;

    Header:
        PROGRAM IDENTIFIER  SEMICOLON {
            openOutputFile($2);
            writeLibrary(file);
        }
        ;

    Body:
        BEGIN_STATEMENT {
            writeMain(file);
        }
        ;

    Type:
        INTEGER
        | CHAR
        | BOOLEAN
        ;

%%
#include "lex.yy.c"
int yyerror (void){
	printf("Erro na Linha: %d\n", lineCounter);
}

//main function
int main(void){

    yyparse();

    return 0;
}
