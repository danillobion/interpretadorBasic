%{
#ifndef YYSTYPE
#define YYSTYPE long int
#endif
#include <stdlib.h>
#include <stdio.h>
#include "lista.h"
int yylex(void);
void yyerror(char *);
pilha_contexto *pilha;

%}

%token DIM AS NUMBER ID TYPE INTEIRO RELOP ATTR DECLARE FUNCTION END PRINT MOD IF TO THEN ELSE ENDIF LT LE GT GE EQ NE AND OR NOT DO LOOP UNTIL
%left RELOP OR AND NOT
%left '+' '-'
%left '*' '/'
%left MOD
%%
program:
        functs bloco
        ;

params:
        params ',' param
        |param
        ;
param:
        ID AS TYPE
        ;
paramsv:
        params
        |
        ;

functs:
        functs funct
        |
        ;
funct:
        DECLARE FUNCTION ID '(' paramsv ')' AS TYPE bloco END FUNCTION
        ;
bloco:
        decls stmts
        ;

decls:
        decls decl
        |
        ;
decl:
        DIM ID AS TYPE

        ;

stmts:
        stmts stmt
        |
        ;
stmt:
        attr
        |cond
        |funCall
        |loop
        ;
cond:
        IF booleano THEN bloco ENDIF
        |IF booleano THEN bloco ELSE bloco ENDIF
        ;
booleano:
        expr RELOP expr
        |logico
        ;
logico:
        booleano AND booleano
        |booleano OR booleano
        |NOT booleano
        ;

attr:
        ID ATTR expr
        ;
expr:
        NUMBER
        |ID
        |funCall
        |expr '+' expr
        |expr '-' expr
        |expr '*' expr
        |expr '/' expr
        |'(' expr ')'
        |expr MOD expr
        ;

funCall:
        ID '(' argv ')'
        ;
argv:
        args
        |
        ;

args:
        args ',' expr
        |expr
        ;
loop:
        DO UNTIL '(' booleano ')' bloco LOOP
        ;

%%

void yyerror(char *s){
  fprintf(stderr, "%s\n",s);
}

int main(void){
  pilha = NULL;
  tabela *contexto = criar_contexto(topo_pilha(pilha));
  yyparse();
  return 0;
}
