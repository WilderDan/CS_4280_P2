/*    tree.h
 *
 *    Dan Wilder
 *    10 March 2016
 */
typedef struct Node {
        int     kind, value;
        struct  Node *first, *second, *third, *next;
} node;
typedef node *tree;

tree build_tree (int kind, tree first, tree second, tree third);
tree build_int_tree (int kind, int val);
void print_tree (tree, int indent_level);
