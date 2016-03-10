/*    tree.c
 *
 *    Dan Wilder
 *    10 March 2016
 */

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"

/*****************************************************************************
 * build_tree
 *****************************************************************************/
tree build_tree(int kind, tree first, tree second, tree third) {

    tree build;
    build = (tree) malloc(sizeof(node));
  
    build->kind = kind;  
    build->first = first;
    build->second = second;
    build->third = third; 
   
    return build;
}

/******************************************************************************
 * build_int_tree
 *****************************************************************************/
tree build_int_tree(int kind, int val) {

    tree build;
    build = (tree) malloc(sizeof(node));
  
    build->kind = kind;  
    build->value = val;
   
    return build;
}

/******************************************************************************
 * print_tree
 *****************************************************************************/
void print_tree (tree root, int indent_level) {

    int i;

    if (root == NULL)
        return;

    for(i = 0; i < indent_level; ++i) 
        printf("    ");

    printf("kind: %d\n", root->kind); 

    print_tree(root->first, indent_level + 1);
    print_tree(root->second, indent_level + 1);
    print_tree(root->third, indent_level + 1);  
}
