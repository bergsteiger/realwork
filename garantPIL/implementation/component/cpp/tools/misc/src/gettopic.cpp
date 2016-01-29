#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "recode.h"

void	DumpAttr( char* attr, long size, char* prefix, bool wsub = true, bool hier = true ) {
	long pos = 0;
	while ( pos < size ) {
		long sub = 0;
		if ( wsub ) sscanf( attr, "%ld:", &sub );
		if ( !sub ) {
			Recoding( cd_win, cd_dos, attr );
			if ( hier ) {
				printf( "%s ", prefix );
				char* attr2 = attr;
				if ( wsub ) attr2 = strchr( attr, ':' ) + 1;
				if ( hier ) attr2 += 3;
				while ( *attr2++ ) {
					printf( "%c", *attr2 );
					if ( *attr2 == '\\' ) attr2 += 4;
				}
				printf( "\n" );
			} else {
				printf( "%s %s\n", prefix, attr );
			}
		}
		pos += strlen( attr ) + 1;
		attr += strlen( attr ) + 1;
	}
}

char	belongstbl[256][9];

void	ReadBelongs( char* filename )
{
	FILE* in = mpcxc_fopen( filename, "r" );
	char buffer[ 512 ];
	while ( fgets( buffer, 512, in )) {
		char	name[ 9 ];
		long	belongs;
		sscanf( buffer, " %ld %s", &belongs, name );
		strcpy( belongstbl[ belongs ], name );
	}
	fclose( in );
}

void	DumpBelongs( short* belongs, long size )
{
	printf( "!BELONGS " );
	size /= 2;
	for ( long i = 0; i < size; i++ ) {
		printf( "%s", belongstbl[ belongs[i]] );
		if ( i < size - 1 ) printf( "\\" );
	}
	printf( "\n" );
}

void	DumpDates( date* dates, long size )
{
	size /= sizeof( date );
	for ( long i = 0; i < size; i++ ) {
		date* d = &dates[i];
		printf( "!DATE %02d/%02d/%04d\n",
			(int) ((date*) d) -> da_day,
			(int) ((date*) d) -> da_mon,
			(int) ((date*) d) -> da_year );
	}
}

int main ( int argc, char **argv )
{
	if ( argc < 4 )
		return 0;

	YBase* aBase = new YBase( argv[ 1 ], ACE_OS_O_RDONLY );
	ReadBelongs( argv[ 3 ] );
	FILE* in = mpcxc_fopen( argv[ 2 ], "r" );
	char buffer[ 4096 ];
	while ( fgets( buffer, 4096, in )) {
		long docId;
		//sscanf( buffer, "!ANNOTOPIC %ld", &docId );
		sscanf( buffer, "%ld", &docId );
		docId += ID_BORDER;
		DocInfo docInfo;
		if ( aBase->FindDocInfo( docId, docInfo ) == sizeof( DocInfo )) {
			Recoding( cd_win, cd_dos, docInfo.Title );
			printf( "!TOPIC %ld %s\n", docId-ID_BORDER, docInfo.Title );

			long size;
			short* belongs = (short*) aBase->LoadAttr( docId, IDD_BASES, size );
			DumpBelongs( belongs, size ); gk_free( belongs );

			char name[DOC_NAME_SIZE]; size = aBase->FindDocName( docId, name );
			DumpAttr( name, size, "!NAME", false, false );

			char* type = (char*) aBase->LoadAttr( docId, IDD_TYPE, size );
			DumpAttr( type, size, "!TYPE" ); gk_free( type );

			char* source = (char*) aBase->LoadAttr( docId, IDD_SOURCE, size );
			DumpAttr( source, size, "!SOURCE", false ); gk_free( source );

			char* dates = (char*) aBase->LoadAttr( docId, IDD_DATE, size );
			if ( size ) {
				DumpDates( (date*)dates, size );
				gk_free( dates );
			}

			char* number = (char*) aBase->LoadAttr( docId, IDD_ID, size );
			DumpAttr( number, size, "!CODE", false, false ); gk_free( number );
		}
		printf( "\n" );
	}
	fclose(in);

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



