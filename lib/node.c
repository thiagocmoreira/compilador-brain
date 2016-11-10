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


void insertVariableOnNode(Node *node, Variable *variable){
    if(node == NULL){
        node = newNode(variable);
    }else{
        if(node->variable->type < variable->type){
            insertVariableOnNode(node->left, variable);
        }else{
            insertVariableOnNode(node->right, variable);
        }
    }
}

void insertArrayVariableOnNode(ListVariable *listVariable, char *type, Node *node){

    ListVariable *aux = listVariable;

    while(aux->next != NULL){
        Variable *variable = (Variable*)malloc(sizeof(Variable));
        variable->name = aux->name;
        variable->type = type;
        insertVariableOnNode(node, variable);
        aux = aux->next;
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
