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

unsigned int searchVariableOnNode(Node *node, char *name){

    unsigned int variableFound = 0;

    if(node != NULL){
        int compare = strcmp(node->variable->name, name);
        if(!compare){
            variableFound = 1;
            return variableFound;
        }else{
            variableFound = searchVariableOnNode(node->left, name);
            if(!variableFound){
                variableFound = searchVariableOnNode(node->right, name);
            }
        }
    }else{
        // nothing to do
    }

    return variableFound;

}

void showNode(Node *node){
    if(node != NULL){
        showNode(node->left);
        // printf("Node->variable->name: %s\n", node->variable->name);
        // printf("Node->variable->type: %s\n", node->variable->type);
        showNode(node->right);
    }else{
        // nothing to do
    }
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
