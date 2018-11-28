%{
#ifndef YYSTYPE
#define YYSTYPE long int
#endif
#include "y.tab.h"
#include "lista.h"
#include <stdio.h>


%}

letra	[a-z|A-Z|_]
numero	[0-9]
identificador	{letra}({letra}|{numero})*

%%
dim                       {return DIM;}
as                        {return AS;}
integer                   {
                              yylval = INTEIRO;
                              return TYPE;
                          }
declare                   {return DECLARE;}
function                  {return FUNCTION;}
end                       {return END;}
print                     {return PRINT;}

{numero}+                 {
                              valor v;
                              v.ival = atoi(yytext);
                              yylval = (long int) criar_numero(v, INTEIRO);
                              return NUMBER;
                          }

{numero}+"."{numero}+     { }


"<"                       printf("<relop,LT>");
"<="                      printf("<relop,LE>");
"="                       {return ATTR;}
"<>"                      printf("<relop,NE>");
">"                       printf("<relop,GT>");
">="                      printf("<relop,GE>");

{identificador}           {
                              yylval = (long int) strdup(yytext);
                              return ID;

                          }

[-+=*/(){};,]	               {	return *yytext; }

[ \t\n]                   ;

%%
int yywrap(void){
  return 1;
}
