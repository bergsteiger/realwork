#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>
#include <deque>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "pack.h"
#include "basemask.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "long.long.SplayMap.h"

#include "garantPIL/implementation/component/cpp/libs/endt/BlockDecompile.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"

Base* aBase = 0;
AttrIndex* docInd = 0;

std::map<long,long> map_aak_rightblock;

struct Tree
{
	Tree *parent, *next, *child;
	long id, pid;
	long from, to;
};

struct	SubDesc2
{
	long	block;
	long	from, to;
};

int sortSubDesc2( const void *a, const void *b )
{
	SubDesc2* s1 = (SubDesc2*) a;
	SubDesc2* s2 = (SubDesc2*) b;
	int s;
	s = s1->from - s2->from;
	if ( s != 0 ) return s;
	s = ( s2->to - s2->from ) - ( s1->to - s1->from );
	if ( s != 0 ) return s;
	s = s2->to - s1->to;
	if ( s != 0 ) return s;
	return s2->block - s1->block;
}

long	blockscount;
SubDesc2* blocks;

void	PrepareParaBlocks( long docId )
{
	std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (docId);
	bool is_aak = aak_it != map_aak_rightblock.end ();

	DocCollection blockswKind;
	long length; char *kindBlocks = (char*) aBase->LoadAttr (docId, IDD_KIND, length), *kind = kindBlocks;
	if (length) while (kind - kindBlocks < length) {
		long block = atol (kind);
		blockswKind.Add (block);
		kind += strlen (kind) + 1;
	}
	//получили все сабы, у которых есть kind

	blocks = 0;
	blockscount = 0;
	if (blockswKind.ItemCount == 0 && !is_aak)
		return;

	//среди них могут быть как блоки, так и весь документ	
	blocks = (SubDesc2*) malloc (sizeof (SubDesc2));
	long zero = 0, index = blockswKind.IndexOf (&zero);
	if (index == -1) {
		//нет нулевого блока
		blocks [0].block = -1;
	} else {
		//есть нулевой блок
		blocks [0].block = 0;
		blockswKind.atDelete (index);

	}
	blocks [0].from = 0;
	blocks [0].to   = 1000000;
	blockscount = 1;

	long structs_count;
	DocStruct *structs = (DocStruct*) aBase->LoadAttr (docId, IDD_DOCSTRUCT, structs_count), *structs_ptr = structs;
	structs_count /= sizeof (DocStruct);

	long i; //вставлять надо только те, у которых есть KIND
	std::set<long> blocks_in_doc;
	for ( i = 0; i < structs_count; i++, structs_ptr++) {
		short evd_type = (short) ((structs_ptr->m_para_list_type >> 24) & 0xFF);
		if (evd_type == SUBDESCEX_BLOCK) {
			long block = structs_ptr->m_para_list_id;
			if (blockswKind.IndexOf (&block) != -1 || (is_aak && aak_it->second == block)) {
				blocks = (SubDesc2*) realloc (blocks, (blockscount+1) * sizeof (SubDesc2));
				blocks [blockscount].block = block;
				blocks [blockscount].from = structs_ptr->m_start_para;
				blocks [blockscount].to = structs_ptr->m_end_para + 1;
				blockscount++;
				blocks_in_doc.insert (block);
			}
		}
	}
	gk_free (structs);

	//сабы надо тоже оформить блоками
	long subs_count = 0, blocks2count = 0;
	SubDesc *subs = (SubDesc*) aBase->LoadAttr (docId, IDD_SUBS, subs_count), *subs_ptr = subs;
	subs_count /= sizeof (SubDesc);
	SubDesc2* blocks2 = 0;
	for ( i = 0; i < subs_count; i++, subs_ptr++) {
		long sub = subs_ptr->Sub;
		if (blocks_in_doc.find (sub) == blocks_in_doc.end ()) {
			long index = blockswKind.IndexOf (&sub);
			if (index != -1) {
				if ( blocks2 )
					blocks2 = (SubDesc2*) realloc (blocks2, (blocks2count+1) * sizeof (SubDesc2));
				else
					blocks2 = (SubDesc2*) malloc (sizeof (SubDesc2));
				blocks2 [blocks2count].block = sub;
				blocks2 [blocks2count].from  = subs_ptr->Para;
				blocks2 [blocks2count].to    = 1000000;
				blocks2count++;
			}
		}
	}
	gk_free (subs);
	qsort (blocks2, blocks2count, sizeof (SubDesc2), sortSubDesc2);

	//сабы отсортированы по месту встречи, надо теперь их концы правильно пересчитать
	for (i = 0; i < blocks2count - 1; i++) {
		for (long j = i + 1; j < blocks2count; j++)
			if (blocks2 [i].from != blocks2 [j].from) {
				blocks2 [i].to = blocks2 [j].from - 1;
				break;
			}
	}

	//теперь их надо доклеить к blocks
	for (i = 0; i < blocks2count; i++) {
		blocks = (SubDesc2*) realloc (blocks, (blockscount+1) * sizeof (SubDesc2));
		blocks [blockscount].block = blocks2 [i].block;
		blocks [blockscount].from  = blocks2 [i].from;
		blocks [blockscount].to    = blocks2 [i].to;
		blockscount++;
	}
	free (blocks2);

	qsort (blocks, blockscount, sizeof (SubDesc2), sortSubDesc2);
	//для каждого блока теперь есть начало и конец, в параграфах
}

