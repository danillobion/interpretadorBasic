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
mod                       {return MOD;}
if                        {return IF;}
then                      {return THEN;}
"end if"                  {return ENDIF;}
else                      {return ELSE;}

and                       {return AND;}
or                        {return OR;}
not                       {return NOT;}

do                        {return DO;}
loop                      {return LOOP;}
until                     {return UNTIL;}

to                        {return TO;}


{numero}+                 {
                              valor v;
                              v.ival = atoi(yytext);
                              yylval = (long int) criar_numero(v, INTEIRO);
                              return NUMBER;
                          }

{numero}+"."{numero}+     { }


"<"                       {yylval = LT; return RELOP;}
"<="                      {yylval = LE; return RELOP;}
">"		                    {yylval = GT; return RELOP;}
">="                      {yylval = GE; return RELOP;}
"=="                      {yylval = EQ; return RELOP;}
"!="                      {yylval = NE; return RELOP;}


"="                       {return ATTR;}

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
