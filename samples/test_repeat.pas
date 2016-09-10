{ 
  ******************************************
  * File: test_repeat.pas 
  * A test program for repeat statement
  ******************************************
}
program test_repeat;
begin
	number := 100;
	sum := 0;
	repeat
		sum := sum + number;
		number := number - 2;
	until number = 0;
	writeln 'La suma es ', sum;
end.
