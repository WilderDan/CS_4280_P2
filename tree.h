/*    tree.h
 *
 *    Dan Wilder
 *    11 March 2016
 */

typedef struct Node {
        char *kind, *value;
        int isList;
        struct  Node *first, *second, *third, *next;
} node;
typedef node *tree;

tree build_tree (char *kind, tree first, tree second, tree third);
tree build_int_tree (char *kind, char *val);
void print_tree (tree);
