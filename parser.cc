#include "parser.h"

select_format::select_format()
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
}

void select_format::start_end_func(string symbol, int times)
{
        for(int n = 0; n < times; n++)
        {
            cout << symbol;
        }
        cout << endl;
}

void select_format::WriteGNEfile_entity(std::string s)
{
        ofstream f(exp_f_name.c_str(), ios::app);
        if ( s.compare("POINT") == 0)
             {  f << "\nBINDU";  }
        else if ( s.compare("LINE") == 0)
             {  f << "\nREKHA";  }
}

void select_format::WriteGNEfile_xy(float s, char coordinate)
{
        ofstream f(exp_f_name.c_str(), ios::app);
        if (coordinate == 'x')
             f << " (" << s << ", ";
        else
             f << s << ") ";
}

void select_format::WriteGDfile_entity(std::string s)
{
        ofstream f(exp_f_name.c_str(), ios::app);
        if ( s.compare("BINDU") == 0)
             {  f << "POINT\n";  }
        else if ( s.compare("REKHA") == 0)
             {  f << "\nLINE\n";  }
}

void select_format::WriteGDfile_xy(float s, char coordinate)
{
        ofstream f(exp_f_name.c_str(), ios::app);
        f << coordinate << " = " << s << "\n";
}
