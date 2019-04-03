%{

void yyerror (char *s);
int yylex();

#include <stdio.h>     
#include <stdlib.h>
#include <ctype.h>

int symbols[52];
int symbolVal(char symbol);


/* Variable to store the last executed statement*/
int lastValOfExpr = 0;

void updateSymbolVal(char symbol, int val);

%}

%union {int num; char id;}         /* Yacc definitions */
%start program
%token PRINT ADD WITH ASSIGN TO SUBSTRACT FROM MULTIPLY DIVIDE BY
%token <num> number
%token <id> identifier
%type <num> program statement expression term

%%

/* CFG */

program												
	: statement '\n'								{;}
	| program statement '\n'						{;}
    ;

statement
	: expression									{$$ = $1;}
	| PRINT statement								{$$ = $2; printf("%d\n", $2); lastValOfExpr = $$;}
	| ADD statement WITH statement					{$$ = $2 + $4; lastValOfExpr = $$;}
	| SUBSTRACT statement FROM statement			{$$ = $2 - $4; lastValOfExpr = $$;}
	| MULTIPLY statement BY statement				{$$ = $2 * $4; lastValOfExpr = $$;}
	| DIVIDE statement BY statement					{$$ = $2 / $4; lastValOfExpr = $$;}
	| ASSIGN identifier TO statement  				{$$ = $4; updateSymbolVal($2,$4); lastValOfExpr = $$;}
	;

expression    	
	: term                  						{$$ = $1;}
   	| expression term '*'          					{$$ = $1 * $2;}
   	| expression term '/'          					{$$ = $1 / $2;}
   	| expression term '+'          					{$$ = $1 + $2;}
   	| expression term '-'          					{$$ = $1 - $2;}
   	;

term
   : number                							{$$ = $1;}
   | identifier										{$$ = symbolVal($1);} 
   ;


%%                     /* C code */

int computeSymbolIndex(char token){
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
}

/* returns the value of a given symbol */

int symbolVal(char symbol){
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */

void updateSymbolVal(char symbol, int val){
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}