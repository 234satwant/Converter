bison -d conv.y
flex conv.l
g++ conv.tab.c lex.yy.c -lfl -o conv
