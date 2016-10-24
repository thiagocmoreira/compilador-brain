#include "symbolTable.h"
#include <stdio.h>

SymbolTable *new(void) {
    SymbolTable* symbolTable = (SymbolTable*) malloc(sizeof(SymbolTable));

    symbolTable->root = NULL;
    symbolTable->size = 0;

    return symbolTable;
}

SymbolTable *addSymbol(Variable *variable){
    
}


void insertSymbolElement(SymbolTable *element, Variable *variable){



}
