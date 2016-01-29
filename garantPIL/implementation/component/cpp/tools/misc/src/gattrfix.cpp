#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: gattrfix.cpp,v 2.19 2014/08/06 10:23:26 young Exp $
 */


#include <cstring>

#include "base.h"
#include "stdbase.h"
#include "garutils.h"
#include "gardefs.h"
#include "dociter.h"
#include "stringz.h"

#include "garver.h"
#include "basemask.h"
#include "StorableSplaySet.h"

int g_pStrAttrs [] = { IDD_NAME, IDD_ID, IDD_SOURCE, IDD_DIV, IDD_KEY, IDD_TYPE,
                       IDD_RCODE, IDD_WARNING, IDD_CATEGORY, IDD_PUBLISHEDIN, IDD_TERRITORY, IDD_DOCKIND, IDD_NONE };

int g_pDateAttrs [] = { IDD_DATE, IDD_VINCLUDED, IDD_VCHANGED, IDD_VABOLISHED,
						IDD_RDATE, IDD_SORTDATE, IDD_VANONCED, IDD_VLCONTROL, IDD_NONE };

int g_pSubsAttrs [] = { IDD_SUBS, IDD_NONE };	//SubDesc's
int g_pIntAttrs [] = { IDD_BASES, IDD_BLOB, IDD_NONE };	// int's

static int check_ready_status(Base *, const char *name);

///////////////////

int fixStrStream ( Base* base, const char* indName, long strId )
{
	Index* ind = base->FindIndex ( indName );
	if ( !ind ) return 0;
	
	for ( BTIterator it (ind); !it.End(); ++it ) {
		const void* key = it.Key();

		Stream* str = ind->Index::OpenN ( key, strId );

		if ( str && str->Length() ) {
			char* data = (char*) malloc ( str->Length() + 1 );
			assert ( data );

			str->Read ( data, str->Length() );
			data[str->Length()] = 0;

			StringZ aStrZ ( data, str->Length(), 0 );
			aStrZ.EnableHide();

			if ( !aStrZ.HasDoublicates () ) {
				free(data);

				ind->Close(str);
				continue;
			}

			printf ( "In Index %s, bad stream N %d\t....", indName, strId );
			
			aStrZ.HideDoublicates ();
			str->Seek(0);

			while ( !aStrZ.End () )
			{
				if ( !(aStrZ.GetAttrib ( aStrZ.GetPos () ) & Z_ATTR_HIDE) ) {
					str->Write ( aStrZ(), strlen ( aStrZ () ) + 1 );
				}
				++aStrZ;
			}

			str->Trunc();
			ind->Close(str);
			free ( data );
			
			printf ( "FIXED\n" );
		}
	}

	return 1;
}

