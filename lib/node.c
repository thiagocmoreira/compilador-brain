#include <stdlib.h>
#include <string.h>
#include "functions.c"
#include "node.h"


Node* newNode(Variable* variable) {

    Node* node = (Node*)malloc(sizeof(Node));

    node->variable = variable;
    node->left = NULL;
    node->right = NULL;

    return node;

}


Node *insertVariableOnNode(Node *node, Variable *variable){

    if(node == NULL){
        node = newNode(variable);
    }else{
        int compare = strcmp(node->variable->type, variable->type);
        if(compare == 0){
            node->left = insertVariableOnNode(node->left, variable);
        }else{
            node->right = insertVariableOnNode(node->right, variable);
        }
    }
    return node;
}

Node *insertArrayVariableOnNode(ListVariable *listVariable, char *type, Node *node, const int line){

    ListVariable *aux = listVariable;

    while(aux != NULL){
        Variable *variable = (Variable*)malloc(sizeof(Variable));
        variable->name = aux->name;
        variable->line = line;
        variable->type = type;
        aux = aux->next;
        node = insertVariableOnNode(node, variable);
    }
    return node;

}

Variable *searchVariableOnNode(Node *node, char *name){

    if(node != NULL){
        int compare = strcmp(node->variable->name, name);
        if(!compare){
            return node->variable;
        }else{
            Variable *variableFound = NULL;
            variableFound = searchVariableOnNode(node->left, name);
            if(!variableFound){
                variableFound = searchVariableOnNode(node->right, name);
            }else{
                // nothing to do
            }
            return variableFound;
        }
    }else{
        // nothing to do
    }

    return NULL;

}

void showNode(Node *node){


    if(node != NULL){

        showNode(node->left);
        printf("........................\n");
        printf("Name: %s.\nType: %s.\nDeclared on line: %d.\n", node->variable->name, node->variable->type, node->variable->line);
        showNode(node->right);

    }else{
        // nothing to do
    }

}

void insertVariablesOnFile(FILE *file, Node *node, char *type){

    if(node != NULL){
        insertVariablesOnFile(file, node->left, type);
        char print[40] = "";
        strcat(print, "\n\t");
        strcat(print, node->variable->type);
        strcat(print, " ");
        strcat(print, node->variable->name);
        strcat(print, ";");
        writeIntoFile(file, print);
        insertVariablesOnFile(file, node->right, type);
    }else{
        // nothing to do
    }

}

void writeVariablesOnFile(FILE *file, Node *node){

    insertVariablesOnFile(file, node, node->variable->type);
    writeIntoFile(file, "\n");

}

void checkingVariableBeforeInsert(Node *node, Variable *variableExists, const int lineCounter, char *name){
    if(node == NULL){
        if(searchVariableOnList(name)){
            printf("Error: Line %d. Variable '%s' already exists.\n", lineCounter, name);
        }else{
            insertVariableOnList(name);
        }
    }else{
        variableExists = searchVariableOnNode(node, name);
        if(variableExists != NULL || searchVariableOnList(name)){
            printf("Error: Line %d. Variable '%s' already exists.\n", lineCounter, name);
        }else{
            insertVariableOnList(name);
        }
    }
}

void checkingVariableExistence(Node *node, Variable *variableExists, const int lineCounter, char *name, FILE *file){

    variableExists = searchVariableOnNode(node, name);
    if(variableExists == NULL){
        printf("Error: Line %d. \'%s\' was not declarated on this scope.\n", lineCounter, name);
    }else{
        insertVariableOnList(name);
        if(!strcmp(variableExists->type, "int")){
            writeIntoFile(file, " %d ");
        }else if(!strcmp(variableExists->type, "float")){
            writeIntoFile(file, " %f ");
        }else{
            writeIntoFile(file, " %c ");
        }
    }
}

void writeVariableTypesForPrint(FILE *file, unsigned const int scan){

    if(rootVariable != NULL){
        ListVariable *aux = rootVariable;
        while(aux != NULL){
            if(scan){
                writeIntoFile(file, "&");
            }else{
                // nothing to do
            }
            writeIntoFile(file, aux->name);
            if(aux->next != NULL){
                writeIntoFile(file, ", ");
            }else{
                // nothing to do
            }
            aux = aux->next;
        }
        freeList();
    }else{
        //nothing to do
    }
}

void destroyNode(Node *node){

    if(node !=NULL){

        destroyNode(node->left);
        destroyNode(node->right);

        free(node);
        node = NULL;

    }else{
        // nothing to do
    }

}
