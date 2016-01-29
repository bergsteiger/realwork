#include "shared/Core/fix/mpcxc.h"
// test cvs deep copy
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "stdbase.h"
#include "garver.h"
#include "gardefs.h"
#include "btiter.h"
#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"

struct editionStruct {
	long id;
	long doc;
}__PACKED__;

int main ( int argc, char **argv )
{
	if ( argc < 2 )
		return 0;
	
	printf( "open base\n" ); fflush(stdout);
	StdBigBase* aBase = new StdBigBase( argv[ 1 ], ACE_OS_O_RDWR );
	Index *auxInd = aBase->FindIndex( "Aux" );
	if ( !auxInd ) {
		delete aBase;
		return 0;
	}

	DocCollection *allDocs = new DocCollection();
	DocCollection realDocs;
	u_int32_tcaddr_tSplayMap *edts = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );
	u_int32_tcaddr_tSplayMap *queue = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );

	static const AttrKey key = { ID_BORDER, IDD_INFO };
	BTIterator* it = new BTIterator( aBase -> docInd, &key );
	for ( ; !it->End (); ++(*it) ) {
		AttrKey * ptr = (AttrKey *) it->Key();

		if ( ptr -> AttrTag == IDD_INFO ) {
			allDocs -> Collection::Add( &ptr->DocId );
			Stream *str = aBase -> docInd -> Open( ptr );
			if ( str ) {
				DocInfo docInfo;
				str->Read( &docInfo, sizeof( DocInfo ));
				aBase->docInd->Close(str);

				if ( docInfo.Status & DS_DOC )
					realDocs.Collection::Add( &ptr->DocId );

				long prevEdition = docInfo.prevEdition;
				if ( prevEdition ) {
					StorableSplaySet<long>* nc = (StorableSplaySet<long>*)(*edts)[prevEdition];
					if ( !nc ) {
						nc = new StorableSplaySet<long>;
						(*edts)[prevEdition] = (caddr_t) nc;
					}
					nc->add(ptr->DocId);
				}
			}
		}
		else
			break;
	}

	editionStruct* fastEditions = 0;
	long editionsCount = 0;
	for ( Point p = edts->first(); p; edts->next(p) ) {
		long id = edts->key(p);

		long docPos = realDocs.IndexOf( &id );
		if ( docPos == -1 ) {
			//натолкнулись на редакцию
			StorableSplaySet<long>* nc = (StorableSplaySet<long>*)(edts->contents(p));
			if ( !nc ) continue; //последн€€ редакци€ в цепочке
			long nextid = (*nc)(nc->first());
			long realdoc = 0;
			while ( true ) {
				docPos = realDocs.IndexOf( &nextid );
				if ( docPos != -1 ) {
					realdoc = nextid;
					//уперлись в документ
					break;
				} else {
					nc = (StorableSplaySet<long>*)((*edts)[nextid]);
					if ( !nc ) break;
					nextid = (*nc)(nc->first());
				}
			}
			
			//printf( "edition: %ld, doc: %ld\n", id, realdoc );
			fastEditions = (editionStruct*)realloc( fastEditions, sizeof( editionStruct ) * ( editionsCount + 1 ));
			fastEditions[editionsCount].id = id;
			fastEditions[editionsCount].doc = realdoc;
			editionsCount++;
			
			nc = (StorableSplaySet<long>*)(*queue)[realdoc];
			if ( !nc ) {
				nc = new StorableSplaySet<long>;
				(*queue)[realdoc] = (caddr_t) nc;
			}
			nc->add(id);
		} else {
			//натолкнулись на документ
			long realdoc = id;
			long nextid  = id;
			while ( true ) {
				StorableSplaySet<long>* nc = (StorableSplaySet<long>*)((*edts)[nextid]);
				if ( !nc ) break;

				nextid = (*nc)(nc->first());
				//printf( "future edition: %ld, doc: %ld\n", nextid, realdoc );
				fastEditions = (editionStruct*)realloc( fastEditions, sizeof( editionStruct ) * ( editionsCount + 1 ));
				fastEditions[editionsCount].id = nextid;
				fastEditions[editionsCount].doc = realdoc;
				editionsCount++;

				nc = (StorableSplaySet<long>*)(*queue)[realdoc];
				if ( !nc ) {
					nc = new StorableSplaySet<long>;
					(*queue)[realdoc] = (caddr_t) nc;
				}
				nc->add(nextid);
			}

		}
	}

	char* aKey = "Edis";
	auxInd->Delete( aKey );
	Stream *str = auxInd->Open( aKey, 1 );
	str->Write( fastEditions, sizeof( editionStruct ) * editionsCount );
	auxInd->Close( str );
		
	
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




