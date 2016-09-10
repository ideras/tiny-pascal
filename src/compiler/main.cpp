#include <cstdio>
#include "ast.h"
#include "tokens.h"

extern Statement *input;
int yyparse();

int main()
{
    input = 0;
    yyparse();
    
    if (input != 0) {
        //TODO: Generate .data section
		//TODO: Generate .text section
    }
}
