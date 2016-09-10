TARGET = tinypascal

all: ${TARGET}

${TARGET}: ast.o ${TARGET}_parser.o ${TARGET}_lexer.o main.o
	g++ -o $@ $^

ast.o: ast.cpp ast.h
	g++ -c -o $@ $<
	
main.o: main.cpp ast.h
	g++ -c -o $@ $<

${TARGET}_lexer.o: ${TARGET}_lexer.cpp
	g++ -c -o $@ $<

${TARGET}_lexer.cpp: ${TARGET}.l ast.h
	flex -i -o $@ $<

${TARGET}_parser.cpp: ${TARGET}.y ast.h
	bison -Werror --report=all --defines=tokens.h -o $@ $<

${TARGET}_parse.o: ${TARGET}_parser.cpp
	g++ -c -o $@ $<

clean:
	rm -f *.o
	rm -f ${TARGET}_lexer.cpp
	rm -f ${TARGET}_parser.cpp
	rm -f tokens.h
	rm -f ${TARGET}
	rm -f tinypascal_parser.output
