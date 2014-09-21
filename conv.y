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
	converter ENAMEgd { s.WriteGNEfile_entity($2); }
	| converter XVALgd { s.x_coord [x_no] = $2; in(x_no); x_no++; } 
	| converter YVALgd { s.y_coord [y_no] = $2; in(y_no); y_no++; }
	| converter NAMEgd { cout << "GD " << $2 << endl; }
	| converter ENAMEgne { s.WriteGDfile_entity($2); }
        | converter XVALgne { s.Store_values_xy($2, x_no, 'x'); cout <<"hello " <<  s.x_coord[x_no] <<endl; in(x_no); x_no++; cout << "\ngne\n"; }
        | converter YVALgne { s.Store_values_xy($2, y_no, 'y'); in(y_no); y_no++; }
	| converter NAMEgne { cout << "GNE " << $2 << endl; }
        | ENAMEgd { s.WriteGNEfile_entity($1); }
        | XVALgd { s.x_coord [x_no] = $1; in(x_no); x_no++; }
        | YVALgd { s.y_coord [y_no] = $1; in(y_no); y_no++; }
	| NAMEgd { cout << "GD " << $1 << endl; }
	| ENAMEgne { s.WriteGDfile_entity($1); }
	| XVALgne { s.Store_values_xy($1, x_no, 'x'); in(x_no); x_no++; }
	| YVALgne { s.Store_values_xy($1, y_no, 'y'); in(y_no); y_no++; }
	| NAMEgne { cout << "GNE " << $1 << endl; }
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

	s.total_values(x_no);
	s.Write_file();
	do{
//		yydebug = 1;
		yyparse();
	} while (!feof(yyin));
cout << x_no;
       s.start_end_func("*", 20);

}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}
