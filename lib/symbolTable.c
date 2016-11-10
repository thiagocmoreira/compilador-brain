#include "symbolTable.h"
#include <stdio.h>

SymbolTable *newSymbol(void) {
    SymbolTable* symbolTable = (SymbolTable*) malloc(sizeof(SymbolTable));

    symbolTable->root = NULL;
    symbolTable->size = 0;

    return symbolTable;
}
