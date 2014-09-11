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
		{ f << "\nBINDU";    }
		else if ( s.compare("LINE") == 0)
		{ f << "\nREKHA";    }
	}	

	void write_file_floatx(float s)
	{
		ofstream f(exp_f_name.c_str(), ios::app);
		f << " (" << s <<", ";
	}

        void write_file_floaty(float s)
        {
                ofstream f(exp_f_name.c_str(), ios::app);
                f << s <<") ";
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
	| converter XVAL { w.write_file_floatx($2); }
	| converter YVAL { w.write_file_floaty($2); }
	| ENAME { w.write_file_str($1); }
	| XVAL { w.write_file_floatx($1); }
	| YVAL { w.write_file_floaty($1); }
%%

main() 
{
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
