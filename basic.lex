%{
#include "lista.h"
#include <stdio.h>

simbolo *s;
no_tabela *t;
%}
ws      \t|\n|\r|" "

%%
{ws}                      { }

Dim                       printf("<Dim,null>");
As                        printf("<As,null>");
Integer                   printf("<Integer,null>");
Double                    printf("<Double,null>");
String                    printf("<String, null>");

if                        printf("<If,null>");
else                      printf("<Else,null>");
Print                     printf("<Print,null>");

[a-zA-Z][a-zA-Z]*         t = verifica(t,s,yytext);
[0-9]*                    printf("<number,%s>", yytext);

"<"                       printf("<relop,LT>");
"<="                      printf("<relop,LE>");
"="                       printf("<relop,EQ>");
"<>"                      printf("<relop,NE>");
">"                       printf("<relop,GT>");
">="                      printf("<relop,GE>");


%%

int main(int argc, char *argv[]){


  printf("\n\n");
  yylex();
  printf("\n\n");
  imprimirTabela(t);

}
int yywrap() { return 1;}
