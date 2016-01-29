//argsutils.cc // deep copy
#include "argsutils.h"

#include <fstream.h>
#include <cstring>

#ifndef __GO32__
	#include <String.h>
#else
	#include <_String.h>
#endif


void readArgs( int &argc, char ** &argv )
{

	int tl = 0;
	int n = 0;
	{
	#ifdef __GO32__
		std::ifstream ifs( argv[1] +1 );
	#else
		std::ifstream ifs( argv[1] );
	#endif
		{
			while( ifs ){
				String t;
				ifs >> t;
				if( t.length() ){
					tl += t.length() +1;
					n++;
				}
			}
		}
	}
	char ** nargv = new char *[ argc + n ]; // don't need current arg
	nargv[0] = argv[0];
	for( int i=1; i< argc -1 ; i++ )
		nargv[i] = argv[i +1];
	
	char * na = new char [ tl ];
#ifdef __GO32__
	std::ifstream ifs( argv[1] +1 );
#else
	std::ifstream ifs( argv[1] );
#endif
	for( int i = argc-1; (i< argc + n - 1) && ifs; i++ ){
		String t;
		ifs >> t;
		if( t.length() ){
			strcpy( na, t.chars() );
			nargv[i] = na;
			na += t.length() +1;
		}
	}
	argc += n-1;
	argv = nargv;
	argv[ argc ] = 0;
}
int getYNarg(const char *a, const char *v)
{
	int mean = 1;
	if( a[0] && a[0] == 'n' ){
		if( a[1] && a[1] == 'o' ){
			if( a[2] && a[2] == '-' ){
				mean =0;
				a+=3;
			}
		}
	}
	if ( strcmp(a, v) == 0 )
		return mean;
	else
		return -1;

}


