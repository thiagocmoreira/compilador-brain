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
	mv biggerCode.c results/

test:
	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/variableDeclarations.pas
	mv variableDeclarations.c results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/variableInstantiation.pas
	mv variableInstantiation.c results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/writes.pas
	mv writes.c results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/writeWithVariables.pas
	mv writeWithVariables.c results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/read.pas
	mv readProgram.c results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/conditional.pas
	mv conditional.c results/

	flex -i lex.l
	bison grammar.y -v
	gcc -o program grammar.tab.c -ll
	./program < tests/loop.pas
	mv loop.c results/
