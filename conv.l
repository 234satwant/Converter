%{
#include <iostream>
#include <stdio.h>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()

#include "conv.tab.h"
//select_format sel;

float splitGNE( string s )
{
	string delimiter = "=";
	float t;
	size_t pos = 0;
	while ((pos = s.find(delimiter)) != std::string::npos)
	{
    		s.erase(0, pos + delimiter.length());
	}
	t = atof(s.c_str());
	return t;
}

float splitGDX( string s )
{

	string delimiter = "(";

	size_t pos = 0;
	while ((pos = s.find(delimiter)) != string::npos)
	{
    		s.erase(0, pos + delimiter.length());
	}
	float t;
	t = atof(s.c_str());
	return t;
}

float splitGDY( string s )
{
	string delimiter = ", ";

	size_t pos = 0;
	while ((pos = s.find(delimiter)) != string::npos)
	{
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
char	[a-zA-Z]+
gdx	[(]+{float}+
gdy	[ \t]*{float}+[)]+

%%

[ \t\n] ;
{char}+{digit}+    { yylval.ename = strdup(yytext); return NAMEgne;}

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


