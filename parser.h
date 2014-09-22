#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <string>
#include <fstream>
#include <algorithm>

using namespace std;

class select_format
{
	string exp_f_name, f_name;
	public : int n;
        int ch, t_no, flag;
	float    x_coord [1024];
	float    y_coord [1024];
	string   entity_type [1024];
	string   entity_name [1024];

	select_format()
	{
	    t_no = 0; 
	//    flag = 0;
	}

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
	{	flag = 0;
	    if(nt == 't')
	    {
		entity_type[i] = s;
		if(t_no <= i)
		    { t_no++; }
	    }
	    else
	    {
		for(int l = t_no; l < i; l++)
		{
		    if(entity_name[l] == s)
                        { flag++; }
		}
		if(!flag)
		{ entity_name[i] = s; }
	    }
	}

	void Write_file()
	{
	    if( ch == 2)
	    {
		for(int i = 0; i < n; i++)
		{
		    WriteGNEfile_entity(entity_type, i);
                    WriteGNEfile_name(entity_name, i);
        	    WriteGNEfile_xy(x_coord, 'x', i);
		    WriteGNEfile_xy(y_coord, 'y', i);
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

