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
        int ch, t_no, flag, flag2;
	float    x_coord [1024];
	float    y_coord [1024];
	string   entity_type [1024];
	string   entity_name [1024];

	select_format()
	{    t_no = 0;	}

        int start_function();
	int total_values(int no_of_values);
	void start_end_func(string symbol, int times);
        void WriteGNEfile_entity(string s[1024], int i);
        void WriteGNEfile_xy(float s[1024], char coordinate, int no);
        void WriteGNEfile_name(string s[1024], int i);
        void WriteGDfile_entity(string s[1024], int i);
        void WriteGDfile_xy(float s[1024], char coordinate, int no);
        void WriteGDfile_name(string s[1024], int i);
	void Store_values_xy(float s, int i, char xy);
	void Store_values_nametype(string s, int i, char nt);
	void Write_file();
};
#endif

