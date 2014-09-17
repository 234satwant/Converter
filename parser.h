#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <string>
#include <fstream>

using namespace std;

class select_format
{
	string exp_f_name, f_name;

        public:
        int ch;

        select_format();
	void start_end_func(string symbol, int times);
        void WriteGNEfile_entity(std::string s);
        void WriteGNEfile_xy(float s, char coordinate);
        void WriteGDfile_entity(std::string s);
        void WriteGDfile_xy(float s, char coordinate);
};
#endif

