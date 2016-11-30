program loop;

var
  test1, test2, test3, test4 : integer;

begin

  test1 := 5;
  test2 := 6;
  test4 := 8;

  repeat
    writeln('teste repeat');
  until test1 < 9;

  for test3:=1 to 10 do
    begin
      writeln('teste for');
    end;

  while test4 >= 50 do
    begin
      writeln('teste while');
    end;


end.