void	DeleteParaBlocks()
{
	if ( blocks ) {
		free( blocks );
		blocks = 0;
	}
}

long	FindParaBlock( long para )
{
	if ( !blocks )
		return -1;

	//теперь надо найти минимальный блок, в котороый входит рассматриваемый para
	long found = 0;
	for ( long i = 0; i < blockscount; i++ )
		if ( para >= blocks[ i ].from && para < blocks[ i ].to )
			found = blocks[ i ].block;

	return found;
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	docInd = (AttrIndex*) aBase->FindIndex ("Attrs");

	bool b_usememory = false, b_freebsd = false, b_preview = false;
	for (int i = 2; i < argc; i++) {
		b_usememory |= !stricmp (argv [i], "UseMemory");
		b_freebsd |= !stricmp (argv [i], "freebsd");
		b_preview |= !stricmp (argv [i], "-preview");
	}

	if (!b_freebsd && !aBase->FindIndex ("Aux")->IsExist (AUX_DSS_FLAGS)) {
		delete aBase;
		printf ( "run gl first, index Aux.DSSF required!\n");
		exit (EXIT_FAILURE);
	}

	if (!b_preview) {
		Stream *str = aBase->FindIndex ("Aux")->Open (AUX_DSS_FLAGS_LENGTH);
		long count = 0;
		if (str) {
			str->Read (&count, sizeof (long));
			aBase->FindIndex ("Aux")->Close(str);
		}

		str = aBase->FindIndex ("Aux")->Open (AUX_DSS_FLAGS);
		if (str) {
			long packed_length = str->Length ();
			char *unpacked_buffer = (char*) malloc (4096 * sizeof (DSSAttribute));
			while (str->Tell () < str->Length ()) {
				long small_count = std::min <long> (count, 4096), packed_size;
				str->Read (&packed_size, sizeof (long));
				char *packed_buffer = (char*) malloc (packed_size);
				str->Read (packed_buffer, packed_size);
				G_UNZIP (packed_buffer, packed_size, unpacked_buffer, small_count * sizeof (CommonAttribute));
				DSSAttribute *ptr = (DSSAttribute*) unpacked_buffer;
				for (int i = 0; i < small_count; i++, ptr++) {
					if (ptr->m_flags & DSS_AAKTOPIC) {
						long doc_id = ptr->m_id, length = 0;
						char *data = (char*) aBase->LoadAttr (doc_id, IDD_EVD, length), *ptr = data;
						if (length) {
							while (ptr - data < length) {
								long block_id = *(long*)ptr;
								ptr += sizeof (long);
								long size = (long) ptr [0];
								if (block_id < 0) {
									std::string info;
									evd::IeeGenerator_var generator = EndtTools::BlockDecompileFactory::make (info);
									evd::EvdReader_var evd_reader = new evd::EvdReader (ptr+1, size, generator.in ());
									evd_reader->convert_binary_object ();
									if (info == "RIGHT")
										map_aak_rightblock.insert (std::map<long,long>::value_type (doc_id, -block_id));
								}
								ptr += size + 1;
							}
							gk_free (data);
						}
					}
				}
				gk_free (packed_buffer);
				count -= small_count;					
			}
			gk_free (unpacked_buffer);
			aBase->FindIndex ("Aux")->Close (str);
		}
	}

	std::map<long,long*> map_doc_iddrefsblocks;

	StorableSplaySet<long> dicDocs;
	short   aDicSeg = DICTIONARY_SEGMENT;
	Stream *str = aBase->FindIndex("Segment")->Open( &aDicSeg );
	if ( str ) {
		dicDocs.Get( str );
		aBase->FindIndex("Segment")->Close( str );
	}

	static AttrKey	attrKey = { ID_BORDER, IDD_INFO };
	DocCollection* allDocs = aBase->AllTopics(ID_BORDER);
	Index *blobs   = aBase->FindIndex("Blob"), *index = 0;
	BTIterator* it;

	if (!(aBase->GetReady() & TM_ENUMPARAS)) {
		delete aBase;
		printf ("Run enumparas first!\n");
		exit (EXIT_FAILURE);
	}

	long aTopics = allDocs->ItemCount, i, aPerc = aTopics / 100L, aCurrPerc = 0, aaPerc = 0;
	printf( "AllTopics: %ld\nCalculate refs\n0\r", aTopics ); fflush(stdout);
	std::deque<long> delete_iddrefs, delete_iddblob;

	for ( long I = 0; I < aTopics; I++ ) {
		long docId = (*allDocs)[I];

		aCurrPerc++;
		if ( aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc );
			fflush(stdout);
		}

		DocInfo docInfo;
		aBase->FindDocInfo (docId,docInfo);

		Document* aDoc = aBase->GetDoc (docId);
		if (!aDoc) {
			delete_iddrefs.push_back (docId);
			delete_iddblob.push_back (docId);
			continue;
		}

		StorableSplaySet<RespRef> *refs = new StorableSplaySet<RespRef>;
		std::set<long> set_blobs;

		char*	blobInfos = 0;
		long	blobSize  = 0, aSize, *aIDs = (long*) aBase->LoadAttrEx (docId, IDD2_PARAIDS, aSize);

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
							if ( aType == REFTYPE_REFLIST && ( ( docInfo.Status & ( DS_DOC | DS_EDITION )) || ( aRefs > 1 )) ) {
								Ref* atText = (Ref*)(ptr+i);

								CorrRef corrRef = { atText->Sub, docId, aPara };
								if ( aPara < aSize )
									corrRef.Para = aIDs[ aPara ];
								else
									corrRef.Para = 0;

								RespRef respRef = { corrRef.Para, offset, atText->DocId, atText->Sub };
								refs->add( respRef );
							} else
							if ( aType == REFTYPE_BLOB ) {
								ObjKey* atText = (ObjKey*)(ptr+i);
								BlobInfo *info = 0;
								
								set_blobs.insert (atText->id);
								Stream* str = blobs->Open( &atText->id );
								if ( str ) {
									long aStrLen = 0;
									ObjInfo objInfo;

									str->Read( &objInfo, sizeof( objInfo ));
									str->Seek( sizeof( objInfo ) + objInfo.size );
									str->Read( &aStrLen, sizeof( aStrLen ));
									if ( aStrLen > 1 ) {
										info = (BlobInfo*) malloc( sizeof(BlobInfo) + aStrLen - 1);
										info->Para = aPara;
										info->type = objInfo.type;

										str->Read( info->Name, aStrLen );
										info->Name[ aStrLen-1 ] = '\0';
										
										blobInfos = (char*) realloc (blobInfos, blobSize + aStrLen + sizeof (BlobInfo) - 1);
										memcpy (blobInfos + blobSize, info, aStrLen + sizeof (BlobInfo) - 1);
										blobSize += aStrLen + sizeof (BlobInfo) - 1;

										free( info );
									}
									blobs->Close(str);
								} else {
									char unname[ 32 ];
									sprintf( unname, "Unknown name %ld", atText->id );
									int aStrLen = strlen( unname ) + 1;
									info = (BlobInfo*) malloc (sizeof (BlobInfo) + aStrLen - 1);
									strcpy( info->Name, unname );
									info->Para = aPara;
									info->type = 0;

									blobInfos = (char*) realloc( blobInfos, blobSize + aStrLen + sizeof (BlobInfo) - 1);
									memcpy (blobInfos + blobSize, info, aStrLen + sizeof (BlobInfo) - 1);
									blobSize += aStrLen + sizeof (BlobInfo) - 1;
									free( info );
								}
							}
						}
						if ( aType == REFTYPE_REFLIST || aType == REFTYPE_BLOB )
							offset++;
					}
				}
				else
					i++;
		}

		if (b_freebsd) {
			if (set_blobs.size ()) {
				AttrKey key;
				key.DocId   = docId;
				key.AttrTag = IDD_BLOB;

				Stream *str = docInd->Open (&key, 1);
				if (str) {
					long *data = new long [set_blobs.size ()], *ptr = data;
					for (std::set<long>::const_iterator it = set_blobs.begin (); it != set_blobs.end (); it++, ptr++)
						*ptr = *it;
					str->Write (data, set_blobs.size () * sizeof (long));
					delete [] data;
					str->Trunc ();
					docInd->Close( str );
				}
			} else {
				delete_iddblob.push_back (docId);
			}
		}

		if( refs && refs->length() ) {
			AttrKey key;
			key.DocId   = docId;
			key.AttrTag = IDD_REFS;

			Stream *str = docInd->Open( &key, 1 );
			refs->Put( str );
			str->Trunc();
			docInd->Close( str );
			delete refs;
		} else {
			delete_iddrefs.push_back (docId);
		}

		if ( blobInfos ) {
			AttrKey key;
			key.DocId   = docId;
			key.AttrTag = IDD_BLOBS;
			Stream *str = docInd->Open( &key, 1 );
			str->Write( blobInfos, blobSize );
			str->Trunc();
			docInd->Close( str );
			free (blobInfos);
			blobInfos = 0;
		}

		if ( aIDs ) gk_free( aIDs );
		delete aDoc;
	}

	{
		std::deque<long>::const_iterator it;
		for (it = delete_iddrefs.begin (); it != delete_iddrefs.end (); it++)
			aBase->DelAttr (*it, IDD_REFS);
		for (it = delete_iddblob.begin (); it != delete_iddblob.end (); it++)
			aBase->DelAttr (*it, IDD_BLOB);	
	}

	printf("\nRemove dictionary (cor)respondents\n");

	index = aBase->FindIndex("Respondent");
	DocCollection toDelete;
	for ( it = new BTIterator( index ); !it->End(); ++*it ) {
		long docId = *(int*)it->Key();
		if ( dicDocs.contains( docId ))
			toDelete.Add( docId );
	}
	delete it;
	for ( i = 0; i < toDelete.ItemCount; i++ ) {
		long docId = toDelete[i];
		index->Delete( &docId );
	}

	toDelete.FreeAll();

	index = aBase->FindIndex("Correspondent");
	aPerc = index->KeyCount / 100, aCurrPerc = aaPerc = 0;
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
			if ( !dicDocs.contains( atP.DocId ))
				modcorrs.add( atP );
		}

		if ( modcorrs.first()) {
			str = index->OpenN( &docId, 0 );
			modcorrs.Put(str);
			str->Trunc();
			index->Close(str);
		} else {
			toDelete.Add( docId );
		}
	}
	delete it;		
	for ( i = 0; i < toDelete.ItemCount; i++ ) {
		long docId = toDelete[i];
		index->Delete( &docId );
	}

