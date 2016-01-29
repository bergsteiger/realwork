#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"

YBase* aBase = 0;

long	ParaToUniquePara( Ref aRef )
{
	long *aIDs = 0;
	long aSize;

	aIDs = (long*) aBase->docInd->Load( aRef.DocId, IDD_PARAIDS, aSize );
	aSize /= sizeof( long );

	long aResult = 0;
	if ( aRef.Sub < aSize )
		aResult = aIDs[ aRef.Sub ];

	if ( aIDs ) gk_free( aIDs );

	return aResult;
}

struct editionStruct {
	long id;
	long doc;
}__PACKED__;

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	aBase = new StdBigBase( argv[ 1 ], ACE_OS_O_RDWR );

	static AttrKey	attrKey = { ID_BORDER, IDD_INFO };
	DocCollection* allDocs = 0;

	DocCollection realDocs;

	u_int32_tcaddr_tSplayMap *edts = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );
	u_int32_tcaddr_tSplayMap *queue = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );

	allDocs = new DocCollection();
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
	Point p;
	for ( p = edts->first(); p; edts->next(p) ) {
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

	long docsinqueuecount = 0;
	long* docsinqueue = 0;
	for ( p = queue->first(); p; queue->next(p) ) {
		long id = queue->key(p);
		docsinqueue = (long*)realloc( docsinqueue, (docsinqueuecount+1)*sizeof(long));
		docsinqueue[docsinqueuecount++] = id;
		//printf( "doc: %ld, queue: ", id );
		StorableSplaySet<long>* nc = (StorableSplaySet<long>*)(queue->contents(p));
		for ( Point q = nc->first(); q; nc->next(q) )
			;//printf( "%ld ", nc->contents(q) );
		//printf( "\n" );
	}

	for ( long i = 0; i<docsinqueuecount; i++ ) {
		long id = docsinqueue[i];
		StorableSplaySet<long>* nc = (StorableSplaySet<long>*)(*queue)[id];
		nc->add(id);
		for ( Point q = nc->first(); q; nc->next(q )) {
			long newid = nc->contents(q);
			StorableSplaySet<long>* nc2 = (StorableSplaySet<long>*)(*queue)[newid];
			if ( !nc2 ) {
				nc2 = new StorableSplaySet<long>;
				(*queue)[newid] = (caddr_t) nc2;
			}
			nc2->add(id);
			for ( Point p = nc->first(); p; nc->next(p))
				nc2->add(nc->contents(p));
		}
	}
		
	free(docsinqueue); 

	Index* newCorr = aBase->FindIndex("NewCorr");
	Index* blobs   = aBase->FindIndex("Blob");

	bool enumParas = ( aBase->GetReady() & TM_ENUMPARAS ) ? true : false;
	if ( enumParas )
		printf( "Correspondent/NewCorr with unique para ids\n" );

	u_int32_tcaddr_tSplayMap *newCorrs = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );

	long aTopics = allDocs->ItemCount;
	printf( "%ld\n0\r", aTopics );
	fflush(stdout);
	long aPerc = aTopics / 100L;
	long aCurrPerc = 0;
	long aaPerc = 0;

	for ( long I = 0; I < aTopics; I++ ) {
		long docId = (*allDocs)[I];

		aCurrPerc++;
		if ( aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc );
			fflush(stdout);
		}

		DocInfo docInfo;
		aBase->FindDocInfo(docId,docInfo);

		Document* aDoc = aBase->GetDoc(docId);
		if ( !aDoc ) continue;

		StorableSplaySet<RespRef> *refs = 0;
		refs = new StorableSplaySet<RespRef>;

		char*	blobInfos = 0;
		long	blobSize  = 0;
		
		long *aIDs = 0;
		long aSize;

		if ( enumParas ) {
			aIDs = (long*) aBase->docInd->Load( docId, IDD_PARAIDS, aSize );
			aSize /= sizeof( long );
		}

		for ( long aPara = 0; aPara < aDoc->Stat.ParaCount; aPara++ ) {
			char*	ptr = aDoc -> GetPara( aPara );
			if ( !ptr ) continue;

			int	Size = TextSize( ptr );
			ptr = ParaText( ptr );

			short	offset = 0;
			for ( int i = 0; i < Size; )
				if ( ptr[ i ] == AT_XREF ) {
					i++;
					while ( ptr[ i ] != AT_XREF && i < Size ) i++;
					if ( i < Size ) {
						char aType = *(ptr+i+1);
						int aRefs = GetHTRefCount( *(short*)( ptr + i + 2 ));
						i += 4;
						for ( int aRef = 0; aRef < aRefs; aRef++, i += sizeof( Ref )) {
							if ( aType == REFTYPE_REFLIST && ( ( docInfo.Status & DS_DOC ) || ( docInfo.Status & DS_EDITION ))) {
								Ref* atText = (Ref*)(ptr+i);

								bool may = true;
								if ( atText->DocId == docId )
									may = false;
								else
								if ( queue->contains(docId)) {
									StorableSplaySet<long>* nc = (StorableSplaySet<long>*)(*queue)[docId];
									if ( nc->contains( atText->DocId ))
										may = false;
								}

								CorrRef corrRef = { atText->Sub, docId, aPara };
								if ( enumParas ) {
									if ( aPara < aSize )
										corrRef.Para = aIDs[ aPara ];
									else
										corrRef.Para = 0;

									RespRef respRef = { corrRef.Para, offset, atText->DocId, atText->Sub };
									refs->add( respRef );
								}

								if ( may ) {
									StorableSplaySet<CorrRef>* nc = (StorableSplaySet<CorrRef>*)(*newCorrs)[atText->DocId];
									if ( !nc ) {
										nc = new StorableSplaySet<CorrRef>;
										(*newCorrs)[atText->DocId] = (caddr_t) nc;
									}
									nc->add(corrRef);
								}
							} else
							if ( aType == REFTYPE_BLOB ) {
								ObjKey* atText = (ObjKey*)(ptr+i);
								BlobInfo *info;
								
								Stream* str = blobs->Open( &atText->id );
								long aStrLen = 0;
								if ( str ) {
									ObjInfo objInfo;
									str->Read( &objInfo, sizeof( objInfo ));
									str->Seek( sizeof( objInfo ) + objInfo.size );
									str->Read( &aStrLen, sizeof( aStrLen ));
									if ( aStrLen > 1 ) {
										info = (BlobInfo*) malloc( sizeof( long ) + aStrLen );
										str->Read( info->Name, aStrLen );
										info->Name[ aStrLen-1 ] = '\0';
									} else
										aStrLen = 0;
									blobs->Close(str);
								}
								if ( !aStrLen ) {
									aStrLen = strlen( "Unknown name" ) + 1;
									info = (BlobInfo*) malloc( sizeof( long ) + aStrLen );
									strcpy( info->Name, "Unknown name" );
								}
								info->Para = aPara;

								if ( blobInfos == 0 )
									blobInfos = (char*) malloc( aStrLen + sizeof( info->Para ));
								else
									blobInfos = (char*) realloc( blobInfos, blobSize + aStrLen + sizeof( info->Para ));

								memcpy( blobInfos + blobSize, info, aStrLen + sizeof( info->Para ));
								blobSize += aStrLen + sizeof( info->Para );
								free( info );
							}
						}
						if ( aType == REFTYPE_REFLIST || aType == REFTYPE_BLOB )
							offset++;
					}
				}
				else
					i++;
		}

		if( refs && refs->length() ) {
			AttrKey key;
			key.DocId   = docId;
			key.AttrTag = IDD_REFS;

			Stream *str = aBase->docInd->Open( &key, 1 );
			refs->Put( str );
			str->Trunc();
			aBase->docInd->Close( str );
			delete refs;
		}

		if ( blobInfos ) {
			AttrKey key;
			key.DocId   = docId;
			key.AttrTag = IDD_BLOBS;
			Stream *str = aBase->docInd->Open( &key, 1 );
			str->Write( blobInfos, blobSize );
			str->Trunc();
			aBase->docInd->Close( str );
			free( blobInfos );
		}

		if ( aIDs ) gk_free( aIDs );
		delete aDoc;
	}

	printf("\n");

	BTIterator* it;
	aPerc = aBase->FindIndex( "Correspondent" )->KeyCount / 100L;
	aCurrPerc = 0;
	aaPerc = 0;

	for ( it = new BTIterator( aBase->FindIndex("Correspondent")); !it->End(); ++*it ) {
		long docId = *(long*)it->Key();

		//printf( "flush for topic %ld\r", docId );
		aCurrPerc++;
		if ( aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc );
			fflush(stdout);
		}

		if ( !newCorrs->contains(docId))
			continue;

		StorableSplaySet<CorrRef>* at = (StorableSplaySet<CorrRef>*)(*newCorrs)[docId];
		if ( at && at->length() ) {
			Stream* str = newCorr->Open(&docId,1);
			at->Put(str);
			str->Trunc();
			newCorr->Close(str);
		}
	}
	delete it;
	printf("\nflush finished\n");
	fflush(stdout);

	if ( enumParas ) {
		aCurrPerc = 0;
		aaPerc = 0;

		Index* index = aBase->FindIndex("Correspondent");
		DocCollection todelete;
		for ( it = new BTIterator( index ); !it->End(); ++*it ) {
			long docId = *(int*)it->Key();

			aCurrPerc++;
			if ( aCurrPerc > aPerc ) {
				aCurrPerc = 0;
				printf( "%ld%%\r", ++aaPerc );
				fflush(stdout);
			}

			StorableSplaySet<Ref> corrs;
			Stream *str = index->OpenN( &docId, 0 );
			corrs.Get(str);
			index->Close(str);		

			StorableSplaySet<Ref> modcorrs;
			for ( Point p = corrs.first(); p; corrs.next(p) ) {
				Ref	atP = corrs.contents(p);
				bool may = false;
				if ( !queue->contains(docId))
					may = true;
				else {
					StorableSplaySet<long>* nc = (StorableSplaySet<long>*)(*queue)[docId];
					if ( !nc || !nc->contains( atP.DocId ))
						may = true;
				}
				if ( may ) {
					atP.Sub = ParaToUniquePara( atP );
					modcorrs.add( atP );
				}
			}

			if ( modcorrs.first()) {
				str = index->OpenN( &docId, 0 );
				modcorrs.Put(str);
				str->Trunc();
				index->Close(str);		
			} else {
				todelete.Add( docId );
			}
		}
		delete it;
		for ( int i = 0; i < todelete.ItemCount; i++ ) {
			long docId = todelete[i];
			index->Delete( &docId );
		}
	}

	aBase->SetReady(TID_NEWCORR);
	printf("SetReady\n");
	fflush(stdout);
	delete aBase;
	printf("delete base\n");
	fflush(stdout);
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




