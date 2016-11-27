%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "global.h"
    #include "lib/symbolTable.c"

    extern int lineCounter;
    int tabulationCounter = 0; //variable to count how many tabulations we need to do to correct print on file

    SymbolTable *symbolTable = NULL;
    Node *node = NULL;
    Variable *variableExists = NULL;

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
    %token <strval> COMPARATORS
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
    %token <strval> REPEAT
    %token THEN
    %token <strval> TO
    %token TYPE
    %token TRUE
    %token UNTIL
    %token VAR
    %token WHILE
    %token WRITE
    %token WRITELN
    %token READ
    %token READLN
    %token <strval> REAL_TYPE
    %token SIMPLE_WORD
    %token <strval> IDENTIFIER
    %token <strval> STRING
    %token <strval> NATURAL_NUMBER
    %token <strval> REAL_NUMBER
    %token POINT
    %token VIRGULA
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
    %token <strval> DOUBLE_SLASH
    %token <strval> OPENING_COMMENT
    %token <strval> CLOSING_COMMENT
    %token <strval> OPENING_BRACE
    %token <strval> CLOSING_BRACE
    %token <strval> STRING_TYPE

    %type <strval> Variables
    %type <strval> Type
    %type <strval> Number
    %type <strval> Operator
    %type <strval> Aritmetic
    %type <strval> LoopStatement
    %type <strval> StringValue
    %type <strval> Comment

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
        PROGRAM IDENTIFIER SEMICOLON {
            openOutputFile($2);
            writeLibrary(file);
        }
        ;

    HeaderVariables:
        VAR
        | VAR Variables
        ;


    Variables:
        IDENTIFIER  {
            checkingVariableBeforeInsert(node, variableExists, lineCounter, $1);
        } VIRGULA Variables
        | IDENTIFIER {
            checkingVariableBeforeInsert(node, variableExists, lineCounter, $1);
        } COLON Type {

            node = insertArrayVariableOnNode(rootVariable, $4, node);
            if(node == NULL){
                printf("Error: Impossible to create node variables. Node is empty.\n");
            }
            freeList(); //correct implementation

        } SEMICOLON Variables
        | /* do nothing */
        ;

    Type:
        INTEGER_TYPE
        | CHAR_TYPE
        | REAL_TYPE
        ;

    FirstBegin:
        BEGIN_STATEMENT {writeMain(file);} END POINT { writeEndMain(file);closeOutputFile();}
        | BEGIN_STATEMENT {writeMain(file);} {
            if(node != NULL){
                writeVariablesOnFile(file, node);
            }else{
                // nothing to do
            }
        } Body END POINT { writeEndMain(file);closeOutputFile();}
        ;

    Body:
        WriteFunctions
        | WriteFunctions Body
        | ReadFunctions
        | ReadFunctions Body
        | Aritmetic
        | Aritmetic Body
        | LoopStatement
        | LoopStatement Body
        | ConditionalStatement
        | ConditionalStatement Body
        | Comment
        | Comment Body
        ;

    WriteFunctions:
        WRITE LEFT_PARENTHESIS STRING RIGHT_PARENTHESIS SEMICOLON {
            tabulationCounter++;
            writeSimplePrint(file, $3, tabulationCounter);
            tabulationCounter--;
        }
        |
        WRITELN LEFT_PARENTHESIS STRING RIGHT_PARENTHESIS SEMICOLON {
            tabulationCounter++;
            writePrintLN(file, $3, tabulationCounter);
            tabulationCounter--;
        }
        ;

    ReadFunctions:
        READ {tabulationCounter++; writeTabulation(file, tabulationCounter); writeIntoFile(file, "scanf(\""); tabulationCounter--;} LEFT_PARENTHESIS ReadPossibilities {
            writeIntoFile(file, "\", ");
            if(rootVariable != NULL){
                ListVariable *aux = rootVariable;
                while(aux != NULL){
                    writeIntoFile(file, "&");
                    writeIntoFile(file, aux->name);
                    if(aux->next != NULL){
                        writeIntoFile(file, ", ");
                    }else{
                        // nothing to do
                    }
                    aux = aux->next;
                }
                freeList();
            }else{
                //nothing to do
            }
        } RIGHT_PARENTHESIS SEMICOLON {tabulationCounter++; writeTabulation(file, tabulationCounter); writeIntoFile(file, ");\n"); tabulationCounter--;}
        | READLN LEFT_PARENTHESIS ReadPossibilities {
            writeIntoFile(file, "\", ");
            if(rootVariable != NULL){
                ListVariable *aux = rootVariable;
                while(aux != NULL){
                    writeIntoFile(file, "&");
                    writeIntoFile(file, aux->name);
                    if(aux->next != NULL){
                        writeIntoFile(file, ", ");
                    }else{
                        // nothing to do
                    }
                    aux = aux->next;
                }
                freeList();
            }else{
                //nothing to do
            }
        } RIGHT_PARENTHESIS SEMICOLON {writeIntoFile(file, ");\n");}
        ;

    ReadPossibilities:
        IDENTIFIER {
            variableExists = searchVariableOnNode(node, $1);
            if(variableExists == NULL){
                printf("Error: Line %d. \'%s\' was not declarated on this scope.\n", lineCounter, $1);
            }else{
                insertVariableOnList($1);
                if(!strcmp(variableExists->type, "int")){
                    writeIntoFile(file, " %d ");
                }else if(!strcmp(variableExists->type, "float")){
                    writeIntoFile(file, " %f ");
                }else{
                    writeIntoFile(file, " %c ");
                }
            }

        }
        | IDENTIFIER {
            variableExists = searchVariableOnNode(node, $1);
            if(variableExists == NULL){
                printf("Error: Line %d. \'%s\' was not declarated on this scope.\n", lineCounter, $1);
            }else{
                insertVariableOnList($1);
                if(!strcmp(variableExists->type, "int")){
                    writeIntoFile(file, " %d ");
                }else if(!strcmp(variableExists->type, "float")){
                    writeIntoFile(file, " %f ");
                }else{
                    writeIntoFile(file, " %c ");
                }
            }

        } VIRGULA ReadPossibilities
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
            tabulationCounter++;
            writeSimpleAritmetic(file, $1, $3, $4, $5, tabulationCounter);
            tabulationCounter--;
        }
        | IDENTIFIER ASSIGNMENT LEFT_PARENTHESIS Number PLUS Number RIGHT_PARENTHESIS SEMICOLON{
            tabulationCounter++;
            writeSimpleAritmeticParenthesis(file, $1, $4, $5, $6, tabulationCounter);
            tabulationCounter--;
          }
        ;

    LoopStatement:
        FOR IDENTIFIER ASSIGNMENT NATURAL_NUMBER TO NATURAL_NUMBER DO {
            tabulationCounter++;
            writeForStructure(file, $2, $4, $6, tabulationCounter);
            tabulationCounter--;
        }
        BEGIN_STATEMENT {tabulationCounter++; writeTabulation(file, tabulationCounter); tabulationCounter--;} Body END SEMICOLON {
            tabulationCounter++;
            writeTabulation(file, tabulationCounter);
            writeIntoFile(file, "}");
            writeLineBreak(file, 2);
            tabulationCounter--;
        }
        | WHILE IDENTIFIER COMPARATORS Number DO {
            tabulationCounter++;
            writeWhileStructure(file, $2, $3, $4, tabulationCounter);
            tabulationCounter--;
        }
        BEGIN_STATEMENT {tabulationCounter++; writeTabulation(file, tabulationCounter); tabulationCounter--;} Body END SEMICOLON {
            tabulationCounter++;
            writeTabulation(file, tabulationCounter);
            writeIntoFile(file, "}");
            writeLineBreak(file, 1);
            tabulationCounter--;
        }
        | REPEAT {
            tabulationCounter++;
            writeTabulation(file, tabulationCounter);
            writeIntoFile(file, "do{\n");
        } Body UNTIL IDENTIFIER COMPARATORS Number SEMICOLON {
            writeDoWhileStructure(file, $5, $6, $7, tabulationCounter);
            tabulationCounter--;
        }
        ;

    ConditionalStatement:
        ConditionalBegin Body ConditionalEnd
        | ConditionalBegin ConditionalStatement ConditionalEnd
        ;

    ConditionalBegin:
        IF LEFT_PARENTHESIS {writeIntoFile(file, "\n\tif(" );} Condition
        RIGHT_PARENTHESIS {writeIntoFile(file, "){" );} THEN  {printf("if statement\n"); }
        ;

    ConditionalEnd:
        ELSE  {printf("else statement\n"); } Body ConditionalEnd
        |
        ;


    Condition:
        IDENTIFIER COMPARATORS Number {writeCondition(file, $1, $2, $3);}
        | IDENTIFIER COMPARATORS IDENTIFIER {writeCondition(file, $1, $2, $3);}
        ;

    Comment:
        OPENING_BRACE {writeIntoFile(file, "\n"); tabulationCounter++; writeTabulation(file, tabulationCounter); tabulationCounter--; writeIntoFile(file, "/* " ); }
        StringValue {writeIntoFile(file, $1); writeIntoFile(file, " ");} CLOSING_BRACE {writeIntoFile(file, "*/\n" );}
        | OPENING_COMMENT {writeIntoFile(file, "\n"); tabulationCounter++; writeTabulation(file, tabulationCounter); tabulationCounter--; writeIntoFile(file, "/* " );}
        StringValue CLOSING_COMMENT {writeIntoFile(file, "*/\n" );}
        | DOUBLE_SLASH {writeIntoFile(file, "\n"); tabulationCounter++; writeTabulation(file, tabulationCounter); tabulationCounter--; writeIntoFile(file, "// " );}
        StringValue {writeIntoFile(file, "\n" );}
        ;

    StringValue:
        | IDENTIFIER {writeIntoFile(file, $1);} EOL StringValue
        | IDENTIFIER {writeIntoFile(file, $1); writeIntoFile(file, " ");} StringValue
        | IDENTIFIER {writeIntoFile(file, $1); writeIntoFile(file, " ");}
        ;

%%
#include "lex.yy.c"
int yyerror (void){
	printf("Erro na Linha: %d\n", lineCounter);
}

//main function
int main(void){
    symbolTable = newSymbol();
    yyparse();

    return 0;
}
