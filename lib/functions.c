#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ListVariable_{
    char *name;
    char *type;
    struct ListVariable_ *next;
}ListVariable;
char *type;
ListVariable *rootVariable = NULL;

void insertVariableOnList(const char* name){
    if(rootVariable == NULL){
        rootVariable = (ListVariable*)malloc(sizeof(ListVariable));
        rootVariable->name = name;
        rootVariable->next = NULL;
    }else{
        ListVariable *aux = rootVariable;
        while(aux->next != NULL){
            aux = aux->next;
        }
        aux->next = (ListVariable*)malloc(sizeof(ListVariable));
        aux = aux->next;
        aux->name = name;
        aux->next = NULL;
    }

}

void writeIntoFile(FILE* file, const char* content) {
    if (file != NULL) {
        fprintf(file, "%s", content);
    } else {
        exit(0);
    }
}

void writeLibrary(FILE *file){
    writeIntoFile(file, "#include <stdio.h>\n#include <stdlib.h>\n#include <math.h>\n#include <string.h>\n\n");
}
void writeMain(FILE *file){
    writeIntoFile(file, "int main(int argc, char **argv){\n");
}
void writeEndMain(FILE *file){
    writeIntoFile(file, "\n\n\treturn 0;\n}\n");
}

void writeSimplePrint(FILE *file, const char *string){
    char print[60] = "";
    strcat(print, "\n\tprintf(\"");
    strcat(print, string);
    strcat(print, "\");");
    writeIntoFile(file, print);
}
void writePrintLN(FILE *file, const char *string){
    char print[60] = "";
    strcat(print, "\n\tprintf(\"");
    strcat(print, string);
    strcat(print, "\\n\");");
    writeIntoFile(file, print);
}

void writeSimpleVariable(FILE *file, const char *name, const char *type){
    char print[60] = "";
    strcat(print, type);
    strcat(print, " ");
    strcat(print, name);
    strcat(print, ";\n");
    writeIntoFile(file, print);
}

void printListVariables(FILE *file){
    if(rootVariable != NULL){
        writeIntoFile(file, rootVariable->name);
        ListVariable *aux = rootVariable;
        while(aux->next != NULL){
            writeIntoFile(file, ", ");
            aux = aux->next;
            writeIntoFile(file, aux->name);
        }
    }else{
        // nothing to do
    }
    writeIntoFile(file, ";\n\t");
}

void writeVariables(FILE *file){
    char print[20] = "";
    strcat(print, "\n\t");
    strcat(print, rootVariable->type);
    strcat(print, " ");
    writeIntoFile(file, print);
    printListVariables(file);
}

void writeSimpleAritmetic(FILE *file, char *name, char *number1, char *operator, char *number2){
    char print[80] = "";
    strcat(print, "\n\t");
    strcat(print, name);
    strcat(print, " = ");
    strcat(print, number1);
    strcat(print, " ");
    strcat(print, operator);
    strcat(print, " ");
    strcat(print, number2);
    strcat(print, ";\n");
    writeIntoFile(file, print);
}

void writeSimpleAritmeticParenthesis(FILE *file, char *name, char *number1, char *operator, char *number2){
    char print[80] = "";
    strcat(print, "\n\t");
    strcat(print, name);
    strcat(print, " = ");
    strcat(print, "( ");
    strcat(print, number1);
    strcat(print, " ");
    strcat(print, operator);
    strcat(print, " ");
    strcat(print, number2);
    strcat(print, " )");
    strcat(print, ";\n");
    writeIntoFile(file, print);
}

void writeForStructure(FILE *file, const char *variable, const char *number1, const char *number2){
    char print[300] = "";
    strcat(print, "\n\t");
    strcat(print, "for( ");
    strcat(print, variable);
    strcat(print, " = ");
    strcat(print, number1);
    strcat(print, "; ");
    strcat(print, variable);
    strcat(print, " <= ");
    strcat(print, number2);
    strcat(print, "; ");
    strcat(print, variable);
    strcat(print, "++ ){");
    writeIntoFile(file, print);
}

void writeWhileStructure(FILE *file, const char *variable, const char *comparator, const char *number){
    char print[300] = "";
    strcat(print, "\n\t");
    strcat(print, "while( ");
    strcat(print, variable);
    strcat(print, " ");
    strcat(print, comparator);
    strcat(print, " ");
    strcat(print, number);
    strcat(print, " ){");
    writeIntoFile(file, print);
}

void writeDoWhileStructure(FILE *file, const char *variable, const char *comparator, const char *number){
    char print[300] = "";
    strcat(print, "\n\t");
    strcat(print, "}while( ");
    strcat(print, variable);
    strcat(print, " ");
    strcat(print, comparator);
    strcat(print, " ");
    strcat(print, number);
    strcat(print, " );");
    writeIntoFile(file, print);
}

void writeCondition(FILE *file, const char *identifier1, const char *comparator, const char *identifier2){
    char print[100] = "";
    strcat(print, " ");
    strcat(print, identifier1);
    strcat(print, " ");
    strcat(print, comparator);
    strcat(print, " ");
    strcat(print, identifier2);
    strcat(print, " ");
    writeIntoFile(file, print);
}
