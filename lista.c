#include "lista.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

no_tabela* inicializaTbl(void){
  return NULL;
}
simbolo* inicializaSbl(void){
  return NULL;
}
simbolo* criar_simbolo(int code, char* lexema){
  simbolo* novo = (simbolo*) malloc(sizeof(simbolo));
  char *converte = (char*)malloc(sizeof(lexema));
  novo->code=code;
  novo->lexema=converte;
  strcpy(novo->lexema, lexema);
  return novo;
}

no_tabela* inserir_simboloTbl(no_tabela* tbl, simbolo* simbolo){
    no_tabela* novo = (no_tabela*) malloc(sizeof(no_tabela));
    novo->dado=*simbolo;
    novo->proximo=tbl;
    return novo;
}

no_tabela* verifica(no_tabela* tbl, simbolo* simbolo, char* lexema){
  if(capturaIdlexema(tbl,lexema)!=-1){ //verifica se já tá na tabela
    printf("<id,%d>",capturaIdlexema(tbl,lexema));
    return tbl;
  }else{  //caso não esteja na tabela
    int idTemp = capturaId(tbl)+1;
    printf("<id,%d>",idTemp);
    return inserir_simboloTbl(tbl,criar_simbolo(idTemp,lexema));

  }
}


int capturaId(no_tabela* tbl){
  int id;
  no_tabela *pTbl=tbl;
  if(pTbl==NULL){
    id = 0;
  }else{
      id = pTbl->dado.code;
  }
  return id;
}

int capturaIdlexema(no_tabela* tbl, char* lexema){
  no_tabela *pTbl=tbl;
  while(pTbl!=NULL){
    if(strcmp(pTbl->dado.lexema,lexema)==0){
      return pTbl->dado.code;
    }
    pTbl = pTbl->proximo;
  }
  return -1;
}

void imprimirTabela(no_tabela* tbl){
  no_tabela *pTbl=tbl;
  printf("\n\n");
  if(pTbl==NULL){
    printf("vazio!\n");
  }else{
    while(pTbl!=NULL){
    printf("id: %d - lexico: %s\n", pTbl->dado.code, pTbl->dado.lexema);
    pTbl = pTbl->proximo;
    }
  }
}
