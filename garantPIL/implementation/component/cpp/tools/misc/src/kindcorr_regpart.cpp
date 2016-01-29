#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"
#include "osdep.h"

#include "gardefs.h"
#include "btiter.h"
#include "stdbase.h"
#include "SearchB.h"

#include "long.long.SplayMap.h"

#include "pack.h"
#include "garantPIL/implementation/component/cpp/libs/endt/BlockDecompile.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"

#include <boost/thread.hpp>

typedef std::map<u_int64_t, u_int64_t> map_ref_mask;

#define	MAX_THREADS	16
struct thread_data_struct {
	YBase *base;
	std::map<short, map_ref_mask> data;
	volatile int done;
};
thread_data_struct thread_data [MAX_THREADS];

std::map<long, std::set<long> > map_doc_editions;
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

void	LoadEdis (Base* base)
{
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (!str) {
		if (!base->FindIndex ("Aux")->Open ("InfL")) {
			printf ("run gl first!\n");
			exit (EXIT_FAILURE);
		}
	} else {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr++, doc = *ptr++;
			std::map<long, std::set<long> >::iterator it = map_doc_editions.find (doc);
			if (it == map_doc_editions.end ()) {
				std::set<long> editions;
				editions.insert (edition);
				editions.insert (doc);
				map_doc_editions.insert (std::map<long, std::set<long> >::value_type (doc, editions));
			} else {
				it->second.insert (edition);
			}
		}
	}
}

struct	CorrStruct {
	long	uid;
	u_int64_t	mask;
	RefCollection*	refs;
};

CorrStruct	CorrKinds [64];
long	CorrKinds_size = 0;

RefCollection	refs_with_kind;

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

/*
long	blockscount;
SubDesc2* blocks;

long	aak_block;
long	aak_from, aak_to;
*/

