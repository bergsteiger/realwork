#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"

#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "long.long.SplayMap.h"

#include "pack.h"
#include "garantPIL/implementation/component/cpp/libs/endt/BlockDecompile.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"

struct	CorrStruct {
	long	uid;
	u_int64_t	mask;
	RefCollection*	refs;
};

CorrStruct	CorrKinds [64];
long	CorrKinds_size = 0;

int	StrRev (char *pStr, revision& theRev)
{	
	unsigned short day, month, year, hour, min, find;
	find = sscanf( pStr, "%hd/%hd/%hd:%hd:%hd", &day, &month, &year, &hour, &min );

	if ( find != 3 && find != 5 ) return 0;
	if ( day > 31 || month > 12 ) return 0;
	if ( year < 100 ) year += 2000;
	theRev.RevisionDate.da_day = (unsigned char)day;
	theRev.RevisionDate.da_mon = (unsigned char)month;
	theRev.RevisionDate.da_year = year;
	if ( find == 5 ) {
		if ( hour > 23 || min > 59 ) return 0;
		theRev.RevisionTime.ti_min = (unsigned char)min;
		theRev.RevisionTime.ti_hour = (unsigned char)hour;
	} else {
		theRev.RevisionTime.ti_min = 0;
		theRev.RevisionTime.ti_hour = 0;
	}
	return 1;
}

Base *base, *oldbase;

std::map<long,long> map_aak_rightblock;

