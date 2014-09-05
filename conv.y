%{
#include <iostream>
#include <cstdio>
#include <stdio.h>
using namespace std;

extern "C" int yylex ();
extern "C" int yyparse (void);
extern "C" FILE *yyin;
//extern int line_no;

void yyerror(const char *s);
#define YYDEBUG 1

%}

%union{
	float xval;
	float yval;
	char *ename;
}

%token ENDL
%token <ename> ENAME
%token XVAL
%token YVAL

%%

converter:
	converter ENAME { cout << "entity = " << $2 << endl; }
	| converter XVAL {// x -> xval = $2; 
cout << "x value = " << endl; }
	| converter YVAL {// y -> yval = $2; 
cout << "y value = " << endl; }
	| ENAME { cout << "entity = " << $1 << endl; }
	| XVAL { cout << "xvalue " << endl; }
	| YVAL { cout << "yvalue " << endl; }
/*converter:
	data { cout << "Read the file\n"; }
	;
data:
	data_lines data_line
	| data_line
	;
data_lines:
	data_lines data_line
	| data_line
	;
data_line: 
	ENAME XVAL YVAL { cout << "Entity Information\n" << $1 << endl; }
	;
*/%%

main() {
	FILE *myfile = fopen("conv.aj", "r");

	if (!myfile) {
		cout << "I can't open file" << endl;
		return -1;
	}

	yyin = myfile;

	do{
		yydebug = 1;
		yyparse();
	} while (!feof(yyin));
	yydebug = 2;
}

void yyerror(const char *s) {
	//cout << "Parser error on line " << line_no << "! Message: " << s << endl;
	exit(-1);
}
