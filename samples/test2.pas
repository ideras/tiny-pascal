{ 
  ******************************************
  * File: test2.pas 
  * A test program for relational operators
  ******************************************
}
program test2;
begin
  x := (10 - 3);
  y := (x * 10) div 5;

  writeln (x + y) * 30;
  writeln x;
  writeln y;
  // Greather than
  writeln x > y;
  // Less than
  writeln x < y;
  // Greather or Equal
  writeln x >= y;
  // Less or Equal
  writeln x <= y;
  // Not Equal
  writeln x <> y;
  // Equal
  writeln x = y;
  writeln 1 = 1;

  writeln x - y < x + y;
end.