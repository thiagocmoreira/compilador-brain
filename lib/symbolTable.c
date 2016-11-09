#include "symbolTable.h"
#include "node.c"
#include <stdio.h>

SymbolTable *newSymbol(void) {
    SymbolTable* symbolTable = (SymbolTable*) malloc(sizeof(SymbolTable));

    symbolTable->root = NULL;
    symbolTable->size = 0;

    return symbolTable;
}
/*
void insertVariableOnTable(SymbolTable *symbolTable, Node *node){

    if(symbolTable == NULL){
        symbolTable = newSymbol();
        symbolTable->root = node;
    }else{
        if(symbolTable->root->variable == NULL){
            symbolTable->root =  node;
        }else{
            if(symbolTable->root->variable < variable){
                insertVariableOnTable(symbolTable->root->left, variable);
            }else{
                insertVariableOnTable(symbolTable->root->right, variable);
            }
        }
    }

}
*/
