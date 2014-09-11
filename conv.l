%{
#include <iostream>
#include <cstdio>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()

#include "conv.tab.h"

float splitGNE( std::string s ){

std::string delimiter = "=";
float t;
size_t pos = 0;
while ((pos = s.find(delimiter)) != std::string::npos) {
    s.erase(0, pos + delimiter.length());
 }  
t = atof(s.c_str());
return t;
}

float splitGDX( std::string s ){

std::string delimiter = "(";

size_t pos = 0;
while ((pos = s.find(delimiter)) != std::string::npos) {
    s.erase(0, pos + delimiter.length());
}
float t;
t = atof(s.c_str());
return t;
}

float splitGDY( std::string s ){

std::string delimiter = ", ";

size_t pos = 0;
while ((pos = s.find(delimiter)) != std::string::npos) {
    s.erase(0, pos + delimiter.length());
}
float t;
t = atof(s.c_str());
return t;
}

%}

digit	[0-9]+
float	{digit}*"."{digit}
gne	[= ]+[\t]*
a	[a-zA-Z]+
gdx	{a}+{digit}+[(]+{float}+
gdy	[ \t]*{float}+[)]+
%%

[ \t] ;
POINT|LINE	   { yylval.ename = strdup(yytext); return ENAMEgd; }

x+{gne}+{float}+   { yylval.xval = splitGNE(yytext); 
		     return XVALgd; }

y+{gne}+{float}+   { yylval.yval = splitGNE(yytext);
		     return YVALgd; }

BINDU|REKHA	   { yylval.ename = strdup(yytext); return ENAMEgne; }

{gdx}		   { yylval.xval = splitGDX(yytext);
		     return XVALgne; }

{gdy}              { yylval.yval = splitGDY(yytext);
                     return YVALgne; }

. ;


