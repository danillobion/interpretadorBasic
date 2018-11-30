all: teste

teste:
	lex basic.lex
	yacc -d basic.yacc
	gcc -o teste *.c
	./teste < input


clean:
	rm -rf *.o lista.exe lex.yy.c teste y.tab.h y.tab.c
