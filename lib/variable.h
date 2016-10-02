typedef struct Variable{
    char *name;
    char *type;

}variable;

Variable *newVariable(const char *name, const char *type);