void	get_aaks (Base* base)
{
	Stream *str = base->FindIndex ("Aux")->Open (AUX_DSS_FLAGS_LENGTH);
	long count = 0;
	if (str) {
		str->Read (&count, sizeof (long));
		base->FindIndex ("Aux")->Close(str);
	}

	str = base->FindIndex ("Aux")->Open (AUX_DSS_FLAGS);
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
					char *data = (char*) base->LoadAttr (doc_id, IDD_EVD, length), *ptr = data;
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
		base->FindIndex ("Aux")->Close (str);
		gk_free (unpacked_buffer);
	}
}

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
	long length; char *kindBlocks = (char*) base->LoadAttr (docId, IDD_KIND, length), *kind = kindBlocks;
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
	DocStruct *structs = (DocStruct*) base->LoadAttr (docId, IDD_DOCSTRUCT, structs_count), *structs_ptr = structs;
	structs_count /= sizeof (DocStruct);

	long i; //вставлять надо только те, у которых есть KIND
	std::set<long> blocks_in_doc;
	for ( i = 0; i < structs_count; i++, structs_ptr++) {
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
	SubDesc *subs = (SubDesc*) base->LoadAttr (docId, IDD_SUBS, subs_count), *subs_ptr = subs;
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

int	compare_corrref (const void* p1, const void* p2)
{
	CorrRef* c1 = (CorrRef*) p1;
	CorrRef* c2 = (CorrRef*) p2;

	int s;
	s = cchlp_Sign (c1->Sub - c2->Sub);
	if ( s != 0 ) return s;
	s = cchlp_Sign (c1->DocId - c2->DocId);
	if ( s != 0 ) return s;
	s = cchlp_Sign (c1->Para - c2->Para);
	if ( s != 0 ) return s;
	s = cchlp_Sign (c1->RealPara - c2->RealPara);
	if ( s != 0 ) return s;
	return cchlp_Sign (c1->Block - c2->Block);
}

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	if (argc < 4)
		return -1;
	revision newdocs_revision;
	gk_bzero (&newdocs_revision, sizeof (revision));
	if (!StrRev (argv[3], newdocs_revision)) {
		printf ("bad revision\n");
		return -1;
	}

	std::map<long,DocCollection*> map_segment_docs;
	{
	ToolsBase *tbase = new ToolsBase (argv [2]);

	get_aaks (tbase);
	Index *segment_index = tbase->FindIndex ("Segment");
	for (int i = 1; i < 401; i++) {
		Stream *str = segment_index->Open (&i);
		if (str) {
			DocCollection *docs = new DocCollection;
			docs->Get (str);
			segment_index->Close (str);
			map_segment_docs.insert (std::map<long,DocCollection*>::value_type (i, docs));
		}
	}

	HIndex *index_kind = (HIndex*) tbase->FindIndex ("Kind");
	char full_key [1024];
	for (BTIterator it (index_kind); !it.End (); ++it) {
		HIndex::HIndexKey *k = (HIndex::HIndexKey*) it.Key ();

		if (k->level == 0) {
			Stream *str = index_kind->Index::OpenN (k,0);
			if (str) {
				RefCollection refs;
				refs.Get (str);
				index_kind->Close (str);
			}
		}

		if (k->chCount)
			continue;
		
		index_kind->FullName (k, full_key);
		long uid = tbase->kind_key_to_uid (full_key);
		if (!uid)
			continue;

		u_int64_t mask = tbase->kind_uid_to_bit (uid);
		if (!mask)
			continue;
		Stream *str = index_kind->Index::OpenN (k,0);
		if (str) {
			CorrKinds [CorrKinds_size].refs = new RefCollection ();
			CorrKinds [CorrKinds_size].refs->Get (str);
			CorrKinds [CorrKinds_size].uid = uid;
			CorrKinds [CorrKinds_size].mask = mask;
			index_kind->Close (str);
			CorrKinds_size++;
		}
	}
#ifndef	_WIN64
	delete tbase;
#endif
	}

	int max_corrrefs = 40960000;
	CorrRef *corrrefs_buffer = new CorrRef [max_corrrefs], *corrrefs_buffer_ptr = corrrefs_buffer;
	gk_bzero (corrrefs_buffer, max_corrrefs * sizeof (CorrRef));

	oldbase = new YBase (argv [1], ACE_OS_O_RDONLY);
	oldbase->IsOk ();
	base = new YBase (argv [2], ACE_OS_O_RDONLY);
	base->IsOk ();

	std::deque<long> new_docs, was_doc_now_nodoc;
	{
		//надо получить список документов, которые из DOCов стали NODOCами)
		DocCollection *all_old_docs = oldbase->AllDocs ();
		DocCollection *all_new_docs = base->AllDocs ();
		all_old_docs->Minus (*all_new_docs);
		delete all_new_docs;
		for (int i = 0; i < all_old_docs->ItemCount; i++) {
			long id = (*all_old_docs)[i];
			was_doc_now_nodoc.push_back (id);
			new_docs.push_back (id);
		}
		delete all_old_docs;
	}

	std::deque<long> docs, docs_and_editions, skip_docs, all_docs;
	std::map<long, std::deque<long> > *map_doc_editions = new std::map<long, std::deque<long> >;

	printf ("Calculate Edis\n"); fflush (stdout);
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (!str) {
		if (!base->FindIndex ("Aux")->Open ("InfL")) {
			printf ( "run gl first!\n");
			exit (EXIT_FAILURE);
		}
	} else {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			docs_and_editions.push_back (edition);
			ptr++;
			long doc = *ptr;
			ptr++;

			std::map<long, std::deque<long> >::iterator it = map_doc_editions->find (doc);
			if (it == map_doc_editions->end ()) {
				std::deque<long> editions;
				editions.push_back (edition);
				editions.push_back (doc);
				map_doc_editions->insert (std::map<long, std::deque<long> >::value_type (doc, editions));
			} else {
				it->second.push_back (edition);
			}
		}
		gk_free (data);

		std::map<long,std::deque<long> > map_edition_editions;
		for (std::map<long,std::deque<long> >::const_iterator map_it = map_doc_editions->begin (); map_it != map_doc_editions->end (); map_it++) {
			for (std::deque<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
				map_edition_editions.insert (std::map<long,std::deque<long> >::value_type (*it, map_it->second));
			}
		}
		map_doc_editions->insert (map_edition_editions.begin (), map_edition_editions.end ());
		map_edition_editions.clear ();
	}

	{
		for (std::map<long,std::deque<long> >::iterator map_it = map_doc_editions->begin (); map_it != map_doc_editions->end (); map_it++)
			std::sort (map_it->second.begin (), map_it->second.end ());
	}

	std::sort (docs_and_editions.begin (), docs_and_editions.end ());
	docs_and_editions.erase (std::unique (docs_and_editions.begin (), docs_and_editions.end ()), docs_and_editions.end ());

	DocCollection *collection_alldocs = base->AllDocs ();
	static const AttrKey key = {ID_BORDER, IDD_INFO};

	printf ("get all topics: begin ");
	AttrKey start_key = {ID_BORDER, IDD_INFO};
	for (BTIterator btit (base->FindIndex ("Attrs"), &start_key); !btit.End (); ++btit) {
		AttrKey *key = (AttrKey*)btit.Key  ();
		if (key->AttrTag != IDD_INFO)
			break;

		long id = key->DocId;
		all_docs.push_back (id);

		if (!std::binary_search (docs_and_editions.begin (), docs_and_editions.end (), id)) {
			if (collection_alldocs->IndexOf (&id) == -1) {
				if (!std::binary_search (new_docs.begin (), new_docs.end (), id)) {
					skip_docs.push_back (id);
				}
			} else
				docs.push_back (id);
		}
	}
	delete collection_alldocs;

	docs_and_editions.insert (docs_and_editions.begin (), docs.begin (), docs.end ());
	std::sort (docs_and_editions.begin (), docs_and_editions.end ());
	docs_and_editions.erase (std::unique (docs_and_editions.begin (), docs_and_editions.end ()), docs_and_editions.end ());
	docs.clear ();

	std::deque<long> real_new_docs, newcorr_docs;
	for (std::deque<long>::const_iterator it = docs_and_editions.begin (); it != docs_and_editions.end (); it++) {
		long id = *it;
		DocInfo docinfo;
		base->FindDocInfo (id, docinfo);
		if (!memcmp (&docinfo.Revision, &newdocs_revision, sizeof (revision))) {
			new_docs.push_back (id);
			if ((docinfo.Status & DS_DOC) && (oldbase->FindDocInfo (id, docinfo) != sizeof (DocInfo)))
				real_new_docs.push_back (id);
		}
	}
	printf ("end\n");

	std::sort (new_docs.begin (), new_docs.end ());
	new_docs.erase (std::unique (new_docs.begin (), new_docs.end ()), new_docs.end ());

	//имеем список топиков, которые новые или измененные
	//из них надо набрать ссылки, и заменить ими существующие в NewCorr
	AttrIndex *docInd = (AttrIndex*) base->FindIndex ("Attrs");
	u_int32_tcaddr_tSplayMap *newCorrs = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );
	Index *respondents = base->FindIndex ("Respondent");

	std::map<long,std::set<long> > map_doc_deletedcorrs;
	std::map<long,u_int64_t> map_doc_respmask;

	for (std::deque<long>::const_iterator it = new_docs.begin (); it != new_docs.end (); it++) {
		long id = *it;
		printf ("%ld\r", id);

		if (std::binary_search (skip_docs.begin (), skip_docs.end (), id))
			continue;

		DocInfo docinfo;
		base->FindDocInfo (id, docinfo);
		if (GetDocRespondents64 (&docinfo) == 0) {
			Stream* str = respondents->Open (&id);
			RefCollection refs;
			if (str) {
				refs.Get (str);
				respondents->Close (str);
			}
			if (refs.ItemCount) {
				u_int64_t mask = 0;
				for (int j = 0; j < CorrKinds_size; j++) {
					if (refs.IsSect2 (CorrKinds [j].refs))
						mask |= CorrKinds [j].mask;
				}
				if (mask)
					map_doc_respmask.insert (std::map<long, u_int64_t>::value_type (id, mask));
			}
		}

		long lRefs;
		RespRef *iddrefs = (RespRef*) docInd->Load (id, IDD_REFS, lRefs ), *copy = iddrefs;

		DocCollection newdocs;
		std::map<long,std::deque<long> >::const_iterator map_doc_editions_it = map_doc_editions->find (id);

		if (lRefs) {
			std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (id);
			bool is_aak = aak_it != map_aak_rightblock.end ();

			lRefs /= sizeof (RespRef);

			long* blocks = new long [lRefs * 2], *blocks_ptr = blocks, aref;

			longlongSplayMap paraIds(-1);
			long lParaIds, *iddParaIds = (long*) base->LoadAttrEx (id, IDD2_PARAIDS, lParaIds);
			lParaIds /= sizeof( long );
			for (long apara = 0; apara < lParaIds; apara++)
				paraIds [iddParaIds [apara]] = apara;
			gk_free (iddParaIds);

			PrepareParaBlocks (id);
			for (aref = 0; aref < lRefs; aref++, iddrefs++) {
				if (iddrefs->DocId == id)
					continue;

				long realPara = paraIds [iddrefs->ParaId];
				blocks [aref * 2] = realPara;
				blocks [aref * 2 + 1] = FindParaBlock (realPara);
			}

			for (aref = 0, iddrefs = copy; aref < lRefs; aref++, iddrefs++, blocks_ptr +=2) {
				long refsid = iddrefs->DocId;

				if (!std::binary_search( docs_and_editions.begin (), docs_and_editions.end (), refsid) ||
					(refsid == id) ||
					((map_doc_editions_it != map_doc_editions->end ()) && (std::binary_search (map_doc_editions_it->second.begin (), map_doc_editions_it->second.end (), refsid)))
					)
					continue;

				newdocs.Insert (&refsid);

				CorrRef corrRefAdd;
				corrRefAdd.Sub      = iddrefs->Sub;
				corrRefAdd.DocId    = id;
				corrRefAdd.Para     = iddrefs->ParaId;
				corrRefAdd.RealPara = *blocks_ptr;
				corrRefAdd.Block    = *(blocks_ptr+1);

				if (is_aak && aak_it->second == corrRefAdd.Block)
					continue;

				long newcorr_id = iddrefs->DocId;
				StorableSplaySet<CorrRef>* nc = (StorableSplaySet<CorrRef>*)(*newCorrs)[newcorr_id];
				if ( !nc ) {
					nc = new StorableSplaySet<CorrRef>;
					(*newCorrs)[refsid] = (caddr_t) nc;
				}
				nc->add(corrRefAdd);
			}

			delete blocks;
			DeleteParaBlocks();
			gk_free (copy);
		}

		iddrefs = (RespRef*) oldbase->LoadAttr (id, IDD_REFS, lRefs), copy = iddrefs;
		lRefs /= sizeof (RespRef);

		DocCollection olddocs;
		for (long aref = 0; aref < lRefs; aref++, iddrefs++) {
			long refsid = iddrefs->DocId;

			if (std::binary_search (was_doc_now_nodoc.begin (), was_doc_now_nodoc.end (), id)) {
				olddocs.Insert (&refsid);
				continue;
			}
			
			if (!std::binary_search( docs_and_editions.begin (), docs_and_editions.end (), refsid) ||
				(refsid == id) ||
				((map_doc_editions_it != map_doc_editions->end ()) && (std::binary_search (map_doc_editions_it->second.begin (), map_doc_editions_it->second.end (), refsid)))
				)
				continue;

			olddocs.Insert (&refsid);
		}

		if (!std::binary_search (was_doc_now_nodoc.begin (), was_doc_now_nodoc.end (), id))
			olddocs.Minus (newdocs);

		if (olddocs.ItemCount) {
			for (long i = 0; i < olddocs.ItemCount; i++) {
				long corrid = olddocs [i];
				map_doc_deletedcorrs.insert (std::map<long,std::set<long> >::value_type (corrid, std::set<long> ())).first->second.insert (id);
				printf ("for %ld delete correspondent %ld\n", corrid, id);
			}
		}

	}
	printf ("\n");

	std::set<long> oldnewcorr;
	for (BTIterator it (oldbase->FindIndex ("NewCorr")); !it.End (); ++it)
		oldnewcorr.insert (*(long*)it.Key ());

