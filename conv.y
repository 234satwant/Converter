%{
#include "parser.h" 
#include <iostream>
#include <fstream>
using namespace std;

extern "C" int yylex ();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s);
#define YYDEBUG 1
int in (int i)
{ return i; }
select_format s;
int x_no, y_no, e_t, e_n;
%}

%union{
	float xval;
	float yval;
	char *ename;
	char *name;
}

%token ENDL
%token <ename> ENAMEgd ENAMEgne
%token <name> NAMEgne NAMEgd
%token <xval> XVALgd XVALgne
%token <yval> YVALgd YVALgne

%%

converter:
	converter ENAMEgd { e_t = e_n; s.Store_values_nametype($2, e_t, 't'); }
	| converter XVALgd { x_no = e_n; s.Store_values_xy($2, x_no, 'x'); } 
	| converter YVALgd { y_no = e_n; s.Store_values_xy($2, y_no, 'y'); }
	| converter NAMEgd { s.Store_values_nametype($2, e_n, 'n'); in(e_n); e_n++; }
	| converter ENAMEgne { e_t = e_n; s.Store_values_nametype($2, e_t, 't'); }
        | converter XVALgne { x_no = e_n; s.Store_values_xy($2, x_no, 'x'); }
        | converter YVALgne { y_no = e_n; s.Store_values_xy($2, y_no, 'y'); }
	| converter NAMEgne { s.Store_values_nametype($2, e_n, 'n'); in(e_n); e_n++; }
        | ENAMEgd { e_t = e_n; s.Store_values_nametype($1, e_t, 't'); }
        | XVALgd { x_no = e_n; s.Store_values_xy($1, x_no, 'x'); }
        | YVALgd { y_no = e_n; s.Store_values_xy($1, y_no, 'y'); in(y_no); }
	| NAMEgd { s.Store_values_nametype($1, e_n, 'n'); in(e_n); }
	| ENAMEgne { e_t = e_n; s.Store_values_nametype($1, e_t, 't'); }
	| XVALgne { x_no = e_n; s.Store_values_xy($1, x_no, 'x'); }
	| YVALgne { y_no = e_n; s.Store_values_xy($1, y_no, 'y'); }
	| NAMEgne { s.Store_values_nametype($1, e_n, 'n'); in(e_n); e_n++; }
%%

int main() 
{
	s.start_function();
	string imp_f_name, f_name;
	cout << "Enter the name of file you want to input\n";
	cin >> f_name;
	if (s.ch == 1)
	{	imp_f_name = f_name + ".gne";	}
	else if (s.ch == 2)
	{	imp_f_name = f_name + ".gd";	}

	FILE *myfile = fopen(imp_f_name.c_str(), "r");

	if (!myfile) {
		cout << "I can't open file" << endl;
		return -1;
	}
	yyin = myfile;
	do{
//		yydebug = 1;
		yyparse();
	} while (!feof(yyin));

cout << e_n << endl;

        s.total_values(e_n);
        s.Write_file();

        s.start_end_func("*", 20);

}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}
