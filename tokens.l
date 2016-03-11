%{
/* tokens.l
 * 
 * Dan Wilder
 * 7 February, 2016
 * 
 * Token Specifications:
 *     http://www.cs.umsl.edu/~schulte/cs4280/pt12-proj.pdf
 */
#include <stdio.h>
#include "tree.h"
#include "y.tab.h"
void yyerror (char * s);
int lineNum=0;
%}
L                 [A-Za-z]
D                 [0-9]
%%
[ \t]+            {;}
[\n]              {lineNum++;}
and               {return And;}
array             {return Array;}
begin             {return Begin;}
declare           {return Declare;}
else              {return Else;}
elsif             {return Elsif;}
end               {return End;}
exit              {return Exit;}
for               {return For;}
if                {return If;}
in                {return In;}
is                {return Is;}
loop              {return Loop;}
mod               {return Mod;}
not               {return Not;}
of                {return Of;} 
or                {return Or;}
procedure         {return Procedure;}
then              {return Then;}
when              {return When;}
while             {return While;}
xor               {return Xor;}
BOOLEAN           {return Boolean;}
INTEGER           {return Integer;}
TRUE              {return True;}
FALSE             {return False;}
"="               {return Eq;}
"/="              {return NEq;}
"<"               {return Lt;}
"<="              {return Lte;}
">"               {return Gt;}
">="              {return Gte;}
"+"               {return Plus;}
"-"               {return Minus;}
"*"               {return Star;}
"/"               {return Slash;}
"("               {return LParen;}
")"               {return RParen;}
"["               {return LSqBrack;}
"]"               {return RSqBrack;}
":="              {return Assign;}
".."              {return DoubleDot;}
";"               {return Semicolon;}
":"               {return Colon;}
","               {return Comma;}
{L}({L}|{D}|"_")* {return Ident;}
{D}+              {return IntConst;}
.                 {yyerror ("Bad Character");}
%%
int yywrap (void) { return 1; }
void yyerror (char *s) {
    printf ("Error: %s at token %s in line %d\n", s, yytext, lineNum);
}
