#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ListVariable_{
    char *name;
    struct ListVariable_ *next;
}ListVariable;

ListVariable *rootVariable = NULL;
char *variableType;

ListVariable *includeOnTail(ListVariable *root, char *name){

    ListVariable *aux, *new;

    new = (ListVariable*)malloc(sizeof(ListVariable));
    new->name = name;
    new->next = NULL;
    aux = root;
    while(aux->next != NULL){
        aux = aux->next;
    }
    aux->next = new;
    return root;

}

void insertVariableOnList(char* name){

    if(rootVariable == NULL){
        rootVariable = (ListVariable*)malloc(sizeof(ListVariable));
        rootVariable->name = name;
        rootVariable->next = NULL;
    }else{
        rootVariable = includeOnTail(rootVariable, name);
    }

}

void showList(){

    ListVariable *aux;
    aux = rootVariable;
    while(aux != NULL){
        printf("Nome da variável: %s\n", aux->name);
        aux = aux->next;
    }

}

void freeList(){

    ListVariable *aux = rootVariable;

    while((aux = rootVariable) != NULL){
        printf("%s\n", rootVariable->name);
        rootVariable = rootVariable->next;
        free(aux);
    }
    rootVariable = NULL;

}
