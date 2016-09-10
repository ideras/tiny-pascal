#include <cstdio>
#include "ast.h"

map<string, int> vars;

void BlockStatement::execute()
{
    list<Statement *>::iterator it = stList.begin();
    
    while (it != stList.end()) {
        Statement *st = *it;
        
        st->execute();
        it++;
    }   
}

void WritelnStatement::execute() 
{
  list<Expr *>::iterator it = lexpr.begin();
  
  while (it != lexpr.end()) {
    Expr *expr = *it;
    
    if (expr->isA(STRING_EXPR)) {
      printf("%s", ((StringExpr*)expr)->str.c_str());
    } else {
      int result = expr->evaluate();
      printf("%d", result);
    }
    
    it++;
  }
  printf("\n");    
}

void AssignStatement::execute()
{
    int result = expr->evaluate();
    vars[id] = result;
}

void IfStatement::execute()
{
    int result = cond->evaluate();
    
    if (result) {
        trueBlock->execute();
    } else if (falseBlock != 0) {
        falseBlock->execute();
    }
}

void WhileStatement::execute()
{
  int result = cond->evaluate();
  
  while (result) {
    block->execute();
    
    result = cond->evaluate();
  }
}