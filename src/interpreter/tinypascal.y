%{
#include <cstdio>
#include <string>
#include "ast.h"

using namespace std;

extern int line;

int yylex();

void yyerror(const char *str)
{
    printf("Line %d: %s\n", line, str);
}

#define YYERROR_VERBOSE 1

Statement *input;

%}

%union {
    char *id_t;
    int  num_t;
    Statement *statement_t;
    Expr *expr_t;
    ExprList *exprlist_t;
}

%token<num_t> NUM
%token<id_t> ID
%token<id_t> STRING_LITERAL
%token KW_PROGRAM KW_BEGIN KW_END KW_WRITELN KW_IF KW_THEN KW_ELSE KW_WHILE KW_DO
%token OP_DIV OP_MOD OP_ASSIGN OP_LT OP_GT OP_LTE OP_GTE OP_NE
%type<expr_t> argument expra expr term factor 
%type<statement_t> list_st statement opt_else block
%type<exprlist_t> arg_list

%expect 1

%%

input: KW_PROGRAM ID ';'
       KW_BEGIN
            list_st
       KW_END '.'
       { input = $5; }
;

list_st: list_st statement { 
                        if ($1->getKind() == BLOCK_STATEMENT) {
                            BlockStatement *block = (BlockStatement*)$1;
                            
                            block->stList.push_back($2);
                            
                            $$ = block;
                        } else {
                            list<Statement *> l;
                            
                            l.push_back($1);
                            l.push_back($2);
                            
                            $$ = new BlockStatement(l);
                        }
                    }
                    
        | statement        { $$ = $1; }
;

statement: KW_WRITELN arg_list ';'    { $$ = new WritelnStatement(*$2); delete $2; }
    | ID OP_ASSIGN expr ';'   { 
                          string id = $1;
                          
                          free($1);
                          
                          $$ = new AssignStatement(id, $3);
                        }
    | KW_IF expr KW_THEN block opt_else    { $$ = new IfStatement($2, $4, $5); }
    | KW_WHILE expr KW_DO block { $$ = new WhileStatement($2, $4); }
;

arg_list: arg_list ',' argument {
	    $$ = $1;
	    $$->push_back($3);
	  }
	| argument { 
	    $$ = new ExprList;
	    $$->push_back($1);
	  }
;

argument: expr { $$ = $1; }
	| STRING_LITERAL {
	    string str = $1;
                            
	    free($1);
            $$ = new StringExpr(str);
	}
;

opt_else: KW_ELSE block    { $$ = $2; }
        |               { $$ = 0; }
;

block: KW_BEGIN list_st KW_END  { $$ = $2; }
      | statement	{ $$ = $1; }
;

expr: expr OP_LT expra  { $$ = new LTExpr($1, $3); }
    | expr OP_GT expra  { $$ = new GTExpr($1, $3); }
    | expr OP_LTE expra { $$ = new LTEExpr($1, $3); }
    | expr OP_GTE expra { $$ = new GTExpr($1, $3); }
    | expr OP_NE expra  { $$ = new NEExpr($1, $3); }
    | expr '=' expra    { $$ = new EQExpr($1, $3); }
    | expra             { $$ = $1; }
;

expra: expra '+' term   { $$ = new AddExpr($1, $3); }
    | expra '-' term    { $$ = new SubExpr($1, $3); }
    | term              { $$ = $1; }
;

term: term '*' factor      { $$ = new MultExpr($1, $3); }
    | term OP_DIV factor   { $$ = new DivExpr($1, $3); }
    | term OP_MOD factor   { $$ = new ModExpr($1, $3); }
    | factor            { $$ = $1; }
;

factor: '(' expr ')'    { $$ = $2; }
        | '-' factor    { $$ = new MultExpr(new NumExpr(-1), $2); }
        | NUM           { $$ = new NumExpr($1); }
        | ID            { 
                            string id = $1;
                            
                            free($1);
                            $$ = new IdExpr(id);
                        }
;

%%