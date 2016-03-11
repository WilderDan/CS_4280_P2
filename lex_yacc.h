/* lex_yacc.h
 *   
 * Dan Wilder
 * 7 February, 2016
 */

#pragma once 

extern char *yytext; 
int yylex (void);       
int yyparse(void); 
void yyerror(char *s);
