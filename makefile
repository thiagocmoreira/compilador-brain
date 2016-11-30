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

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/variableInstantiation.pas

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/writes.pas

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/writeWithVariables.pas

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/read.pas

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/conditional.pas

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/loop.pas
