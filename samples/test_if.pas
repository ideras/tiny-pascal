{ 
  ******************************************
  * File: test_if.pas 
  * A test program for if statement
  ******************************************
}
program test_if;
begin
	x := (10 - 3);
	y := (x * 10) div 5;

	if (x > 10) then
		writeln 'x es mayor a 10', x;
	else if x > 7 then
        writeln 'x es mayor a 7 pero menor que 10', x;
    else
        writeln 'x es menor que 7';
end.
