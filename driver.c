#include <stdlib.h>
#include "tree.h"

int main() {
    
    tree t1, t2, t3, t4, t5, root;

    t1 = build_tree(1, NULL, NULL, NULL);
    t2 = build_tree(2, NULL, NULL, NULL);
    t3 = build_tree(3, t1, t2, NULL);
    t4 = build_tree(4, t3, NULL, NULL);
    t5 = build_tree(5, NULL, NULL, NULL);
    root = build_tree(0, t4, t5, NULL);
 
    print_tree(root, 0);
}
