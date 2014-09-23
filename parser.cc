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
        string input_str1, input_str2, neglect;

        while(!read.eof())
        {
                read >> input_str1 >> neglect >> input_str2;
                ofstream f(exp_f_name.c_str(), ios::app);
                if ( s[i].compare(input_str2.c_str()) == 0)
                        {
                            f << "\n" << input_str1; break;
                        }
        }
        read.close();

}

void select_format::WriteGNEfile_xy(float s[1024], char coordinate, int no)
{
        ofstream f(exp_f_name.c_str(), ios::app);
	if (coordinate == 'x')
            f << "(" << s[no] << ", ";
        else
	    f << s[no] << ")";
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
        f << coordinate << " = " << s[no] << "\n";
}

void select_format::WriteGDfile_name(string s[1024], int i)
{
        ofstream f(exp_f_name.c_str(), ios::app);
	f << s[i] << "\n";
}

void select_format::WriteGNEfile_name(string s[1024], int i)
{
        ofstream f(exp_f_name.c_str(), ios::app);
/*        if( i == 1) { f << " " << s[3] << "[" << s[i] << ", " << s[i+1] << "; " << s[i]; }
	else if ( i == 0 ) { f << " " << s[i]; }
	else if ( i == 2){ f << ", " <<  s[i]; }
*/
	f << " " << s[i];
}

int select_format::total_values(int no_of_values)
{
	n = no_of_values;
        return n;
}

void select_format::Store_values_xy(float s, int i, char xy)
{
	if ( xy == 'x')
	    { x_coord[i] = s; }
	else 
	    { y_coord[i] = s; }
}

void select_format::Store_values_nametype(string s, int i, char nt)
{
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

void select_format::Write_file()
{
	if( ch == 2)
	{
	    for(int i = 0; i < n; i++)
	    {
		WriteGNEfile_entity(entity_type, i);
		if(entity_type[i] != "")
		{
		    int k = i+1;
		    while( entity_type[k] == "" && k <= n)
		    {	
			WriteGNEfile_name(entity_name, k);
			k++;
		    }
		    WriteGNEfile_name(entity_name, i);
		}
//                WriteGNEfile_name(entity_name, i);
		if(x_coord[i] != 0L || y_coord[i] != 0L)
		{
        	    WriteGNEfile_xy(x_coord, 'x', i);
		    WriteGNEfile_xy(y_coord, 'y', i);
		}
		if(entity_type[i] == "" && entity_type[i+1] != "")
		{
		    ofstream f(exp_f_name.c_str(), ios::app);
		    f << "]";
		}
		else if(i == n-1)
		{
                    ofstream f(exp_f_name.c_str(), ios::app);
                    f << "]";
                }
	    }
	}
	else
	{
	    for(int i = 0; i < n; i++)
	    {
                WriteGDfile_entity(entity_type, i);

		if(entity_type[i] == "" && entity_type[i+1] != "")
		{
		    for(int j = n; j > i; j--)
		    {
			x_coord[j+1] = x_coord[j];
			y_coord[j+1] = y_coord[j];
		    }
		}

		if(entity_type[i] != "")
		{
		    int k = i+1;
                    WriteGDfile_xy(x_coord, 'x', i);
                    WriteGDfile_xy(y_coord, 'y', i);
		    while (entity_type[i+1] == "" && k < n)
		    {
			WriteGDfile_name(entity_name, k);
			if(x_coord[k] != 0L || y_coord[k] != 0L)
			{
                	    WriteGDfile_xy(x_coord, 'x', k);
                	    WriteGDfile_xy(y_coord, 'y', k);
                	}

			k++;
		    }
		    WriteGDfile_name(entity_name, i);
		}
             }
	}
}

