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

%token DIM AS NUMBER ID TYPE INTEIRO EQ RELOP ATTR DECLARE FUNCTION END PRINT
%left '+' '-'
%left '*' '/'
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
        |funCall
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
