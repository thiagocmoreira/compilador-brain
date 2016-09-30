%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern char* yytext;
    extern int lineCounter;
%}

//token declarations
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
    %token IDENTIFIER
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
        HEADER {} END POINT
        ;

    HEADER:
        PROGRAM IDENTIFIER SEMICOLON
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
