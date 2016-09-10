{ 
  ******************************************
  * File: test4.pas 
  * A program with errors
  ******************************************
}
program test3;
begin
  x := (10 - 3);
  y := (x * 10) div 5;

  (*
    Testing the line numbers
  *)
  z := x + y;
  writeln z;
end.
