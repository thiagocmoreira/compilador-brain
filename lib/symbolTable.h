#include "variable.h"

typedef struct Symbol_Table{

    Node *root;
    size_t size;

}SymbolTable;

SymbolTable *newSymbol(void);

void insertVariableOnTable(SymbolTable *symbol, Variable *variable);
