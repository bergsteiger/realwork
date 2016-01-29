#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "newdoc.h"

int main ( int argc, char **argv )
{
	if ( argc < 2 )
		return 0;

	YBase* aBase = new StdBigBase( argv[ 1 ], ACE_OS_O_RDWR );

	DocCollection* allTopics = aBase->AllTopics(ID_BORDER);
	for ( long i = 0; i < allTopics->ItemCount; i++ ) {
		bool mustbreak = false; //!

		long docId = (*allTopics)[i];
		printf( "%ld\r", docId );
		Document* doc = aBase->GetDoc( docId );
		if ( doc && doc->IsOk()) {
			DocInfo docInfo;
			memcpy( &docInfo, &doc->Stat, sizeof( DocInfo ));
			int paracount = doc->Stat.ParaCount;
			char** paras = new char*[ paracount ];
			for ( int j = 0; j < paracount; j++ ) {
				char* apara = doc->GetPara( j );
				int size = ParaSize( apara ) + HeaderSize( apara );
				paras[ j ] = (char*) malloc( size );
				memcpy( paras[ j ], apara, size );
			}
			delete doc;
			aBase->DelText( docId );
			NewDocument *newDoc = new NewDocument( aBase, docId, docInfo.Title, docInfo.Revision, PM_ZIP );
			for ( j = 0; j < paracount; j++ ) {
				char buffer[ MAX_PARA_LEN ]; gk_bzero( buffer, 5 );
				char* para = paras[ j ];
				buffer[ 4 ] = RedLine( para );
				buffer[ 3 ] = RightMargin( para );
				buffer[ 2 ] = LeftMargin( para );
				buffer[ 0 ] = 8;
				char* dest = buffer + 5;
				char* src  = ParaText( para );
				int size  = TextSize( para );
				for ( int ii = 0; ii < size; ) {
					if ( src[ ii ] == AT_XREF ) {
						int savedii = ii;
						ii++;
						while ( src[ ii ] != AT_XREF && ii < size ) ii++;
						if ( ii < size ) {
							char aType = *(src+ii+1);
							int aRefs = GetHTRefCount( *(short*)( src + ii + 2 ));
							int newRefs = 0;
							ii += 4;
							if ( aType == REFTYPE_REFLIST ) {
								for ( int aRef = 0; aRef < aRefs; aRef++, ii += sizeof( Ref )) {
									Ref* atText = (Ref*)(src+ii);
									if ( atText->DocId == docId || aBase->FindDoc( atText->DocId ))
										newRefs++;
								}
							} else {
								newRefs = aRefs;
								ii += sizeof( Ref ) * aRefs;
							}

							if ( aRefs == newRefs ) {
								//все ссылки есть
								aRefs = aRefs;
								for ( int jj = savedii; jj < ii; jj++ ) {
									*dest = src[jj];
									dest++;
								}
							} else if ( newRefs == 0 ) {
								//не осталось ни одной ссылки
								docInfo.HyperRefs -= aRefs;
								int jj = ++savedii;
								while ( src[ jj ] != AT_XREF && jj < size ) {
									*dest = src[jj];
									dest++;
									jj++;
								}
							} else {
								//количество ссылок не совпало
								docInfo.HyperRefs -= ( aRefs - newRefs );
								int jj = savedii;
								*dest++ = src[jj++];
								while ( src[ jj ] != AT_XREF && jj < size ) {
									*dest = src[jj];
									dest++;
									jj++;
								}
								*dest++ = src[jj++]; //ромб
								*dest++ = src[jj++]; //тип ссылки
								*(short*)dest = (short)newRefs;
								dest += 2;
								jj += 2;
								for ( int aRef = 0; aRef < aRefs; aRef++, jj += sizeof( Ref )) {
									Ref* atText = (Ref*)(src+jj);
									if ( atText->DocId == docId || aBase->FindDoc( atText->DocId )) {
										//эту ссылку надо перенест
										memcpy( dest, atText, sizeof( Ref ));
										dest += sizeof( Ref );
									}
								}
							}
						}
					} else {
						*dest = src[ii];
						dest++;
						ii++;
					}
				}

				newDoc->AddPara( ParaStyle( para ), dest - buffer, buffer );
				free( paras[ j ] );
			}
			delete paras;
			delete newDoc;

			long aSize;
			DocInfo* newinfo = (DocInfo*) aBase->LoadAttr( docId, IDD_INFO, aSize );
			newinfo->FirstDate = docInfo.FirstDate;
			newinfo->LastDate = docInfo.LastDate;
			newinfo->Force = docInfo.Force;
			newinfo->HyperRefs = docInfo.HyperRefs;
			newinfo->GreenComments = docInfo.GreenComments;
			newinfo->Status = docInfo.Status;
			newinfo->Related = docInfo.Related;
			newinfo->prevEdition = docInfo.prevEdition;
			newinfo->nextEdition = docInfo.nextEdition;
			newinfo->lastParaID = docInfo.lastParaID;
			newinfo->reserved_short = docInfo.reserved_short;
			newinfo->reserved_short2 = docInfo.reserved_short2;

			aBase->ReplaceAttr( docId, IDD_INFO, newinfo, aSize );
		}
		if ( mustbreak ) break; //!
	}
	printf( "\n" );
	
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



