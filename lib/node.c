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

Node *insertArrayVariableOnNode(ListVariable *listVariable, char *type, Node *node){

    ListVariable *aux = listVariable;

    while(aux != NULL){
        Variable *variable = (Variable*)malloc(sizeof(Variable));
        variable->name = aux->name;
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
        // printf("Node->variable->name: %s\n", node->variable->name);
        char print[30] = "";
        strcat(print, node->variable->name);
        strcat(print, ", ");
        // printf("Node->variable->type: %s\n", node->variable->type);
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


void destroyNode(Node* node) {

    if(node != NULL){
        destroyNode(node->left);
        destroyNode(node->right);

        free(node->variable);
        node->variable = NULL;

        free(node);
        node = NULL;
    }

}
