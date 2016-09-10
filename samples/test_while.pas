{ 
  ******************************************
  * File: test_while.pas 
  * A test program for while statement
  ******************************************
}
Program test_while;
Begin
	z := 0;
	While z < 10 Do
	Begin
		writeln 'z = ', z;
		z := z + 1;
	End
	writeln 'Fin del primer ciclo';
	
	While z >= 0 Do
	Begin
		writeln 'z = ', z;
		z := z - 1;
	End
	writeln 'Fin del programa';
End.
