typedef struct VariableStruct{

    char *name;
    char *type;
    unsigned int line;

}Variable;

Variable *newVariable(const char *name, const char *type);
