Converter
=========
This code reads a file conv.aj and parses it.
Commands to compile this code are :-

bison -d conv.y

flex conv.l

g++ conv.tab.c lex.yy.c -lfl -o conv

./conv
