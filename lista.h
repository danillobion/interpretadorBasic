#ifndef lista_H
#define lista_H

typedef struct simbolo{
  int code;
  char *lexema;
}simbolo;

typedef struct no_tabela{
  simbolo dado;
  struct no_tabela *proximo;
}no_tabela;


no_tabela* inicializaTbl(void);
simbolo* inicializaSbl(void);
simbolo* criar_simbolo(int code, char* lexema);
no_tabela* inserir_simboloTbl(no_tabela* tbl, simbolo* simbolo);
void imprimirTabela(no_tabela* tbl);
int capturaId(no_tabela* tbl);
int capturaIdlexema(no_tabela* tbl, char* lexema);
no_tabela* verifica(no_tabela* tbl, simbolo* simbolo, char* lexema);


#endif
