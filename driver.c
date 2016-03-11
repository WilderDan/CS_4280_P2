/* driver.c
 *
 * Dan Wilder
 * 11 March 2016
 */

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"
#include "lex_yacc.h"

tree root;
FILE *yyin;

/*****************************************************************************
 * main
 ****************************************************************************/
int main(int argc, char **argv) {

    // Make sure command line argument was specified    
    if (argc < 2) {
        fprintf(stderr, "Usage: %s ada_file\n", argv[0]);
        exit(1); 
    }
   
    // Make sure file opened properly
    if ((yyin = fopen(argv[1], "r")) == NULL) {
        fprintf(stderr, "Error: fopen [%s]\n", argv[0]);
        exit(1);
    }

    /*
    int tok;
    while((tok = yylex()) != 0) {
        printf("%d\t%s\n", tok, yytext);
    }
    */

    // Magic
    yyparse();
    print_tree(root);

    return 0;
}
