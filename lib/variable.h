typedef struct VariableStruct{

    char *name;
    char *type;

}Variable;

Variable *newVariable(const char *name, const char *type);
