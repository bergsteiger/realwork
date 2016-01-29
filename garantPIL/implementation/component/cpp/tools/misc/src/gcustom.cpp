#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"

YBase* aBase = 0;

int main ( int argc, char **argv )
{
	if ( argc < 3 )
		return 0;

	aBase = new YBase( argv[ 1 ], ACE_OS_O_RDWR );

	FILE* in = mpcxc_fopen( argv[2], "r" );
	char* result = 0;
	char buffer[ 4096 ];
	while ( fgets( buffer, 4096, in )) {
		if ( result ) {
			result = (char*) realloc( result, strlen( result ) + strlen( buffer ) + 4 );
			strcat( result, "  " );
			result[ strlen( result ) - 2 ] = 13;
			result[ strlen( result ) - 1 ] = 10;
		} else {
			result = (char*) malloc( strlen( buffer ));
			result[0] = 0;
		}
		if ( strlen( buffer ) && buffer[ strlen( buffer ) - 1 ] == 0x0a )
			buffer[ strlen( buffer ) - 1 ] = 0;
		strcat( result, buffer );
	}
	fclose( in );

	Stream* str = aBase->FindIndex("Aux")->OpenN( "DDM", 0, 1 );
	if ( str ) {
		str->Write( result, strlen( result ) + 1 );
		aBase->FindIndex("Aux")->Close(str);
	}

	u_int32_t flags = DDI_FOR_DUMMY;
	str = aBase->FindIndex("Aux")->OpenN( "DDI", 0, 1 );
	if ( str ) {
		str->Write(&flags,sizeof(u_int32_t));
		aBase->FindIndex("Aux")->Close(str);
	}

	delete aBase;
	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}