#ifndef	_WIN64
	delete oldbase;
	delete base;
#endif

	map_doc_editions->clear ();
	delete map_doc_editions;

#ifndef	_WIN64
	base = new StdBigBase (argv [2], /*ACE_OS_O_RDWR*/ACE_OS_O_RDONLY);
#endif

	char str_to_write [128];

	//получили NewCorr, состоящий только из ссылок, которые есть в "новых" документах
	//теперь надо пройтись по этим ключам, прочитать оттуда старые данные, и те, которые "новые документы", заменить на эти...
	Index* newcorrs_index = base->FindIndex ("NewCorr");
	{
	FILE *newcorr_file = fopen (argc > 4 ? argv [4] : "newcorr_chg.txt", "wt");
	printf ("write new changes\n");
	for (Point p = newCorrs->first (); p; newCorrs->next (p)) {
		long id = newCorrs->key (p);
		printf ("open %ld \r", id);

		StorableSplaySet<CorrRef>* newrefs = (StorableSplaySet<CorrRef>*)(*newCorrs)[id];

		Stream* str = newcorrs_index->Open (&id);
		long all_count = 0;
		if (str) {
			all_count = str->Length () / sizeof (CorrRef);
			if (all_count + newrefs->length () > max_corrrefs) {
				max_corrrefs = all_count + newrefs->length ();
				delete [] corrrefs_buffer;
				corrrefs_buffer = new CorrRef [all_count];
			}
		}

		int corrrefs_count = 0;
		corrrefs_buffer_ptr = corrrefs_buffer;
		for (Point pp = newrefs->first (); pp; newrefs->next (pp), corrrefs_buffer_ptr++, corrrefs_count++) {
			CorrRef atpp = (*newrefs)(pp);
			memcpy (corrrefs_buffer_ptr, &atpp, sizeof (CorrRef));
		}

		if (str) {
			CorrRef buffer [1024];
			while (all_count) {
				long count = str->Read (buffer, sizeof (buffer)) / sizeof (CorrRef);
				all_count -= count;
				CorrRef *ptr = buffer;
				for (int i = 0; i < count; i++, ptr++)
					if (!std::binary_search (new_docs.begin (), new_docs.end (), ptr->DocId)) {
						memcpy (corrrefs_buffer_ptr, ptr, sizeof (CorrRef));
						corrrefs_buffer_ptr++;
						corrrefs_count++;
					}
			}
			newcorrs_index->Close (str);
		}

		printf ("write %ld\r", id);
		qsort (corrrefs_buffer, corrrefs_count, sizeof (CorrRef), compare_corrref);

		if (oldnewcorr.find (id) == oldnewcorr.end ())
			newcorr_docs.push_back (id);

		sprintf (str_to_write, "%ld:\n", id);
		fputs (str_to_write, newcorr_file);
		CorrRef *ptr = corrrefs_buffer;
		for (int i = 0; i < corrrefs_count; i++, ptr++) {
			sprintf (str_to_write, "%ld.%ld.%ld.%ld.%ld\n", ptr->Sub, ptr->DocId, ptr->Para, ptr->RealPara, ptr->Block);
			fputs (str_to_write, newcorr_file);
		}
		strcpy (str_to_write, ":\n");
		fputs (str_to_write, newcorr_file);

		/*
		str = newcorrs_index->Open (&id, 1);
		if (str) {
			str->Write (corrrefs_buffer, corrrefs_count * sizeof (CorrRef));
			str->Trunc ();
			newcorrs_index->Close (str);
		}
		*/
	}
	fclose (newcorr_file);
	}

	{
	FILE *newcorrdel_file = fopen (argc > 5 ? argv [5] : "newcorr_del.txt", "wt");
	printf ("\ntune deleted corrs\n");
	for (std::map<long,std::set<long> >::const_iterator map_it = map_doc_deletedcorrs.begin (); map_it != map_doc_deletedcorrs.end (); map_it++) {
		long id = map_it->first;
		printf ("%ld\r", id);

		Stream* str = newcorrs_index->Open (&id, 0);
		if (str) {
			int all_count = str->Length () / sizeof (CorrRef);
			if (all_count > max_corrrefs) {
				max_corrrefs = all_count;
				delete [] corrrefs_buffer;
				corrrefs_buffer = new CorrRef [all_count];
			}

			int corrrefs_count = 0;
			corrrefs_buffer_ptr = corrrefs_buffer;

			CorrRef buffer [1024];
			std::set<long> deleted;
			while (all_count) {
				long count = str->Read (buffer, sizeof (buffer)) / sizeof (CorrRef);
				all_count -= count;
				CorrRef *ptr = buffer;
				for (int i = 0; i < count; i++, ptr++) {
					if (map_it->second.find (ptr->DocId) != map_it->second.end ()) {
						deleted.insert (ptr->DocId);
					}
				}
			}
			newcorrs_index->Close (str);

			if (deleted.size ()) {
				sprintf (str_to_write, "%ld:\n", id);
				fputs (str_to_write, newcorrdel_file);
				for (std::set<long>::const_iterator del_it = deleted.begin (); del_it != deleted.end (); del_it++) {
					sprintf (str_to_write, "%ld\n", *del_it);
					fputs (str_to_write, newcorrdel_file);
				}
				strcpy (str_to_write, ":\n");
				fputs (str_to_write, newcorrdel_file);
			}
		}
	}
	fclose (newcorrdel_file);
	}
	map_doc_deletedcorrs.clear ();

	delete [] corrrefs_buffer;

	{
	FILE *docinfo_file = fopen (argc > 6 ? argv [6] : "docinfo_chg.txt", "wt");
	printf ("tune DocInfo.respodents for %ld docs\n", map_doc_respmask.size ());
	for (std::map<long,u_int64_t>::const_iterator map_it = map_doc_respmask.begin (); map_it != map_doc_respmask.end (); map_it++) {
		long id = map_it->first;
		u_int64_t mask = map_it->second;
		DocInfo docinfo;
		if (base->FindDocInfo (id, docinfo) == sizeof (DocInfo)) {
			//docinfo.hi_long_respondents = (long) ((mask >> 32) & 0xFFFFFFFF);
			//docinfo.long_respondents = (long) (mask & 0xFFFFFFFF);
			//base->ReplaceAttr (id, IDD_INFO, &docinfo, sizeof (docinfo));
			sprintf (str_to_write, "%ld:%lld\n", id, mask);
			fputs (str_to_write, docinfo_file);
		}
	}
	map_doc_respmask.clear ();
	fclose (docinfo_file);
	}

	{
	FILE *kindcorr_file = fopen (argc > 7 ? argv [7] : "kindcorr_chg.txt", "wt");

	printf ("tune KindCorr for %ld docs\n", real_new_docs.size ());
	KindCorrRef towrite [1024];
	gk_bzero (towrite, sizeof (towrite));
	Index* kindcorr_index = base->FindIndex ("KindCorr");

	std::vector<long> kindcorr_docs (real_new_docs.size () + newcorr_docs.size ());
	std::set_union (real_new_docs.begin (), real_new_docs.end (), newcorr_docs.begin (), newcorr_docs.end (), kindcorr_docs.begin ());
	std::sort (kindcorr_docs.begin (), kindcorr_docs.end ());
	kindcorr_docs.erase (std::unique (kindcorr_docs.begin (), kindcorr_docs.end ()), kindcorr_docs.end ());

	for (std::vector<long>::const_iterator it = kindcorr_docs.begin (); it != kindcorr_docs.end (); it++) {
		long id = *it;
		if (id) {
			sprintf (str_to_write, "%ld\n", id);
			fputs (str_to_write, kindcorr_file);
		}

		/*
		Stream* str = newcorrs_index->Open (&id);
		if (str) {
			printf ("%ld\r", id);
			int all_count = str->Length () / sizeof (CorrRef), corrrefs_count = 0;

			CorrRef buffer [1024];
			std::map<long,RefCollection*> map_sub_refs;
			while (all_count) {
				long count = str->Read (buffer, sizeof (buffer)) / sizeof (CorrRef);
				all_count -= count;
				CorrRef *ptr = buffer;
				for (int i = 0; i < count; i++, ptr++) {
					Ref at_i = {ptr->DocId, ptr->Block};
					std::map<long,RefCollection*>::iterator map_it = map_sub_refs.find (ptr->Sub);
					if (map_it == map_sub_refs.end ()) {
						RefCollection *refs = new RefCollection;
						refs->Insert (&at_i);
						map_sub_refs.insert (std::map<long,RefCollection*>::value_type (ptr->Sub, refs));
					} else {
						map_it->second->Insert (&at_i);
					}
				}
			}
			newcorrs_index->Close (str);

			for (std::map<long,RefCollection*>::iterator subs_it = map_sub_refs.begin (); subs_it != map_sub_refs.end (); subs_it++) {
				std::map<long,u_int64_t> map_segment_mask;
				for (int corrs = 0; corrs < CorrKinds_size; corrs++) {
					RefCollection *refs = new RefCollection (*subs_it->second);
					refs->Intersect (CorrKinds [corrs].refs);
					if (refs->ItemCount) {
						for (std::map<long,DocCollection*>::const_iterator seg_it = map_segment_docs.begin (); seg_it != map_segment_docs.end (); seg_it++) {
							if (refs->IsSect (*seg_it->second)) {
								std::map<long,u_int64_t>::iterator res_it = map_segment_mask.find (seg_it->first);
								if (res_it == map_segment_mask.end ()) {
									map_segment_mask.insert (std::map<long,u_int64_t>::value_type (seg_it->first, CorrKinds [corrs].mask));
								} else {
									res_it->second |= CorrKinds [corrs].mask;
								}
							}
						}
					}
					delete refs;
				}
				delete subs_it->second;

				KindCorrRef* ptr = towrite;
				long size = 0;
				for (std::map<long,u_int64_t>::const_iterator map_mask_it = map_segment_mask.begin (); map_mask_it != map_segment_mask.end (); map_mask_it++, ptr++, size += sizeof (*ptr)) {
					ptr->seg = (short) (map_mask_it->first & 0xFFFF);
					ptr->mask = map_mask_it->second;
				}

				if (size) {
					Ref ref = {id, subs_it->first};

					sprintf (str_to_write, "%ld.%ld:\n", ref.DocId, ref.Sub);
					fputs (str_to_write, kindcorr_file);
					ptr = towrite;
					for (int i = 0; i < size / sizeof (*ptr); i++, ptr++) {
						sprintf (str_to_write, "%lld.%ld\n", ptr->mask, ptr->seg);
						fputs (str_to_write, kindcorr_file);
					}
					strcpy (str_to_write, ":\n");
					fputs (str_to_write, kindcorr_file);

					//str = kindcorr_index->Open (&ref, 1);
					//if (str) {
					//	str->Write (towrite, size);
					//	kindcorr_index->Close (str);
					//}
				}
			}
			map_sub_refs.clear ();
		}
		*/
	}
	fclose (kindcorr_file);
	printf ("\n");
	}

	printf ("delete base\n");
#ifndef	_WIN64
	delete base;
#endif
	printf ("end\n");

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
