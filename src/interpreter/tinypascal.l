%option noyywrap

%{
#include <cstdlib>
#include <cstring>
#include "ast.h"
#include "tokens.h"

int line = 1;

%}

DIGIT [0-9]
LETTER [a-zA-Z]

%x comment1
%x comment2

%%

"=" { return '='; }
"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"(" { return '('; }
")" { return ')'; }
";" { return ';'; }
"." { return '.'; }
"," { return ','; }
":=" { return OP_ASSIGN; }
"<" { return OP_LT; }
">" { return OP_GT; }
"<=" { return OP_LTE; }
">=" { return OP_GTE; }
"<>" { return OP_NE; }
"{"  { BEGIN(comment1); }
"(*" { BEGIN(comment2); }
"'"[^']*"'" { yytext[yyleng-1] = '\0'; yylval.id_t = strdup(&yytext[1]); return STRING_LITERAL; }
<comment1>[\n]   { line++; }
<comment1>"}"    { BEGIN(INITIAL); }
<comment1>.      { /* NOTHING TO DO */ }
<comment2>[\n]   { line++; }
<comment2>"*)"    { BEGIN(INITIAL); }
<comment2>.      { /* NOTHING TO DO */ }
[ \t] /* Nada */
\n  { line++; }
"div" { return OP_DIV; }
"mod" { return OP_MOD; }
"program" { return KW_PROGRAM; }
"begin" { return KW_BEGIN; }
"end" { return KW_END; }
"writeln" { return KW_WRITELN; }
"if"    { return KW_IF; }
"then"  { return KW_THEN; }
"else"  { return KW_ELSE; }
"while" { return KW_WHILE; }
"do"    { return KW_DO; }
{DIGIT}+ { yylval.num_t = atoi(yytext); return NUM; }
{LETTER}({DIGIT}|{LETTER}|_)* { yylval.id_t = strdup(yytext); return ID; }
"//"[^\n]*
.   { printf("Line %d: Invalid symbol '%c'\n", line, yytext[0]); }

%%
