compile:
	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	clear
	./program


file:
	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < code.pas
