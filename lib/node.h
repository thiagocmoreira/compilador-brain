#include "variable.h"

typedef struct NodeStruct {

  Variable* variable;
  struct NodeStruct* left;
  struct NodeStruct* right;

}Node;

Node *newNode(Variable* variable);

void insertVariableOnNode(Node *node, Variable *variable);

void insertArrayVariableOnNode(ListVariable *listVariable, char *type, Node *node);

void destroyNode(Node* node);
