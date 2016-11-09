#include <stdlib.h>
#include <string.h>
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


unsigned int addVariableToNodeArray(Node* node, Variable* array, unsigned int index) {

    if(node != NULL){
      if(node->left != NULL){
          index = addVariableToNodeArray(node->left, array, index);
      }

      array[index] = *node->variable;
      index += 1;

      if(node->right != NULL){
          index = addVariableToNodeArray(node->right, array, index);
      }
    }

    return index;

}
