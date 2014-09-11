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

  class sel_format	
  {
        string exp_f_name, f_name;

	public:
        int ch;

        sel_format()
        {
                cout << "Enter the file format you want to export\n";
                cout << "1 - Convert GNE format to GD\n";
                cout << "2 - Convert GD format to GNE\n";
                cin >> ch;

                cout << "Enter the name of file you want to export\n";
                cin >> f_name;

                if (ch == 1)
                	{  exp_f_name = f_name + ".gd";  }	
		else if(ch == 2)
                	{  exp_f_name = f_name + ".gne";  }

		ofstream f(exp_f_name.c_str(), ios::out);
	}

/////////////// WRITING GNE FILE(HINDI) //////////////
	void WriteGNEfile_entity(std::string s)
        {
          	ofstream f(exp_f_name.c_str(), ios::app);
               	if ( s.compare("POINT") == 0)
			{  f << "\nBINDU";  }
                else if ( s.compare("LINE") == 0)
                        {  f << "\nREKHA";  }
        }

        void WriteGNEfile_x(float s)
      	{
              	ofstream f(exp_f_name.c_str(), ios::app);
                f << " (" << s << ", ";
      	}

      	void WriteGNEfile_y(float s)
        {
              	ofstream f(exp_f_name.c_str(), ios::app);
                f << s << ") ";
      	}

////////////// WRITING GD FILE(ENGLISH) /////////////
	void WriteGDfile_entity(std::string s)
	{
             	ofstream f(exp_f_name.c_str(), ios::app);
        	if ( s.compare("BINDU") == 0)
			{  f << "POINT\n";  }
            	else if ( s.compare("REKHA") == 0)
                        {  f << "\nLINE\n";  }
    	}

     	void WriteGDfile_x(float s)
      	{
              	ofstream f(exp_f_name.c_str(), ios::app);
              	f << "x = " << s << "\n";
      	}

       	void WriteGDfile_y(float s)
      	{
     	        ofstream f(exp_f_name.c_str(), ios::app);
                f << "y = " << s << "\n";
        }
                
  }s;
%}

%union{
	float xval;
	float yval;
	char *ename;
}

%token ENDL
%token <ename> ENAMEgd ENAMEgne
%token <xval> XVALgd XVALgne
%token <yval> YVALgd YVALgne

%%

converter:
	converter ENAMEgd { s.WriteGNEfile_entity($2); }
	| converter XVALgd { s.WriteGNEfile_x($2); }
	| converter YVALgd { s.WriteGNEfile_y($2); }
	| converter ENAMEgne { s.WriteGDfile_entity($2); }
        | converter XVALgne { s.WriteGDfile_x($2); }
        | converter YVALgne { s.WriteGDfile_y($2); }
        | ENAMEgd { s.WriteGNEfile_entity($1); }
        | XVALgd { s.WriteGNEfile_x($1); }
        | YVALgd { s.WriteGNEfile_y($1); }
	| ENAMEgne { s.WriteGDfile_entity($1); }
	| XVALgne { s.WriteGDfile_x($1); }
	| YVALgne { s.WriteGDfile_y($1); }
%%

int main() 
{
	string imp_f_name, f_name; 

	cout << "Enter the name of file you want to import\n";
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

}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}
