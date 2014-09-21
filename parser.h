#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <string>
#include <fstream>

using namespace std;

class select_format
{
	string exp_f_name, f_name;
	public : int n;
       // public:
        int ch;
	float    x_coord [1024];
	float    y_coord [1024];
	string   entity_type [1024];
	string   entity_name [1024];

        int start_function();
	int total_values(int no_of_values)
	{
	    n = no_of_values;
	    return n;
	}
void select_format1()
{
for (int i = 0; i < 3; i++)
	cout << x_coord[i] << "		" << y_coord[i] << endl;
}
	void start_end_func(string symbol, int times);
        void WriteGNEfile_entity(std::string s);
        void WriteGNEfile_xy(float s[1024], char coordinate, int no);
        void WriteGDfile_entity(std::string s);
        void WriteGDfile_xy(float s[1024], char coordinate, int no);
	void Store_values_xy(float s, int i, char xy)
	{
	    if ( xy == 'x')
		{ x_coord[0] == s; cout << x_coord[0] << endl;}
	    else 
		{ y_coord[i] == s; }
	}
	void Write_file()
	{	select_format1();
	    if( ch == 2)
	    {
		for(int i = 0; i <= n; i++)
		{
		 //   WriteGNEfile_entity(entity_type);
        	    WriteGNEfile_xy(x_coord, 'x', i);
		    WriteGNEfile_xy(y_coord, 'y', i);
		}
	    }
	    else
	    {
		for(int i = 0; i <= n; i++)
		{
//                  WriteGDfile_entity(entity_type);
                    WriteGDfile_xy(x_coord, 'x', i);
                    WriteGDfile_xy(y_coord, 'y', i);
                }
	    }
	}
};
#endif

