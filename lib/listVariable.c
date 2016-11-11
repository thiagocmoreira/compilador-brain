#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ListVariable_{
    char *name;
    char *type;
    struct ListVariable_ *next;
}ListVariable;

ListVariable *rootVariable = NULL;

void insertVariableOnList(char* name){

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

void freeList(ListVariable *list){

    ListVariable *aux = list;
    
    while((aux = list) != NULL){
        printf("%s\n", list->name);
        list = list->next;
        free(aux);
    }

}
