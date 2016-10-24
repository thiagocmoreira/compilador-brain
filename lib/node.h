#include "variable.h"

typedef struct NodeStruct {

  Variable* variable;
  struct NodeStruct* left;
  struct NodeStruct* right;

}Node;

Node *newNode(Variable* variable);

void destroyNode(Node* node);

unsigned int addVariableToNodeArray(Node* node, Variable* array, unsigned int index);
