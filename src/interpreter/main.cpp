#include <cstdio>
#include "ast.h"
#include "tokens.h"

extern Statement *input;

int main()
{
    input = 0;
    yyparse();
    
    if (input != 0) {
        input->execute();
    }
}
