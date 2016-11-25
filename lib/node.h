#include "variable.h"

typedef struct NodeStruct {

  Variable* variable;
  struct NodeStruct* left;
  struct NodeStruct* right;

}Node;

Node *newNode(Variable* variable);

Node *insertVariableOnNode(Node *node, Variable *variable);

Node *insertArrayVariableOnNode(ListVariable *listVariable, char *type, Node *node);

Variable *searchVariableOnNode(Node *node, char *name);

void insertVariablesOnFile(FILE *file, Node *node, char *type);

void writeVariablesOnFile(FILE *file, Node *node);

void destroyNode(Node* node);