int main ( int argc, char** argv )
{
	printf( "GARANT Base's attributes checker v%s (%s %s)\n\n", GARANT_VERSION, __DATE__, __TIME__);

	if ( argc != 2 && argc != 3 ) {
		printf ( "USAGE: %s <base path & name> [-sia]\n", argv[0] );
		exit (EXIT_FAILURE);
	}

	int fixStrAttrs = 1;
	int fixStream = 1;
	int fixSubs = 1;
	
	if ( argc == 3 ) {
		if ( !strcmp(argv[2], "-s" )) {
			printf ( "Fix only Sub attribute\n" );
			fixStrAttrs = 0;
			fixStream = 0;
		} else if ( !strcmp(argv[2], "-a" )) {
			printf ( "Fix only String attribute\n" );
			fixSubs = 0;
			fixStream = 0;
		} else if ( !strcmp(argv[2], "-i" )) {
			printf ( "Fix only Index's String streams\n" );
			fixSubs = 0;
			fixStrAttrs = 0;
		} else {
	                printf ( "USAGE: %s <base path & name> [-sia]\n", argv[0] );
       		        exit (EXIT_FAILURE);
        	}
	}


	Base * pBase = new YBase ( argv [1], ACE_OS_O_RDWR );

	if ( !pBase || !pBase->IsOk () ) {
		printf ( "\nCan't open selected Base (%s)\n", argv [1] );
		exit ( EXIT_FAILURE );
	}

	if(!check_ready_status(pBase, argv[1]))
		return EXIT_FAILURE;

	FILE* pfErrFile = mpcxc_fopen ( "AttrChk.err", "w+t" );
	if ( !pfErrFile ) {
		printf ( "Can't create output file" );
		exit ( EXIT_FAILURE );
	}

	DocIterator aDocIter ( pBase );

	if ( fixStrAttrs || fixStrAttrs ) printf ( "Attributes fixing...\n" );
	if ( fixSubs || fixStrAttrs) while ( !aDocIter.End () ) {
		long lDocId = aDocIter.Id ();
	        ++ aDocIter;
	        if ( lDocId <= ID_BORDER) continue;

		// Check String Attrs
		
		if (fixStrAttrs) for ( int i = 0; g_pStrAttrs [i] != IDD_NONE; i++ ) {
			long iSize;
			char * pAttr = (char*) pBase -> docInd -> Load ( lDocId, g_pStrAttrs[i], iSize );
			if ( iSize == -1 || !iSize || !pAttr ) continue;

			StringZ aStrZ ( pAttr, iSize, 0 );
			aStrZ.EnableHide();

			char pMessage [1204];
			sprintf ( pMessage, "In Doc %ld by AttrTag %d was found duplicated string",
				lDocId, g_pStrAttrs[i] );
			if ( !aStrZ.HasDoublicates ( pfErrFile, pMessage ) ) {
				if (pAttr) free(pAttr);
				continue;
			}

			printf ( "In Doc %ld, bad attributes with tag %d\t....", lDocId, g_pStrAttrs[i] );

			aStrZ.HideDoublicates ();
			long iFixedSize = aStrZ.UnHideSize ( WITH_Z );
			char* pFixedAttr = (char*) malloc ( iFixedSize );
			assert ( pFixedAttr );

			int ii = 0;
			while ( !aStrZ.End () )
			{
				if ( !(aStrZ.GetAttrib ( aStrZ.GetPos () ) & Z_ATTR_HIDE) ) {
					strcpy ( &( pFixedAttr ) [ii], aStrZ() );
					ii += strlen ( aStrZ () );
					pFixedAttr [ii++] = 0;

					assert ( ii <= iFixedSize );
				}
				++aStrZ;
			}

			assert ( pBase->docInd->Replace ( lDocId, g_pStrAttrs[i], pFixedAttr,
				iFixedSize ) == iFixedSize );

			printf ( "FIXED\n" );

			if ( pFixedAttr ) free ( pFixedAttr );
			if ( pAttr ) free ( pAttr );
		}
		
		if ( fixSubs ) for ( int i = 0; g_pSubsAttrs [i] != IDD_NONE; i++ ) {
			StorableSplaySet<SubDesc> subs;
			AttrKey key;
			key.DocId   = lDocId;
			key.AttrTag = g_pSubsAttrs [i];
			
			Stream * str = pBase->docInd->Open ( &key );
			if ( str ) {
				long real_count = str->Length() / sizeof (SubDesc);
				subs.Get ( str );
				
				if ( real_count != subs.length() ) {
					printf ( "In Doc %ld, bad attributes with tag %d\t....", lDocId, g_pSubsAttrs[i] );
					str->Seek (0);
					subs.Put(str);
					str->Trunc();
					printf ( "FIXED\n" );
				}						
				 pBase->docInd->Close ( str );
			}
		}
				
	}
	
	if ( fixStream ) {
		printf ( "Class Index string streams fixing...\n" );
		fixStrStream ( pBase, "Class", 1 );
		printf ( "DocKind Index string streams fixing...\n" );
		fixStrStream ( pBase, "DocKind", 1 );
		printf ( "Adopted Index string streams fixing...\n" );
		fixStrStream ( pBase, "Adopted", 1 );
	}

	fclose ( pfErrFile );
	pBase->SetReady(TID_GATTRCHK);
	delete pBase;

	return 0;
}

static int check_ready_status(Base *pBase, const char *name)
{
	char *s, *missing;
	int16_t x, y;
	u_int32_t status;

	if ((status = pBase->CheckReady(TID_GATTRCHK))) {
		s = missing = GetProcessDescription(status, x, y);
		if (!missing) {
			printf("Base %s has invalid ready status.\n", name);
			return 0;
		}
		printf("Base %s is not ready for attributes fixing.\n", name);
		printf("At least the following programs must be applied to base %s:\n", name);
		do {
			printf("\t%s\n", s);
			s += strlen(s) + 1;
		} while (*s);
		free(missing);
		return 0;
	}
	return 1;
}


