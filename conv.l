%{
#include <iostream>
#include <cstdio>
using namespace std;

#define YY_DECL extern "C" int yylex()

#include "conv.tab.h"
%}

digit [0-9]+
float {digit}*"."{digit}
eq [ =]+[\t]*

%%

[ \t]           ;
(?:POINT|LINE)  { yylval.ename = strdup(yytext); return ENAME;  }

x+{eq}+{float}+         { yylval.xval = strdup(yytext); return XVAL; }

y+{eq}+{float}+         { yylval.yval = strdup(yytext); return YVAL; }

.               ;
%%

