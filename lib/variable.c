#include <stdio.h>
#include "variable.h"


Variable *newVariable(const char *name, const char *type){
    Variable variable = (Variable *)malloc(sizeof(Variable));

    variable->name = name;
    variable->type = type;

    return variable;
}
