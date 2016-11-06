%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "lib/functions.c"
    #include "global.h"
    #include "lib/node.c"

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
    %token <strval> DO
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
    %token <strval> TO
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
    %token <strval> NATURAL_NUMBER
    %token <strval> REAL_NUMBER
    %token POINT
    %token POWER
    %token SEMICOLON
    %token LEFT_PARENTHESIS
    %token RIGHT_PARENTHESIS
    %token COLON
    %token ASSIGNMENT
    %token <strval> PLUS
    %token <strval> MINUS
    %token <strval> TIMES
    %token <strval> DIVIDE
    %token <strval> EQUAL
    %token DIFFERENT
    %token SMALLER
    %token SMALLER_EQUAL
    %token BIGGER
    %token BIGGER_EQUAL

    %type <strval> Type
    %type <strval> Number
    %type <strval> Operator
    %type <strval> Aritmetic
    %type <strval> LoopStatement

    %start ProgramBegining

%%
    ProgramBegining:
        Header FirstBegin
        ;

    Header:
        HeaderAlgorithm
        |HeaderAlgorithm HeaderVariables
        ;

    HeaderAlgorithm:
        PROGRAM IDENTIFIER  SEMICOLON {
            openOutputFile($2);
            writeLibrary(file);
        }
        ;

    HeaderVariables:
        VAR
        | VAR Variables
        ;

    Variables:
        IDENTIFIER COLON Type SEMICOLON {
          printf("%s\n", $3);
          writeSimpleVariable(file, $1, $3);
        }
        ;

    Type:
        INTEGER_TYPE
        | CHAR_TYPE
        | REAL_TYPE
        ;

    FirstBegin:
        BEGIN_STATEMENT {writeMain(file);} END POINT { writeEndMain(file);closeOutputFile();}
        | BEGIN_STATEMENT {writeMain(file);} Body END POINT { writeEndMain(file);closeOutputFile();}
        ;

    Body:
        WriteFunctions
        | WriteFunctions Body
        | Aritmetic
        | Aritmetic Body
        | LoopStatement
        | LoopStatement Body
        ;
    WriteFunctions:
        WRITE LEFT_PARENTHESIS STRING RIGHT_PARENTHESIS SEMICOLON {
            writeSimplePrint(file, $3);
        }
        |
        WRITELN LEFT_PARENTHESIS STRING RIGHT_PARENTHESIS SEMICOLON {
            writePrintLN(file, $3);
        }
        ;

    Number:
        NATURAL_NUMBER
        | REAL_NUMBER
        ;

    Operator:
        PLUS
        | MINUS
        | DIVIDE
        | TIMES
    ;

    Aritmetic:
        IDENTIFIER ASSIGNMENT Number Operator Number SEMICOLON{
          writeSimpleAritmetic(file, $1, $3, $4, $5);
          printf("variavel: %s\n", $1);
          printf("numero1: %s\n", $3);
          printf("operador: %s\n", $4);
          printf("numero2: %s\n", $5);
          }
        | IDENTIFIER ASSIGNMENT LEFT_PARENTHESIS Number PLUS Number RIGHT_PARENTHESIS SEMICOLON{
          writeSimpleAritmeticParenthesis(file, $1, $4, $5, $6);
          }
    ;

    LoopStatement:
        FOR IDENTIFIER ASSIGNMENT NATURAL_NUMBER TO NATURAL_NUMBER DO{
          printf("FOR:\n");
          printf("variavel: %s\n", $2);
          printf("numero1: %s\n", $4);
          printf(": %s\n", $6);
          writeForStructure(file, $2, $4, $6);
        }
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
