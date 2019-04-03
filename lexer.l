%{

#include "parser.tab.h"
void yyerror (char *s);
int yylex();
extern int lastValOfExpr;

%}

%%

"Print"				   	{return PRINT;}
"Add"				   	{return ADD;}
"with" 					{return WITH;}
"Substract"				{return SUBSTRACT;}
"from"					{return FROM;}
"Multiply"				{return MULTIPLY;}
"Divide"				{return DIVIDE;}
"by"					{return BY;}
"Assign"				{return ASSIGN;}
"to" 					{return TO;}
[a-zA-Z]			   	{yylval.id = yytext[0]; return identifier;}
[0-9]+                 	{yylval.num = atoi(yytext); return number;}
[ \r\t]                	{;}
[-+\*/\n] 	         	{return yytext[0];}
<<EOF>> 				{printf("%d\n", lastValOfExpr); return 0;}
.                    	{ECHO; yyerror ("Unexpected character encountered");}

%%

int yywrap (void) {return 1;}

