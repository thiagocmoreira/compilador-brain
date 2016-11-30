#include "variable.h"

typedef struct NodeStruct {

  Variable* variable;
  struct NodeStruct* left;
  struct NodeStruct* right;

}Node;

Node *newNode(Variable* variable);

Node *insertVariableOnNode(Node *node, Variable *variable);

Node *insertArrayVariableOnNode(ListVariable *listVariable, char *type, Node *node, const int line);

Variable *searchVariableOnNode(Node *node, char *name);

void insertVariablesOnFile(FILE *file, Node *node, char *type);

void writeVariablesOnFile(FILE *file, Node *node);

void checkingVariableBeforeInsert(Node *node, Variable *variableExists, const int lineCounter, char *name);

void checkingVariableExistence(Node *node, Variable *variableExists, const int lineCounter, char *name, FILE *file);

void writeVariableTypesForPrint(FILE *file, unsigned const int scan);

void destroyNode(Node *node);
