/*    cfg.y
 *
 *    Dan Wilder
 *    10 March 2016
 */
%{
#include <stdlib.h>
#include "tree.h"
#include "lex_yacc.h"
extern tree root;
%}

%union { tree p; int i; char * s;}

%token <i> Ident 1 IntConst 2
%token <i> Boolean 11 Integer 12 True 13 False 14
%token <i> And 21 Array 22 Begin 23 Declare 24 Else 25 Elsif 26 End 27 Exit 28 
%token <i> For 29 If 30 In 31 Is 32 Loop 33 Mod 34 Not 35 Of 36 Or 37 Procedure 38
%token <i> Then 39 When 40 While 41 Xor 42
%token <i> Eq 51 NEq 52 Lt 53 Lte 54 Gt 55 Gte 56 Plus 57 Minus 58 Star 59 Slash 60
%token <i> LParen 61 RParen 62 LSqBrack 63 RSqBrack 64 Assign 65 DoubleDot 66 
%token <i> Semicolon 67 Colon 68 Comma 69

%start  program

%type <p> program decls declaration id_list type const_range stmts statement range
%type <p> ref end_if bool_expr expr relation sum sign prod factor basic

%%
program
    : Procedure Ident Is decls Begin stmts End Semicolon
        {root = build_tree(Procedure, build_int_tree(Ident, $2), $4, $6); }
    ;

decls
    : /* empty */
        { $$ = NULL;}
    | declaration Semicolon decls
        { $$ = build_tree(Semicolon, $1, NULL, NULL); $$->next=$3;}
    ;

declaration
    : id_list Colon type 
        { $$ = build_tree(Colon, $1, $3, NULL);}
    ;

id_list
    : Ident 
        { $$ = build_int_tree(Ident, $1);}
    | Ident Comma id_list
        { $$ = build_tree(Comma, build_int_tree(Ident, $1), NULL, NULL); $$->next=$3;}
    ;

type 
    : Integer
        { $$ = build_int_tree(Integer, $1);}
    | Boolean
        { $$ = build_int_tree(Boolean, $1);}
    | Array LSqBrack const_range RSqBrack Of type
        { $$ = build_tree(Array, $3, NULL, NULL); $$->next=$6;}
    ;

const_range
    : IntConst DoubleDot IntConst
        { $$ = build_tree(DoubleDot, build_int_tree(IntConst, $1), build_int_tree(IntConst, $3), NULL);}
    ;

stmts
    : /* empty */
        { $$ = NULL;}
    | statement Semicolon stmts
        { $$ = build_tree(Semicolon, $1, NULL, NULL); $$->next=$3;}
    ;

statement
    : ref Assign expr
        { $$ = build_tree(Assign, $1, $3, NULL);}
    | Declare decls Begin stmts End
        { $$ = build_tree(Declare, $2, $4, NULL);}
    | For Ident In range Loop stmts End Loop
        { $$ = build_tree(For, build_int_tree(Ident, $2), $4, $6);}
    | Exit
        { $$ = build_int_tree(Exit, $1);}
    | Exit When bool_expr
        { $$ = build_tree(Exit, $3, NULL, NULL);}
    | If bool_expr Then stmts end_if
        { $$ = build_tree(If, $2, $4, $5);}
    ;

bool_expr
    : True
        { build_int_tree(True, $1);}
    | False
        { build_int_tree(False, $1);}
    ;

range
    : sum DoubleDot sum
        { $$ = build_tree(DoubleDot, $1, $3, NULL);}
    ;

ref
    : Ident
        {$$ = build_int_tree(Ident, $1);}
    | Ident LSqBrack expr RSqBrack
        { $$ = build_tree(Ident, build_int_tree(Ident, $1), $3, NULL);}
    ;

end_if
    : End If
        { $$ = NULL;}
    | Else stmts End If
        { $$ = build_tree(Else, $2, NULL, NULL);}
    | Elsif bool_expr Then stmts end_if
        { $$ = build_tree(Elsif, $2, $4, NULL); $$->next=$5;}
    ;

expr
    : relation Or relation
        { $$ = build_tree(Or, $1, $3, NULL);}
    | relation And relation
        { $$ = build_tree(And, $1, $3, NULL);}
    | relation Xor relation
        { $$ = build_tree(Xor, $1, $3, NULL);}
    | relation
        { $$ = $1;}
    ;

relation
    : sum
        { $$ = $1;}
    | sum Eq sum
        { $$ = build_tree(Eq, $1, $3, NULL);}
    | sum NEq sum
        { $$ = build_tree(NEq, $1, $3, NULL);}
    | sum Lt sum
        { $$ = build_tree(Lt, $1, $3, NULL);}
    | sum Lte sum
        { $$ = build_tree(Lte, $1, $3, NULL);}
    | sum Gt sum
        { $$ = build_tree(Gt, $1, $3, NULL);}
    | sum Gte sum
        { $$ = build_tree(Gte, $1, $3, NULL);}
    ;

sum
    : sign prod
        { $$ = build_tree(0, $1, $2, NULL);}
    | sum Plus prod
        { $$ = build_tree(Plus, $1, $3, NULL);}
    | sum Minus prod
        { $$ = build_tree(Minus, $1, $3, NULL);}
    ;

sign
    : Plus
        { $$ = build_int_tree(Plus, $1);}
    | Minus
        { $$ = build_int_tree(Minus, $1);}
    | /* empty */
        {$$=NULL; }
    ;

prod
    : factor
        { $$ = $1;}
    | prod Star factor
        { $$ = build_tree(Star, $1, $3, NULL);}
    | prod Slash factor
        { $$ = build_tree(Slash, $1, $3, NULL);}
    | prod Mod factor
        { $$ = build_tree(Mod, $1, $3, NULL);}
    ;

factor
    : Not basic
        { $$ = build_tree(Not, $2, NULL, NULL);}
    | basic
        { $$ = $1;}
    ;

basic
    : ref
        { $$ = $1;}
    | LParen expr RParen
        { $$ = $2;}
    | IntConst
        { $$ = build_int_tree(IntConst, $1);}
    | True
        { $$ = build_int_tree(True, 1);}
    | False
        { $$ = build_int_tree(False, 0);}
    ;
%%
