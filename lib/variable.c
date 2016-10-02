#include <stdio.h>
#include "variable.h"


Variable *newVariable(const char *name, const char *type){
    Variable createdVariable = (Variable *)malloc(sizeof(Variable));

    createdVariable->name = name;
    createdVariable->type = type;

    return createdVariable;
}
