#include "variable.h"

typedef struct Symbol_Table{

    Node *root;
    size_t size;

}SymbolTable;

Node* SymbolTableSearchNode(SymbolTable* simbol_table, char* name);

SymbolTable *new(void);

Variable* SymbolTable_find(SymbolTable* simbol_table, char* name);

int SymbolTable_insert_variable(SymbolTable* simbol_table, Variable* variable);

int SymbolTable_insert(SymbolTable* simbol_table, char* name, char* type);

void SymbolTable_destroy(SymbolTable* simbol_table);

Variable* SymbolTable_get_variables_as_array(SymbolTable* simbol_table);
