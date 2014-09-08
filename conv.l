%{
#include <iostream>
#include <cstdio>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()

#include "conv.tab.h"

float split( std::string s){

std::string delimiter = "=";
float t;
size_t pos = 0;
while ((pos = s.find(delimiter)) != std::string::npos) {
    s.erase(0, pos + delimiter.length());
 }  
t = atof(s.c_str());
return t;
}

%}

digit [0-9]+
float {digit}*"."{digit}
eq [= ]+[\t]*

%%

[ \t] ;
POINT|LINE	   { yylval.ename = strdup(yytext); return ENAME; }

x+{eq}+{float}+	   { yylval.xval = split(yytext); 
		     return XVAL; }

y+{eq}+{float}+    { yylval.yval = split(yytext);
		     return YVAL; }

. ;

%%