#ifndef	unix
	if (!b_freebsd) {
	aPerc = aTopics / 100L, aCurrPerc = 0, aaPerc = 0;

	printf ("\nCalculate IDD_REFS_BLOCKS\n", aTopics); fflush (stdout);
	for (long I = 0; I < aTopics; I++) {
		aCurrPerc++;
		if (aCurrPerc > aPerc) {
			aCurrPerc = 0;
			printf ("%ld%%\r", ++aaPerc);
			fflush (stdout);
		}

		long docId = (*allDocs)[I], lRefs;
		RespRef *iddrefs = (RespRef*) docInd->Load (docId, IDD_REFS, lRefs), *copy = iddrefs;
		if (lRefs) {
			lRefs = lRefs / sizeof (RespRef);

			longlongSplayMap paraIds(-1);
			long *blocks = new long [lRefs * 2], lParaIds, *iddParaIds = (long*) aBase->LoadAttrEx (docId, IDD2_PARAIDS, lParaIds);
			lParaIds /= sizeof (long);
			for (long apara = 0; apara < lParaIds; apara++)
				paraIds [iddParaIds [apara]] = apara;
			gk_free (iddParaIds);

			PrepareParaBlocks (docId);
			for (long aref = 0; aref < lRefs; aref++, iddrefs++) {
				if (iddrefs->DocId == docId)
					continue;

				long realPara = paraIds [iddrefs->ParaId];
				blocks [aref * 2] = realPara;
				blocks [aref * 2 + 1] = FindParaBlock (realPara);
			}
			//в результате есть массив, в котором для каждой ссылки есть номер блока (с префиксом), из которого она ведет.
			if (b_usememory) {
				map_doc_iddrefsblocks.insert (std::map<long,long*>::value_type (docId, blocks));
			} else {
				aBase->ReplaceAttr (docId, IDD_REFS_BLOCKS, blocks, lRefs * 2 * sizeof (long));
				delete blocks;
			}
			gk_free (copy);
			DeleteParaBlocks ();
		}
	}

	printf ("\nProcessing all refs\n"); fflush( stdout );
	aPerc = aTopics / 100L, aCurrPerc = aaPerc = 0;
	u_int32_tcaddr_tSplayMap *newCorrs = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );
	for ( i = 0; i < aTopics; i++ ) {
		long docId = (*allDocs)[i];

		std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (docId);
		bool is_aak = aak_it != map_aak_rightblock.end ();

		if ( ++aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
		}

		long lRefs, *blocks;
		RespRef* iddrefs = (RespRef*) docInd->Load (docId, IDD_REFS, lRefs);

		if (lRefs) {
			RespRef* copy = iddrefs;
			lRefs = lRefs / sizeof( RespRef );

			if (b_usememory)
				blocks = map_doc_iddrefsblocks.find (docId)->second;
			else {
				long lBlocks;
				blocks = (long*) aBase->LoadAttr (docId, IDD_REFS_BLOCKS, lBlocks);
			}			
			for (long aref = 0; aref < lRefs; aref++, iddrefs++) {
				long refsid = iddrefs->DocId;
				if (refsid == docId || allDocs->IndexOf (&refsid) == -1)
					continue;

				CorrRef corrRefAdd;
				corrRefAdd.Sub= iddrefs->Sub;
				corrRefAdd.DocId= docId;
				corrRefAdd.Para= iddrefs->ParaId;
				corrRefAdd.RealPara = blocks [aref * 2];
				corrRefAdd.Block    = blocks [aref * 2 + 1];

				if (is_aak && aak_it->second == corrRefAdd.Block)
					continue;

				StorableSplaySet<CorrRef>* nc = (StorableSplaySet<CorrRef>*)(*newCorrs)[refsid];
				if ( !nc ) {
					nc = new StorableSplaySet<CorrRef>;
					(*newCorrs)[refsid] = (caddr_t) nc;
				}
				nc->add(corrRefAdd);
			}
			gk_free (copy);
			if (blocks) gk_free (blocks);
		}
	}

	index = aBase->FindIndex("Correspondent");
	aPerc = index->KeyCount / 100L, aCurrPerc = aaPerc = 0;
	Index* newCorrIndex = aBase->FindIndex("NewCorr");

	printf( "\nFlushing index NewCorr\n" ); fflush( stdout );
	long *pdocIdT;
	for ( it = new BTIterator(index); !it->End(); ++*it ) {
		pdocIdT = (long*)it->Key();

		if ( ++aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
		}

		if ( !newCorrs->contains(*pdocIdT))
			continue;

		StorableSplaySet<CorrRef>* at = (StorableSplaySet<CorrRef>*)(*newCorrs)[*pdocIdT];
		if ( at && at->length() ) {
			Stream* str= newCorrIndex->Open(pdocIdT,1);
			at->Put(str);
			str->Trunc();
			newCorrIndex->Close(str);
		}
	}

	printf( "\nRemove garbage\n" ); fflush( stdout );
	aPerc = aTopics / 100L, aCurrPerc = aaPerc = 0;
	for ( i = 0; i < aTopics; i++ ) {
		if ( ++aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
		}
		AttrKey delkey = { (*allDocs)[i], IDD_REFS_BLOCKS };
		docInd->DelKey( &delkey );
	}
	printf ("\n");
	} //if (!b_freebsd) {
#endif

	aBase->SetReady(TID_NEWCORR);
	printf("\nSetReady\n");
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
