/*    tree.c
 *
 *    Dan Wilder
 *    11 March 2016
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tree.h"

static void print_tree_with_indents(tree root, int indent_level);

/*****************************************************************************
 * build_tree
 *****************************************************************************/
tree build_tree(char *kind, tree first, tree second, tree third) {

    tree build;
    build = (tree) malloc(sizeof(node));
  
    build->kind = kind;  
    build->first = first;
    build->second = second;
    build->third = third; 
   
    build->isList = (strcmp(build->kind, "decls") == 0 || 
		     strcmp(build->kind, "idlist") == 0 ||
                     strcmp(build->kind, "stmts")== 0 )? 1 : 0; 
    return build;
}

/******************************************************************************
 * build_int_tree
 *****************************************************************************/
tree build_int_tree(char *kind, char *val) {
    tree build;
    build = (tree) malloc(sizeof(node));
  
    build->kind = kind;  
    build->value = val;
    build->isList = 0; 
    return build;
}

/******************************************************************************
 * print_tree
 *****************************************************************************/
void print_tree(tree root) {
    print_tree_with_indents(root, 0);
}

/******************************************************************************
 * print_tree_with_indents
 *****************************************************************************
 * Exists as a separate function so that client code doesn't have to  
 * specify the indent parameter. This function is private to this file.
 * Client code should call 'print_tree' which calls this function.
 */
static void print_tree_with_indents(tree root, int indent_level) {

    int i, offset;

    if (root == NULL)
        return;

    if (root->isList || (strcmp(root->kind, "sign-prod") == 0 && root->first == NULL)) 
        offset = 0;
    else {
        offset = 1; 

        for (i = 0; i < indent_level; ++i)
            printf("  ");

        if (strcmp(root->kind, "Ident") == 0 || strcmp(root->kind, "IntConst") == 0)
            printf("%s %s\n", root->kind, root->value);
        else
            printf("%s\n", root->kind);
    }

    print_tree_with_indents(root->first, indent_level + offset);
    print_tree_with_indents(root->second, indent_level + offset);
    print_tree_with_indents(root->third, indent_level + offset);

    print_tree_with_indents(root->next, indent_level);
}
