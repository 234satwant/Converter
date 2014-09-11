Converter
=========
This code reads a file, parses it and writes a file according to it. User can pass any input file which he wants to and export to any file, but the format will be same. For example conv.aj.

Commands to compile this code are :-

bison -d conv.y

flex conv.l

g++ conv.tab.c lex.yy.c -lfl -o conv

./conv
