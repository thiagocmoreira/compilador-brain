program conditional;

var
  test1, test2 : integer;

begin

  test1 := 10 + 2;
  test2 := 12 + 20;

  if(test1 > test2) then
    writeln(test1);
  else if(test2 > test1) then
    writeln(test2);
  else
    writeln('São iguais!');
  end;

end.
