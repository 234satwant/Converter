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
/*static float	x_coord [1024];
static float	y_coord [1024];
static string	entity_type [1024];
static string	entity_name [1024];
*/
int x_no, y_no = 0, e_t = 0, e_n = 0;
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
	converter ENAMEgd { s.WriteGNEfile_entity($2);}
	| converter XVALgd { s.x_coord [x_no] = $2; x_no++; } 
	| converter YVALgd { s.y_coord [y_no] = $2; y_no++; }
	| converter NAMEgd { cout << "GD " << $2 << endl; }
	| converter ENAMEgne { s.WriteGDfile_entity($2); }
        | converter XVALgne { s.WriteGDfile_xy($2, 'x'); }
        | converter YVALgne { s.WriteGDfile_xy($2, 'y'); }
	| converter NAMEgne { cout << "GNE " << $2 << endl; }
        | ENAMEgd { s.WriteGNEfile_entity($1); }
        | XVALgd { s.x_coord [x_no] = $1; x_no++; }
        | YVALgd { s.y_coord [y_no] = $1; y_no++; }
	| NAMEgd { cout << "GD " << $1 << endl; }
	| ENAMEgne { s.WriteGDfile_entity($1); }
	| XVALgne { s.WriteGDfile_xy($1, 'x'); }
	| YVALgne { s.WriteGDfile_xy($1, 'y'); }
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

       s.start_end_func("*", 20);

}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}
