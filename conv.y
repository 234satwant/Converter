%{
#include <iostream>
#include <cstdio>
#include <stdio.h>
using namespace std;

extern "C" int yylex ();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s);
#define YYDEBUG 1

%}

%union{
	char *xval;
	char *yval;
	char *ename;
}

%token ENDL
%token <ename> ENAME
%token <xval> XVAL
%token <yval> YVAL

%%

converter:
	converter ENAME { cout << "entity = " << $2 << endl; }
	| converter XVAL { cout << $2 << endl; }
	| converter YVAL { cout << $2 << endl; }
	| ENAME { cout << "entity = " << $1 << endl; }
	| XVAL { cout << $1 << endl; }
	| YVAL { cout << $1 << endl; }

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
	ENAME XVAL YVAL { cout << "Entity Information\n" << $1 << endl << $2 << $3 << endl; }
	;
*/

%%

main() {
	FILE *myfile = fopen("conv.aj", "r");

	if (!myfile) {
		cout << "I can't open file" << endl;
		return -1;
	}

	yyin = myfile;

	do{
//		yydebug = 1;
		yyparse();
	} while (!feof(yyin));
}

void yyerror(const char *s) {
	cout << "Parser error! Message: " << s << endl;
	exit(-1);
}
