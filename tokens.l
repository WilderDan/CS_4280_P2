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
and               {yylval.s = strdup(yytext); return And;}
array             {yylval.s = strdup(yytext); return Array;}
begin             {yylval.s = strdup(yytext); return Begin;}
declare           {yylval.s = strdup(yytext); return Declare;}
else              {yylval.s = strdup(yytext); return Else;}
elsif             {yylval.s = strdup(yytext); return Elsif;}
end               {yylval.s = strdup(yytext); return End;}
exit              {yylval.s = strdup(yytext); return Exit;}
for               {yylval.s = strdup(yytext); return For;}
if                {yylval.s = strdup(yytext); return If;}
in                {yylval.s = strdup(yytext); return In;}
is                {yylval.s = strdup(yytext); return Is;}
loop              {yylval.s = strdup(yytext); return Loop;}
mod               {yylval.s = strdup(yytext); return Mod;}
not               {yylval.s = strdup(yytext); return Not;}
of                {yylval.s = strdup(yytext); return Of;} 
or                {yylval.s = strdup(yytext); return Or;}
procedure         {yylval.s = strdup(yytext); return Procedure;}
then              {yylval.s = strdup(yytext); return Then;}
when              {yylval.s = strdup(yytext); return When;}
while             {yylval.s = strdup(yytext); return While;}
xor               {yylval.s = strdup(yytext); return Xor;}
BOOLEAN           {yylval.s = strdup(yytext); return Boolean;}
INTEGER           {yylval.s = strdup(yytext); return Integer;}
TRUE              {yylval.s = strdup(yytext); return True;}
FALSE             {yylval.s = strdup(yytext); return False;}
"="               {yylval.s = strdup(yytext); return Eq;}
"/="              {yylval.s = strdup(yytext); return NEq;}
"<"               {yylval.s = strdup(yytext); return Lt;}
"<="              {yylval.s = strdup(yytext); return Lte;}
">"               {yylval.s = strdup(yytext); return Gt;}
">="              {yylval.s = strdup(yytext); return Gte;}
"+"               {yylval.s = strdup(yytext); return Plus;}
"-"               {yylval.s = strdup(yytext); return Minus;}
"*"               {yylval.s = strdup(yytext); return Star;}
"/"               {yylval.s = strdup(yytext); return Slash;}
"("               {yylval.s = strdup(yytext); return LParen;}
")"               {yylval.s = strdup(yytext); return RParen;}
"["               {yylval.s = strdup(yytext); return LSqBrack;}
"]"               {yylval.s = strdup(yytext); return RSqBrack;}
":="              {yylval.s = strdup(yytext); return Assign;}
".."              {yylval.s = strdup(yytext); return DoubleDot;}
";"               {yylval.s = strdup(yytext); return Semicolon;}
":"               {yylval.s = strdup(yytext); return Colon;}
","               {yylval.s = strdup(yytext); return Comma;}
{L}({L}|{D}|"_")* {yylval.s = strdup(yytext); return Ident;}
{D}+              {yylval.s = strdup(yytext); return IntConst;}
.                 {yyerror ("Bad Character");}
%%
int yywrap (void) { return 1; }
void yyerror (char *s) {
    printf ("Error: %s at token %s in line %d\n", s, yytext, lineNum);
}
