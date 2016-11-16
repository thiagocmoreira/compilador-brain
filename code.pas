program teste;

var
  variavel_teste, teste_condicao, teste_repeat, teste_while, contador: integer;
  variavel_teste, teste_condicao, teste_repeat, teste_while, contador: real;

begin

  // FCOMP_2016_02
  (* Compilador_Brain *)
  read(tefsfs, sfsd);

  write('teste write');
  variavel_teste := (5 + 5);

  for contador:=1 to 10 do
    begin
      writeln('teste for');
    end;

  while teste_while >= 50 do
    begin
      writeln('teste while');
    end;

  if(teste_condicao <= 0) then
    writeln('teste if');
  else
    writeln('teste else');

  repeat
    writeln('teste repeat');
  until teste_repeat<9;

end.
