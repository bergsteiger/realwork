#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#define	DOTPOS	73
#define	MAXPOS	150

int main ( int argc, char **argv )
{
	if ( argc < 2 )
		return 0;

	YBase* aBase = new YBase( argv[ 1 ], ACE_OS_O_RDWR );

	printf( "get AllTopics()\n" );
	DocCollection* allTopics = aBase->AllTopics(ID_BORDER);
	printf( "Count: %ld topics\n", allTopics->ItemCount );

	for ( long I = 0; I < allTopics->ItemCount; I++ ) {
		long docId = (*allTopics)[I];
		Document* aDoc = aBase->GetDoc(docId);
		if ( !aDoc ) continue;

		printf( "Processing topic %ld (%d%%)\r", docId, ( ( I + 1 ) * 100 ) / allTopics->ItemCount );

		long lSubCount;
		SubDesc* subs = (SubDesc  *) aBase->docInd->Load( docId, IDD_SUBS, lSubCount );
		lSubCount = lSubCount / sizeof( SubDesc );
		
		for ( long L = 0; L < lSubCount; L++ ) {
			if ( subs[ L ].Sub < 0 )
				continue;

			Ref ref = { docId, subs[ L ].Sub };
		    Stream* str = aBase->subNames->Open( &ref );
			if ( str )
				aBase->subNames->Close(str);
			else {
				long lPara = subs[ L ].Para;
				char* aPara = aDoc->GetPara( lPara );
				while ( lPara < aDoc->Stat.ParaCount && !TextSize( aPara ))
					aPara = aDoc->GetPara( ++lPara );

				if ( lPara == aDoc->Stat.ParaCount )
					continue;

				int aSize = aDoc->EVDTextSize( aPara );
				unsigned char* ptr = (unsigned char*) aDoc->EVDParaText( aPara );

				char aSubName[ 256 ];
				gk_bzero( aSubName, sizeof( aSubName ));
				int aSubNamePos = 0;

				bool	aDotFound = false;
				for ( int i = 0; i < aSize && aSubNamePos < MAXPOS && !aDotFound; ) {
					if ( ptr[ i ] == AT_XREF ) {
						i++;
						while ( ptr[ i ] != AT_XREF && i < aSize ) {
							if ( aSubNamePos < MAXPOS && ( ptr[ i ] > 32 || ( ptr[ i ] == 32 && aSubNamePos ))) {
								aSubName[ aSubNamePos ] = ptr[ i ];
								aDotFound = ( strchr( ".!?", ptr[ i ] ) != 0 ) && ( aSubNamePos > DOTPOS );
								aSubNamePos++;
							}
							i++;
						}
						if ( i < aSize ) {
							int aRefs = GetHTRefCount( *(short*)( ptr + i + 2 ));
							i += 4;
							i += aRefs * sizeof( Ref );
						}
					} else {
						if ( ptr[ i ] > 32 || ( ptr[ i ] == 32 && aSubNamePos )) {
							aSubName[ aSubNamePos ] = ptr[ i ];
							aSubNamePos++;
							aDotFound = ( strchr( ".!?", ptr[ i ] ) != 0 ) && ( aSubNamePos > DOTPOS );
						}
						i++;
					}
				}

				if ( aSubNamePos ) {
					if ( !aDotFound ) {
						aSubNamePos--;
						while ( aSubNamePos > DOTPOS && strchr( ",-;: ", aSubName[ aSubNamePos ] ) == 0 )
							aSubName[ aSubNamePos-- ] = 0;
						if ( aSubName[ aSubNamePos ] == ' ' ) {
							aSubName[ aSubNamePos-- ] = '\0';
						} else aSubNamePos++;
					}
					Stream  *str = aBase->subNames->Open( &ref, 1 );
					if( str ) {
						str->Write( aSubName, aSubNamePos+1 );
						aBase->subNames->Close(str);
					}
				}
			}
		}

		gk_free( subs );
		delete aDoc;
	}

	printf( "\nClose base\n" );
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




