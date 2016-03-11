/* driver.c
 *
 * Dan Wilder
 * 11 March 2016
 */

#include <stdio.h>
#include "tree.h"
#include "lex_yacc.h"

tree root;

/*****************************************************************************
 * main
 ****************************************************************************/
int main() {
    int tok; 
    
    while((tok = yylex()) != 0) {
        printf("%d\t%s\n", tok, yytext);
    }

    return 0;
}
