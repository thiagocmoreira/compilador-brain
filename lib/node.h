#include "variable.h"

typedef struct NodeStruct {

  Variable* variable;
  struct NodeStruct* left;
  struct NodeStruct* right;

}Node;

Node *newNode(Variable* variable);

Node *insertVariableOnNode(Node *node, Variable *variable);

Node *insertArrayVariableOnNode(ListVariable *listVariable, char *type, Node *node);

unsigned int searchVariableOnNode(Node *node, char *name);

void destroyNode(Node* node);
