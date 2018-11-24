all: teste

teste:
	lex basic.lex
	gcc -o teste lex.yy.c lista.c
	./teste < input


clean:
	rm -rf *.o lista.exe lex.yy.c teste
