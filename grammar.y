%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
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
            printf("fechou\n");
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
        Header {} END POINT {closeOutputFile();}
        ;

    Header:
        PROGRAM IDENTIFIER  SEMICOLON {
            printf("%s\n", $2);
            openOutputFile($2);
            printf("#include <stdio.h>\n#include <stdlib.h>\n#include <math.h>\n\n");
        }
        ;

%%
#include "lex.yy.c"
yyerror (void){
	printf("Erro na Linha: %d\n", lineCounter);
}

//main function
int main(void){

    yyparse();

    return 0;
}
