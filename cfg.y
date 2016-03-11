/*    cfg.y
 *
 *    Dan Wilder
 *    11 March 2016
 */
%{
#include <stdlib.h>
#include "tree.h"
#include "lex_yacc.h"
extern tree root;
%}

%union { tree p; int i; char * s;}

%token<s>  Ident IntConst 
%token<s>  Boolean Integer True False
%token<s>  And Array Begin Declare Else Elsif End Exit 
%token<s>  For If In Is Loop Mod Not Of Or Procedure
%token<s>  Then When While Xor
%token<s>  Eq NEq Lt Lte Gt Gte Plus Minus Star Slash
%token<s>  LParen RParen LSqBrack RSqBrack Assign DoubleDot 
%token<s>  Semicolon Colon Comma 

%start  program

%type <p> program decls declaration id_list type const_range stmts statement range
%type <p> ref end_if bool_expr expr relation sum sign prod factor basic

%%
program
    : Procedure Ident Is decls Begin stmts End Semicolon
        {root = build_tree($1, build_int_tree("Ident", $2), $4, $6); }
    ;

decls
    : /* empty */
        { $$ = NULL;}
    | declaration Semicolon decls
        { $$ = build_tree($2, $1, $3, NULL);}
    ;

declaration
    : id_list Colon type 
        { $$ = build_tree($2, $1, $3, NULL);}
    ;

id_list
    : Ident 
        { $$ = build_int_tree("Ident", $1);}
    | Ident Comma id_list
        { $$ = build_tree($2, build_int_tree("Ident", $1), $3, NULL);}
    ;

type 
    : Integer
        { $$ = build_int_tree($1, $1);}
    | Boolean
        { $$ = build_int_tree($1, $1);}
    | Array LSqBrack const_range RSqBrack Of type
        { $$ = build_tree($1, $3, $6, NULL);}
    ;

const_range
    : IntConst DoubleDot IntConst
        { $$ = build_tree($2, build_int_tree("IntConst", $1), build_int_tree("IntConst", $3), NULL);}
    ;

stmts
    : /* empty */
        { $$ = NULL;}
    | statement Semicolon stmts
        { $$ = build_tree($2, $1, $3, NULL);}
    ;

statement
    : ref Assign expr
        { $$ = build_tree($2, $1, $3, NULL);}
    | Declare decls Begin stmts End
        { $$ = build_tree($1, $2, $4, NULL);}
    | For Ident In range Loop stmts End Loop
        { $$ = build_tree($1, build_int_tree("Ident", $2), $4, $6);}
    | Exit
        { $$ = build_int_tree($1, $1);}
    | Exit When bool_expr
        { $$ = build_tree($1, $3, NULL, NULL);}
    | If bool_expr Then stmts end_if
        { $$ = build_tree($1, $2, $4, $5);}
    ;

bool_expr
    : True
        { build_int_tree($1, $1);}
    | False
        { build_int_tree($1, $1);}
    ;

range
    : sum DoubleDot sum
        { $$ = build_tree($2, $1, $3, NULL);}
    ;

ref
    : Ident
        {$$ = build_int_tree("Ident", $1);}
    | Ident LSqBrack expr RSqBrack
        { $$ = build_tree($1, build_int_tree("Ident", $1), $3, NULL);}
    ;

end_if
    : End If
        { $$ = NULL;}
    | Else stmts End If
        { $$ = build_tree($1, $2, NULL, NULL);}
    | Elsif bool_expr Then stmts end_if
        { $$ = build_tree($1, $2, $4, $5);}
    ;

expr
    : relation Or relation
        { $$ = build_tree($2, $1, $3, NULL);}
    | relation And relation
        { $$ = build_tree($2, $1, $3, NULL);}
    | relation Xor relation
        { $$ = build_tree($2, $1, $3, NULL);}
    | relation
        { $$ = $1;}
    ;

relation
    : sum
        { $$ = $1;}
    | sum Eq sum
        { $$ = build_tree($2, $1, $3, NULL);}
    | sum NEq sum
        { $$ = build_tree($2, $1, $3, NULL);}
    | sum Lt sum
        { $$ = build_tree($2, $1, $3, NULL);}
    | sum Lte sum
        { $$ = build_tree($2, $1, $3, NULL);}
    | sum Gt sum
        { $$ = build_tree($2, $1, $3, NULL);}
    | sum Gte sum
        { $$ = build_tree($2, $1, $3, NULL);}
    ;

sum
    : sign prod
        { $$ = build_tree("sign-prod", $1, $2, NULL);}
    | sum Plus prod
        { $$ = build_tree($2, $1, $3, NULL);}
    | sum Minus prod
        { $$ = build_tree($2, $1, $3, NULL);}
    ;

sign
    : Plus
        { $$ = build_int_tree($1, $1);}
    | Minus
        { $$ = build_int_tree($1, $1);}
    | /* empty */
        {$$=NULL; }
    ;

prod
    : factor
        { $$ = $1;}
    | prod Star factor
        { $$ = build_tree($2, $1, $3, NULL);}
    | prod Slash factor
        { $$ = build_tree($2, $1, $3, NULL);}
    | prod Mod factor
        { $$ = build_tree($2, $1, $3, NULL);}
    ;

factor
    : Not basic
        { $$ = build_tree($1, $2, NULL, NULL);}
    | basic
        { $$ = $1;}
    ;

basic
    : ref
        { $$ = $1;}
    | LParen expr RParen
        { $$ = $2;}
    | IntConst
        { $$ = build_int_tree("IntConst", $1);}
    | True
        { $$ = build_int_tree($1, $1);}
    | False
        { $$ = build_int_tree($1, $1);}
    ;
%%