void	PrepareParaBlocks (YBase *base, long docId, long &blockscount, long &aak_block, long &aak_from, long &aak_to, SubDesc2* &blocks, long& refs_with_kind_iter)
{
	aak_block = -1, aak_from = -1, aak_to = -1;
	std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (docId);
	blocks = 0;
	bool is_aak = aak_it != map_aak_rightblock.end ();
	if (is_aak) aak_block = aak_it->second;

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
	//получили все сабы, у которых есть kind

	blocks = 0;
	blockscount = 0;
	if (blockswKind.ItemCount == 0)
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

			if (block == aak_block) {
				aak_from = structs_ptr->m_start_para;
				aak_to = structs_ptr->m_end_para + 1;
			}

			if (blockswKind.IndexOf (&block) != -1 ) {
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

long	FindParaBlock (SubDesc2* blocks, long para, long blockscount)
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

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

std::deque<long> topics_to_proceed;
std::deque<long>::const_iterator get_nextid_it;
ACE_Recursive_Thread_Mutex get_nextid_mutex;

long	get_nextid (bool next)
{
	long result = 0;
	RWRITE_GUARD (get_nextid_mutex) {
		if (get_nextid_it != topics_to_proceed.end ()) {
			result = *get_nextid_it;
			if (next)
				get_nextid_it++;
		}
	}
	return result;
}

void	process_doc (long &thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [thread_id]);
	thread_data_ptr->done = false;
	YBase* base = thread_data_ptr->base;
	std::map<short, map_ref_mask> *data = &thread_data_ptr->data;

	long blockscount, aak_block, aak_from, aak_to, refs_with_kind_iter = 0;
	SubDesc2* blocks = 0;

	for (;;) {
		long id = get_nextid (true), lRefs, segs;
		if (!id)
			break;

		std::map<long, std::set<long> >::const_iterator map_it = map_doc_editions.find (id);

		short *idd_segs = (short*) base->LoadAttr (id, IDD_BASES, segs), *copy_idd_segs = idd_segs;
		segs >>= 1;

		RespRef *idd_refs = (RespRef*) base->LoadAttr (id, IDD_REFS, lRefs), *copy_idd_refs = idd_refs;
		if (lRefs) {
			lRefs = lRefs / sizeof (RespRef);

			longlongSplayMap para_ids(-1);
			long lParaIds, *idd_paraids = (long*) base->LoadAttrEx (id, IDD2_PARAIDS, lParaIds);
			lParaIds /= sizeof (long );
			for (long apara = 0; apara < lParaIds; apara++)
				para_ids [idd_paraids [apara]] = apara;
			gk_free (idd_paraids);

			PrepareParaBlocks (base, id, blockscount, aak_block, aak_from, aak_to, blocks, refs_with_kind_iter);

			for (long aref = 0; aref < lRefs; aref++, idd_refs++) {
				if (idd_refs->DocId == id)
					continue;

				//еще надо проверить, что ссылка не на свою редакцию
				if (map_it != map_doc_editions.end ())
					if (map_it->second.find (idd_refs->DocId) != map_it->second.end ())
						continue;

				if (aak_block != -1) {
					long para = para_ids [idd_refs->ParaId];
					if (para >= aak_from && para < aak_to)
						continue;
				}
				Ref ref = {id, FindParaBlock (blocks, para_ids [idd_refs->ParaId], blockscount)};

				//теперь надо проверить, если ли этот блок в CorrKindes, и если есть - то набрать маски
				u_int64_t mask = 0;
				for (int i = 0; i < CorrKinds_size; i++) {
					if (CorrKinds[i].refs && CorrKinds[i].refs->IndexOf (&ref) != -1)
						mask |= CorrKinds[i].mask;
				}

				u_int64_t corr = (((u_int64_t) idd_refs->DocId) << 32) + idd_refs->Sub;
				idd_segs = copy_idd_segs;
				for (short seg_iter = 0; seg_iter < segs; seg_iter++, idd_segs++) {
					short seg = *idd_segs;
					if (seg < 401) {
						std::map<short,map_ref_mask>::iterator map_it = data->find (seg);
						std::map<u_int64_t,u_int64_t>::iterator mask_it = map_it->second.find (corr);
						if (mask_it == map_it->second.end ())
							map_it->second.insert (std::map<u_int64_t,u_int64_t>::value_type (corr, mask));
						else
							mask_it->second |= mask;
					}
				}
			}

			gk_free (copy_idd_refs);
			gk_free (blocks);
			blocks = 0;
		}

		gk_free (copy_idd_segs);
	}
	thread_data_ptr->done = true;
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;

	ToolsBase *base = new ToolsBase (argv [1]);
	base->open_saw_bases (ACE_OS_O_RDONLY);

	HIndex* index_kind = (HIndex*) base->FindIndex ("Kind");
	char full_key [1024];
	for (BTIterator it (index_kind); !it.End (); ++it) {
		HIndex::HIndexKey *k = (HIndex::HIndexKey*) it.Key ();

		if (k->level == 0) {
			Stream *str = index_kind->Index::OpenN (k,0);
			if (str) {
				RefCollection refs;
				refs.Get (str);
				index_kind->Close (str);
				refs_with_kind.Merge (refs);
			}
		}

		if (k->chCount)
			continue;
		
		index_kind->FullName (k, full_key);
		long uid = base->kind_key_to_uid (full_key);
		if (!uid)
			continue;

		u_int64_t mask = base->kind_uid_to_bit (uid);
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
	if (!CorrKinds_size) {
		printf ("not found Aux.KIds/KBit\n");
		exit (EXIT_FAILURE);
	}

	LoadEdis (base);
	get_aaks (base);

	DocCollection *alldocs = base->AllDocs ();
	for (int i = 0; i < alldocs->ItemCount; i++)
		topics_to_proceed.push_back ((*alldocs)[i]);
	delete alldocs;

	base->close_saw_bases ();
	delete base;

	get_nextid_it = topics_to_proceed.begin ();

	long threads_count = 1, thread_id, ok_threads = 0;
	if (argv [2])
		threads_count = std::min <long> (MAX_THREADS, std::max <long> (atol (argv [2]), 1));

	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		thread_data [thread_id].base = new YBase (argv [1], ACE_OS_O_RDONLY);
		thread_data [thread_id].base->IsOk ();
		thread_data [thread_id].base->open_saw_bases (ACE_OS_O_RDONLY);

		for (int i = 0; i < 401; i++)
			thread_data [thread_id].data.insert (std::map<short, map_ref_mask>::value_type (i, map_ref_mask()));
	
		boost::thread thread (process_doc, thread_id);
		thread.detach ();
		ok_threads++;
		ACE_OS::sleep (1);
	}

	long last_time = time (0);
	for (;;) {
		long id = get_nextid (false);
		if (id)
			last_time = time (0);
		else {
			int dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else if (time (0) - last_time > 30)
				break;
		}
		ACE_OS::sleep (5);
	}

	std::map<short, map_ref_mask> data;
	for (int i = 0; i < 401; i++)
		data.insert (std::map<short, map_ref_mask>::value_type (i, map_ref_mask()));

	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		thread_data [thread_id].base->close_saw_bases ();
		delete thread_data [thread_id].base;
	}

	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		std::map<short, map_ref_mask>::iterator out_it = data.begin (), in_it = thread_data [thread_id].data.begin ();
		for (; out_it != data.end (); out_it++, in_it++) {
			map_ref_mask::iterator out = out_it->second.begin ();
			map_ref_mask::iterator in = in_it->second.begin ();
			map_ref_mask add;
			while (out != out_it->second.end () && in != in_it->second.end ()) {
				u_int64_t at_out = out->first;
				u_int64_t  at_in = in->first;
				if (at_out < at_in)
					out++;
				else if (at_out > at_in)
					in++;
				else {
					out->second |= in->second;
					in++;
					out++;
				}
			}
			out_it->second.insert (in_it->second.begin (), in_it->second.end ());
		}
		thread_data [thread_id].data.clear ();
	}

	for (std::map<short, map_ref_mask>::const_iterator map_it = data.begin (); map_it != data.end (); map_it++) {
		const map_ref_mask *map_ref_mask_ptr = &map_it->second;
		if (!map_ref_mask_ptr->size ())
			continue;
		printf ("seg: %ld\n", (long)map_it->first);
		for (map_ref_mask::const_iterator mask_it = map_ref_mask_ptr->begin (); mask_it != map_ref_mask_ptr->end (); mask_it++) {
			Ref ref = {mask_it->first >> 32, mask_it->first & 0xFFFFFFFF};
			printf ("\t%ld.%ld:%lld\n", ref.DocId, ref.Sub, mask_it->second);
		}
	}

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
