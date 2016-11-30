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

test:
	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/variableDeclarations.pas
	mv /variableDeclarations.pas results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/variableInstantiation.pas
	mv variableDeclarations.pas results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/writes.pas
	mv writes.pas results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/writeWithVariables.pas
	mv writeWithVariables.pas results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/read.pas
	mv read.pas results/
