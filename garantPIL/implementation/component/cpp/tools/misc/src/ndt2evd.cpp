#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>
#include <windows.h>

#include "osdep.h"
#include "stdbase.h"
#include "garver.h"
#include "gardefs.h"
#include "newdoc.h"

int	FileExist( char *name )
{
	WIN32_FIND_DATA findData;
	HANDLE	aResult = FindFirstFile( name, &findData );
	FindClose( aResult );
	return aResult != INVALID_HANDLE_VALUE;
}

int main ( int argc, char **argv )
{
	if ( argc < 2 )
		return 0;
	
	char	aBuffer[ 8198 ];
	gk_bzero( aBuffer, sizeof( aBuffer ));

	YBase* aBase = new YBase( argv[ 1 ], ACE_OS_O_RDWR );
	DocCollection* allTopics = aBase->AllTopics( ID_BORDER );
	
	for ( long I = 0; I < allTopics->ItemCount; I++ ) {
		long id = (*allTopics)[ I ];
		printf( "Topic %ld, %d%%\r", id, (( I + 1 ) * 100 ) / allTopics->ItemCount );

		long aSize;
		DocInfo *info = (DocInfo*) aBase->docInd->Load( id, IDD_INFO, aSize );

		char	aFileName[ MAX_PATH ];
		sprintf( aFileName, "test_%ld.evd", id );
		if ( !FileExist( aFileName ))
			continue;

		aBase->DelText( id );

		NewDocument *newDoc = new NewDocument( aBase, id, info->Title, info->Revision, PM_ZIP );

		FILE* aEVD = mpcxc_fopen( aFileName, "rb" );
		int J = 0;
		while ( !feof( aEVD ) ) {
			gk_bzero( aBuffer, sizeof( aBuffer ));
			size_t aBytes = fread( aBuffer + 5, 1, 8192, aEVD );
			aBuffer[ 5 + aBytes ] = '\0';

			char* para = aBuffer;
			int paraLen = aBytes + 5;
			*para = 8;
			*(long*) ( para + 1 ) = 0;
			newDoc -> AddPara( PS_EVD, paraLen, para );
		}
		fclose( aEVD );

		delete newDoc;
		DocInfo* newinfo = (DocInfo*) aBase->docInd->Load( id, IDD_INFO, aSize );
		newinfo->FirstDate = info->FirstDate;
		newinfo->LastDate = info->LastDate;
		newinfo->Force = info->Force;
		newinfo->HyperRefs = info->HyperRefs;
		newinfo->GreenComments = info->GreenComments;
		newinfo->Status = info->Status | DS_EVD;
		newinfo->Related = info->Related;
		newinfo->prevEdition = info->prevEdition;
		newinfo->nextEdition = info->nextEdition;
		newinfo->lastParaID = info->lastParaID;
		newinfo->reserved_short = info->reserved_short;
		newinfo->reserved_short2 = info->reserved_short2;

		aBase->docInd->Replace( id, IDD_INFO, newinfo, aSize );
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



