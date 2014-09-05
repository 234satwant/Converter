%{
#include <iostream>
#include <cstdio>

#define YY_DECL extern "C" int yylex()

#include "conv.tab.h"
using namespace std;

//int line_no = 1;
%}
eq [ \t]*=
%%

[ \t]		;
(?:POINT|LINE)	{ yylval.ename = strdup(yytext); return ENAME; }
x{eq}		{ yylval.xval = atof(yytext);
			return XVAL; }
y{eq}		{ yylval.yval = atof(yytext);
			return YVAL; }
.		;
%%
