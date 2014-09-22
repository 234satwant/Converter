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

	void start_end_func(string symbol, int times);
        void WriteGNEfile_entity(string s[1024], int i);
        void WriteGNEfile_xy(float s[1024], char coordinate, int no);
        void WriteGNEfile_name(string s[1024], int i);
        void WriteGDfile_entity(string s[1024], int i);
        void WriteGDfile_xy(float s[1024], char coordinate, int no);
        void WriteGDfile_name(string s[1024], int i);

	void Store_values_xy(float s, int i, char xy)
	{
	    if ( xy == 'x')
		{ x_coord[i] = s; }
	    else 
		{ y_coord[i] = s; }
	}

	void Store_values_nametype(string s, int i, char nt)
	{
	    if(nt == 't')
		{ entity_type[i] = s; }
	    else
		{ entity_name[i] = s; cout << entity_name[i] << "       " << i <<endl; }
	}

	void Write_file()
	{
	    if( ch == 2)
	    {
		for(int i = 0; i < n; i++)
		{
		    WriteGNEfile_entity(entity_type, i);
        	    WriteGNEfile_xy(x_coord, 'x', i);
		    WriteGNEfile_xy(y_coord, 'y', i);
                    WriteGNEfile_name(entity_name, i);
		}
	    }
	    else
	    {
		for(int i = 0; i < n; i++)
		{
                    WriteGDfile_entity(entity_type, i);
                    WriteGDfile_xy(x_coord, 'x', i);
                    WriteGDfile_xy(y_coord, 'y', i);
	            WriteGDfile_name(entity_name, i);
                }
	    }
	}
};
#endif

