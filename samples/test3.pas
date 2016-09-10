{ 
  ******************************************
  * File: test3.pas 
  * A test program for div and mod
  ******************************************
}
program test3;
begin
  x := (10 - 3);
  y := (x * 10) div 5;
  z := (x * 10) mod 5;
  
  writeln  'x=',x, 'y=', y, 'z=', z;
end.
