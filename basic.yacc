%{
#ifndef YYSTYPE
#define YYSTYPE long int
#endif
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "lista.h"
int yylex(void);
void yyerror(char *);
pilha_contexto *pilha;

%}

%token DIM AS NUMBER ID TYPE INTEIRO REAL RELOP ATTR DECLARE FUNCTION END PRINT MOD IF TO THEN ELSE ENDIF LT LE GT GE EQ NE AND OR NOT DO LOOP UNTIL
%left RELOP OR AND NOT
%left '+' '-'
%left '*' '/'
%left MOD
%%
program:
        functs bloco          {//tabela *contexto = criar_contexto(topo_pilha(pilha));
				                       //pilha = empilhar_contexto(pilha, contexto);
                               imprimir_contexto(topo_pilha(pilha));
				                       desempilhar_contexto(&pilha);
                              }
        ;

params:
        params ',' param
        |param
        ;
param:
        ID AS TYPE            {
                              simbolo * s = criar_simbolo((char *) $1, $3);
                              inserir_simbolo(topo_pilha(pilha),s);
                              }
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
        DECLARE FUNCTION ID { tabela *contexto = criar_contexto(topo_pilha(pilha));
				                       pilha = empilhar_contexto(pilha, contexto);}

        '(' paramsv ')' AS TYPE bloco END FUNCTION { imprimir_contexto(topo_pilha(pilha));
           desempilhar_contexto(&pilha);
          }
        ;
bloco:
        decls stmts
        ;

decls:
        decls decl
        |
        ;
decl:
        DIM ID AS TYPE                  {
                                         simbolo * s = criar_simbolo((char *) $2, $4);
                                         inserir_simbolo(topo_pilha(pilha),s);
                                        }
        | DIM ID '(' NUMBER ')'
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
        | '(' booleano ')'
        ;
logico:
        booleano AND booleano
        |booleano OR booleano
        |NOT booleano
        ;

attr:
        ID ATTR expr {
                      simbolo *s = localizar_simbolo(topo_pilha(pilha),(char *) $1);
                      if(s == NULL){
                            yyerror("Identificador não declarado");
                      }
                      //else
                     }
        ;
expr:
        NUMBER
        |ID         {
                      simbolo *s = localizar_simbolo(topo_pilha(pilha),(char *) $1);
                      if(s == NULL){
                            yyerror("Identificador não declarado");
                      }
                      //else
                     }
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
  pilha = empilhar_contexto(pilha, contexto);

  yyparse();


  return 0;
}
