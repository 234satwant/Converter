#include "parser.h"

int select_format::start_function()
{
	start_end_func("*", 20);
        cout << "Enter the file format you want to convert\n";
        cout << "1 - Convert GNE format to GD\n";
        cout << "2 - Convert GD format to GNE\n";
        cin >> ch;

        cout << "Enter the name of file you want to output\n";
        cin >> f_name;

        if (ch == 1)
             {  exp_f_name = f_name + ".gd";  }
        else if(ch == 2)
             {  exp_f_name = f_name + ".gne";  }

        ofstream f(exp_f_name.c_str(), ios::out);
	return ch;
}

void select_format::start_end_func(string symbol, int times)
{
        for(int n = 0; n < times; n++)
        {
            cout << symbol;
        }
        cout << endl;
}

void select_format::WriteGNEfile_entity(string s[1024], int i)
{
	ifstream read("conv.txt", ios::in);
	string input_str;

	while(!read.eof())
	{
		input_str = "0";
		read >> input_str;

        	ofstream f(exp_f_name.c_str(), ios::app);
        	if ( s[i].compare(input_str.c_str()) == 0)
		{
		   // reverse( input_str.begin(), input_str.end() ) ;
		     f << "\n" << input_str;
		}
	}
	read.close();
}

void select_format::WriteGNEfile_xy(float s[1024], char coordinate, int no)
{
        ofstream f(exp_f_name.c_str(), ios::app);
	if(no < n-1)
        {
	     if (coordinate == 'x')
        	f << "(" << s[no] << ", ";
             else
       		if (no == 2)
f << s[no] << ")]";
else f << s[no] << ")";
	}
}

void select_format::WriteGDfile_entity(string s[1024], int i)
{
	ifstream read("conv.txt", ios::in);
        string input_str;

        while(!read.eof())
        {
                input_str = "0";
                read >> input_str;

                ofstream f(exp_f_name.c_str(), ios::app);
                if ( s[i].compare(input_str.c_str()) == 0)
                        {
			    string neglect = ":";
			    read >> input_str;
			    if(neglect.compare(input_str.c_str()) == 0)
				read >> input_str;
			    f << input_str << "\n";
			}
        }
        read.close();
}

void select_format::WriteGDfile_xy(float s[1024], char coordinate, int no)
{
        ofstream f(exp_f_name.c_str(), ios::app);
	if(no < n-1)
        { f << coordinate << " = " << s[no] << "\n"; }
}

void select_format::WriteGDfile_name(string s[1024], int i)
{
        ofstream f(exp_f_name.c_str(), ios::app);
        if ( i >= 1 && i < 3) { f << s[i+1] << endl; }
	else if (i == 3 ) { f << s[1] << endl; }
	else { f << s[i] << "\n"; }
}

void select_format::WriteGNEfile_name(string s[1024], int i)
{
        ofstream f(exp_f_name.c_str(), ios::app);
        if( i == 1) { f << " " << s[3] << "[" << s[i] << ", " << s[i+1] << "; " << s[i]; }
	else if ( i == 0 ) { f << " " << s[i]; }
	else if ( i == 2){ f << ", " <<  s[i]; }
}

