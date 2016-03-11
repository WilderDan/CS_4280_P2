/*    cfg.y
 *
 *    Dan Wilder
 *    10 March 2016
 */
%{
#include "tree.h"

extern tree root;
%}

%union { tree p; int i; }

%token <i> Ident 1 IntConst 2
%token Boolean 11 Integer 12 True 13 False 14
%token And 21 Array 22 Begin 23 Declare 24 Else 25 Elsif 26 End 27 Exit 28 
%token For 29 If 30 In 31 Is 32 Loop 33 Mod 34 Not 35 Of 36 Or 37 Procedure 38
%token Then 39 When 40 While 41 Xor 42
%token Eq 51 NEq 52 Lt 53 Lte 54 Gt 55 Gte 56 Plus 57 Minus 58 Star 59 Slash 60
%token LParen 61 RParen 62 LSqBrack 63 RSqBrack 64 Assign 65 DoubleDot 66 
%token Semicolon 67 Colon 68 Comma 69

%start  program

%type <p> program decls declaration id_list type const_range stmts statement range
%type ref end_if expr relation sum sign prod factor basic

%%
program
    : Procedure Ident Is decls Begin stmts End Semicolon
        {root = buildTree(Procedure, $2, $4, $6);}
    ;

decls
    : /* empty */
        { $$ = NULL;}
    | declaration Semicolon decls
        { }
    ;

declaration
    : id_list Colon decls 
        { }
    ;

id_list
    : Ident 
        { }
    | Ident Comma id_list
        { }
    ;

type 
    : Integer
        { }
    | Boolean
        { }
    | Array LSqBrack const_range RSqBrack Of type
        { }
    ;

const_range
    : IntConst DoubleDot IntConst
        { }
    ;

stmts
    : /* empty */
        { $$ = NULL;}
    | statement Semicolon stmts
        { }
    ;

statement
    : ref Assign expr
        { }
    | Declare decls Begin stmts End
        { }
    | For Ident In range Loop stmts End Loop
        { }
    | Exit
        { }
    | Exit When bool_expr
        { }
    | If bool_expr Then stmts end_if
        { }
    ;

range
    : sum DoubleDot sum
        { }
    ;

ref
    : Ident
        { }
    | Ident LSqBrack expr RSqBrack
        { }
    ;

end_if
    : End If
        { }
    | Else stmts End If
        { }
    | Elsif bool_expr Then stmts end_if
        { }
    ;

expr
    : relation Or relation
        { }
    | relation And relation
        { }
    | relation Xor relation
        { }
    | relation
        { }
    ;

relation
    : sum
        { }
    | sum Eq sum
        { }
    | sum NEq sum
        { }
    | sum Lt sum
        { }
    | sum Lte sum
        { }
    | sum Gt sum
        { }
    | sum Gte sum
        { }
    ;

sum
    : sign prod
        { }
    | sum Plus prod
        { }
    | sum Minus prod
        { }
    ;

sign
    : Plus
        { }
    | Minus
        { }
    | /* empty */
        {$$=NULL; }
    ;

prod
    : factor
        { }
    | prod Star factor
        { }
    | prod Slash factpr
        { }
    | prod Mod factor
        { }
    ;

factor
    : Not basic
        { }
    | basic
        { }
    ;

basic
    : ref
        { }
    | LParen expr RParen
        { }
    | IntConst
        { }
    | True
        { }
    | False
        { }
    ;
%%
