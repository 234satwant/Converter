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

select_format s;
int x_n, y_n, e_t, e_n;

int in (int i)
{ 
        return i;
}

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
	| converter XVALgd { s.Store_values_xy($2, x_n, 'x'); in(x_n); x_n++; } 
	| converter YVALgd { s.Store_values_xy($2, y_n, 'y'); in(x_n); y_n++; }
	| converter ENAMEgne { e_t = e_n; s.Store_values_nametype($2, e_t, 't'); }
        | converter XVALgne { s.Store_values_xy($2, x_n, 'x'); in(x_n); x_n++; }
        | converter YVALgne { s.Store_values_xy($2, y_n, 'y'); in(y_n); y_n++; }
	| converter NAMEgne { s.Store_values_nametype($2, e_n, 'n'); in(e_n); if(s.flag == 0) e_n++; }
        | ENAMEgd { e_t = e_n; s.Store_values_nametype($1, e_t, 't'); }
        | XVALgd { s.Store_values_xy($1, x_n, 'x'); in(x_n); x_n++; }
        | YVALgd { s.Store_values_xy($1, y_n, 'y'); in(y_n); y_n++; }
	| ENAMEgne { e_t = e_n; s.Store_values_nametype($1, e_t, 't'); }
	| XVALgne { s.Store_values_xy($1, x_n, 'x'); in(x_n); x_n++; }
	| YVALgne { s.Store_values_xy($1, y_n, 'y'); in(y_n); y_n++; }
	| NAMEgne { s.Store_values_nametype($1, e_n, 'n'); in(e_n); if(s.flag == 0) e_n++; }
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

        s.total_values(e_n);
        s.Write_file();
        s.start_end_func("*", 20);

}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}
