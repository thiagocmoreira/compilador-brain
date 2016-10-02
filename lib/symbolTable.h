typedef struct SymbolTable{

    Variable *createdVariable;
    SymbolTable *nextNode;

}symbolTable;


SymbolTable *newSymbol(Variable *var);

SymbleTable *searchElement(void); //dont think about parameters for this function

void insertSymbolElement(SymbolTable *element);

void destroyElement(SymbolTable *element);
