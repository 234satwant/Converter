%{
#include <iostream>
#include <cstdio>
#include <stdio.h>
#include <fstream>
using namespace std;

extern "C" int yylex ();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s);
#define YYDEBUG 1
class write_file
{
	string exp_f_name;
//	ofstream f("conv.try", ios::out);

public:
	write_file()
	{	cout <<"***************************\n";
		cout << "Enter the name of file you want to export\n";
       		cin >> exp_f_name;
		ofstream f(exp_f_name.c_str(), ios::out);
	}

	void write_file_str(std::string s)
	{
		ofstream f(exp_f_name.c_str(), ios::app);
		if ( s.compare("POINT") == 0)
		{ f << "BINDU" << endl;    }
		else if ( s.compare("LINE") == 0)
		{ f << "REKHA" << endl;    }
	}	

	void write_file_float(float s)
	{
		ofstream f(exp_f_name.c_str(), ios::app);
		f << s << endl;
	}
}w;

%}

%union{
	float xval;
	float yval;
	char *ename;
}

%token ENDL
%token <ename> ENAME
%token <xval> XVAL
%token <yval> YVAL

%%

converter:
	converter ENAME { w.write_file_str($2); }
	| converter XVAL { w.write_file_float($2); }
	| converter YVAL { w.write_file_float($2); }
	| ENAME { w.write_file_str($1); }
	| XVAL { w.write_file_float($1); }
	| YVAL { w.write_file_float($1); }

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

main() 

{
//write_file w;
	string imp_f_name; 
	cout << "Enter the name of file you want to import\n";
	cin >> imp_f_name;

	FILE *myfile = fopen(imp_f_name.c_str(), "r");
	ofstream f("conv.try", ios::out);

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
