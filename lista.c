#include "lista.h"
#include "y.tab.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

void inserir_simbolo(tabela *t, simbolo *s) {
	no_tabela *no = (no_tabela *) malloc(sizeof(no_tabela));
	no->dado = s;
	no->proximo = t->primeiro;
	t->primeiro = no;
	//printf("lexema :%s\n",t->primeiro->dado->lexema);
}


simbolo * localizar_simbolo (tabela *contexto, char *lexema){
	tabela *temp = contexto;
	no_tabela *temp2;
	while(temp != NULL) {
		temp2 = temp->primeiro;
		while(temp2 != NULL) {
			if(strcmp(temp2->dado->lexema, lexema) == 0) {
				return temp2->dado;
			}
			temp2 = temp2->proximo;
		}
		temp = temp->pai;
	}
	return NULL;
}


simbolo *  criar_simbolo (char *lexema, int tipo) {
	simbolo *novo = (simbolo *) malloc(sizeof(simbolo));
	novo->tipo = tipo;
	novo->lexema = strdup(lexema);
	novo->val.ival = 0;
	return novo;
}

pilha_contexto* empilhar_contexto(pilha_contexto *pilha, tabela *contexto) {
	pilha_contexto *novo = (pilha_contexto *) malloc (sizeof(pilha_contexto));
	novo->anterior = pilha;
	novo->dado = contexto;
	return novo;
}

tabela * criar_contexto(tabela *pai) {
	tabela *novo = (tabela *) malloc(sizeof(tabela));
	novo->pai = pai;
	novo->primeiro = NULL;
	return novo;
}

void desempilhar_contexto(pilha_contexto **pilha) {
	if(*pilha != NULL)
		*pilha = (*pilha)->anterior;
}

tabela* topo_pilha(pilha_contexto *pilha) {
	if(pilha == NULL)
		return NULL;
	else
		return pilha->dado;
}

void imprimir_contexto(tabela *t) {
	no_tabela * temp = t->primeiro;
	printf("----------------------------------\n");
	while(temp != NULL) {
		if(temp->dado->tipo == INTEIRO)
			printf("\t INT: %s (%d)\n", temp->dado->lexema, temp->dado->val.ival);
		else
			printf("\t FLOAT: %s (%f)\n", temp->dado->lexema, temp->dado->val.fval);
		temp = temp->proximo;
	}
	printf("==================================\n");
}


numero* criar_numero(valor val, int tipo){
	numero *novo = (numero *)malloc(sizeof(numero));
	novo->tipo = tipo;
	novo->val = val;
	return novo;
}
