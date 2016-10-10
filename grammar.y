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
    %token <strval> CHAR_TYPE
    %token CONST
    %token DIV
    %token DO
    %token ELSE
    %token END
    %token EOL
    %token FALSE
    %token FOR
    %token FUNCTION
    %token IF
    %token <strval> INTEGER_TYPE
    %token INTERFACE
    %token <strval> NAME_VARIABLE
    %token NOT
    %token OR
    %token PROCEDURE
    %token PROGRAM
    %token THEN
    %token TO
    %token TYPE
    %token TRUE
    %token UNTIL
    %token VAR
    %token WHILE
    %token WRITE
    %token WRITELN
    %token <strval> REAL_TYPE
    %token SIMPLE_WORD
    %token <strval> IDENTIFIER
    %token <strval> STRING
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

    %type <strval> Type

    %left INTEGER_TYPE
    %right IDENTIFIER

    %start ProgramBegining

%%
    ProgramBegining:
        Header HeaderVariables Variables FirstBegin END POINT { writeEndMain(file);closeOutputFile();}
        ;

    Header:
        PROGRAM IDENTIFIER  SEMICOLON {
            openOutputFile($2);
            writeLibrary(file);
        }
        ;
    HeaderVariables:
        VAR
        ;

    Variables:
        IDENTIFIER COLON Type SEMICOLON {
          printf("%s\n", $3);
          writeSimpleVariable(file, $1, $3);
        }
        ;

    FirstBegin:
        BEGIN_STATEMENT {writeMain(file);} Body
        ;

    Body:
        WRITE LEFT_PARENTHESIS STRING RIGHT_PARENTHESIS SEMICOLON {
            writeSimplePrint(file, $3);
        }
        |
        WRITELN LEFT_PARENTHESIS STRING RIGHT_PARENTHESIS SEMICOLON {
            writePrintLN(file, $3);
        }
        ;

    Type:
        INTEGER_TYPE
        | CHAR_TYPE
        | REAL_TYPE
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
