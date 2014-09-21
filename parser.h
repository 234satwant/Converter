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
		cout << "n = " << n << endl;
	    return n;
	}

	void start_end_func(string symbol, int times);
        void WriteGNEfile_entity(std::string s);
        void WriteGNEfile_xy(float s[1024], char coordinate, int no);
        void WriteGDfile_entity(std::string s);
        void WriteGDfile_xy(float s, char coordinate);
	void Write_file()
	{
		for(int i = 0; i <= n; i++)
		{ cout << x_coord[i] << "	hello	" << i << endl;
//		    WriteGNEfile_entity(entity_type);
        	    WriteGNEfile_xy(x_coord, 'x', i);
		    WriteGNEfile_xy(y_coord, 'y', i);
		}
	}
};
#endif

