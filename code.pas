program teste;

var
  variavel_teste, teste_condicao, teste_repeat, teste_while, contador: integer;
  variavel_teste, teste_condicao, teste_repeat, teste_while, contador: real;

begin

  read(tefsfs, sfsd);

  // Comandos de saida
  write('teste write');
  writeln('teste write');

  (* Atribuicao aritmetica *)
  variavel_teste := (5 + 5);
  variavel_teste := 10.5 + 12.9;

  // Estruturas de repeticao
  repeat
    writeln('teste repeat');
  until teste_repeat < 9;

  for contador:=1 to 10 do
    begin
      writeln('teste for');
    end;

  while teste_while >= 50 do
    begin
      writeln('teste while');
    end;

  (* Estrutura de condicao *)
  if(teste_condicao <= 0) then
    writeln('teste if');
  else
    writeln('teste else');

end.
