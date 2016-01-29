#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "long.long.SplayMap.h"
#include <algorithm>
#include <deque>

#include "pack.h"

#include "garantPIL/implementation/component/cpp/libs/endt/BlockDecompile.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"

StdBigBase* aBase = 0;
std::map<long,long> map_aak_rightblock;

RefCollection	refs_with_kind;
long			refs_with_kind_iter = 0;

struct	SubDesc2
{
	long	block;
	long	from, to;
};

int sortSubDesc2 (const void *a, const void *b)
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

void	PrepareParaBlocks (long docId)
{
	std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (docId);
	bool is_aak = aak_it != map_aak_rightblock.end ();
	DocCollection blockswKind;
	if (refs_with_kind_iter < refs_with_kind.ItemCount) {
		Ref* ref_at = (Ref*) refs_with_kind.Collection::GetItem (refs_with_kind_iter);
		while (ref_at->DocId < docId && refs_with_kind_iter < refs_with_kind.ItemCount)
			ref_at = (Ref*) refs_with_kind.Collection::GetItem (++refs_with_kind_iter);
		while (ref_at->DocId == docId && refs_with_kind_iter < refs_with_kind.ItemCount) {
			blockswKind.Add (ref_at->Sub);
			ref_at = (Ref*) refs_with_kind.Collection::GetItem (++refs_with_kind_iter);
		}
	}
	//получили все сабы, у которых есть KIND

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

	long structs_count, i;
	DocStruct *structs = (DocStruct*) aBase->LoadAttr (docId, IDD_DOCSTRUCT, structs_count), *structs_ptr = structs;
	structs_count /= sizeof (DocStruct);

	//вставлять надо только те, у которых есть KIND
	std::set<long> blocks_in_doc;
	for (i = 0; i < structs_count; i++, structs_ptr++) {
		short evd_type = (short) ((structs_ptr->m_para_list_type >> 24) & 0xFF);
		if (evd_type == SUBDESCEX_BLOCK) {
			long block = structs_ptr->m_para_list_id;
			if (blockswKind.IndexOf (&block) != -1 || (is_aak && aak_it->second == block)) {
				blocks = (SubDesc2*) realloc (blocks, (blockscount+1) * sizeof (SubDesc2));
				blocks[ blockscount ].block = block;
				blocks[ blockscount ].from = structs_ptr->m_start_para;
				blocks[ blockscount ].to = structs_ptr->m_end_para + 1;
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
	for (i = 0; i < subs_count; i++, subs_ptr++) {
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

void	DeleteParaBlocks ()
{
	if (blocks) {
		free (blocks);
		blocks = 0;
	}
}

long	FindParaBlock (long para)
{
	if (!blocks)
		return -1;

	//теперь надо найти минимальный блок, в котороый входит рассматриваемый para
	long found = 0;
	for (long i = 0; i < blockscount; i++)
		if (para >= blocks [i].from && para < blocks [i].to)
			found = blocks [i].block;

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

	printf ("Attention for version 7.7 : calculate only IDD_REFS_BLOCKS\n");

	aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	AttrIndex* docInd = (AttrIndex*) aBase->FindIndex ("Attrs");

	bool b_preview = (argc == 3 && !stricmp (argv [2], "-preview"));

	if (!aBase->FindIndex ("Aux")->IsExist (AUX_DSS_FLAGS)) {
		delete aBase;
		printf ( "run gl first, index Aux.DSSF required!\n");
		exit (EXIT_FAILURE);
	}

	{
		HIndex* index_kind = (HIndex*) aBase->FindIndex ("Kind");
		char full_key [1024];
		for (BTIterator it (index_kind); !it.End (); ++it) {
			HIndex::HIndexKey *k = (HIndex::HIndexKey*) it.Key ();

			if (k->level)
				break;
			
			index_kind->FullName (k, full_key);
			Stream *str = index_kind->Index::OpenN (k,0);
			if (str) {
				RefCollection refs;
				refs.Get (str);
				index_kind->Close (str);
				refs_with_kind.Merge (refs);
			}
		}
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

	DocCollection *allDocs = aBase->AllTopics ();
	long aTopics = allDocs->ItemCount, aPerc = aTopics / 100L, aCurrPerc = 0, aaPerc = 0;
	std::deque<long> delete_iddrefsblocks;
	for (long I = 0; I < aTopics; I++) {
		aCurrPerc++;
		if ( aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
		}

		long docId = (*allDocs)[I], lRefs;
		RespRef* iddrefs = (RespRef*) docInd->Load (docId, IDD_REFS, lRefs), *copy = iddrefs;
		if (lRefs) {
			lRefs = lRefs / sizeof (RespRef);
			long *blocks = new long [lRefs*2], lParaIds, *iddParaIds = (long*) aBase->LoadAttrEx (docId, IDD2_PARAIDS, lParaIds);
			lParaIds /= sizeof( long );
			longlongSplayMap paraIds(-1);
			for (long apara = 0; apara < lParaIds; apara++)
				paraIds [iddParaIds [apara]] = apara;
			gk_free (iddParaIds);

			PrepareParaBlocks (docId);
			for (long aref = 0; aref < lRefs; aref++, iddrefs++) {
				if (iddrefs->DocId == docId) {
					blocks [aref*2] = 0;
					blocks [aref*2+1] = 0;
					continue;
				}

				long realPara = paraIds [iddrefs->ParaId];
				blocks [aref*2] = realPara;
				blocks [aref*2+1] = FindParaBlock (realPara);

			}
			//в результате есть массив, в котором для каждой ссылки есть номер блока (с префиксом), из которого она ведет.
			aBase->ReplaceAttr (docId, IDD_REFS_BLOCKS, blocks, lRefs * 2 * sizeof (long));
			delete blocks;
			gk_free (copy);
			DeleteParaBlocks ();
		} else {
			delete_iddrefsblocks.push_back (docId);
		}
	}
	for (std::deque<long>::const_iterator it = delete_iddrefsblocks.begin (); it != delete_iddrefsblocks.end (); it++)
		aBase->DelAttr (*it, IDD_REFS_BLOCKS);

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
