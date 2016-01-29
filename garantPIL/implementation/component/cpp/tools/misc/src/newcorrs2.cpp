#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"

#include <cstdio>
#include <cstdlib>
#include <deque>

#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "pack.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"

#include "SearchB.h"

#include "garantPIL/implementation/component/cpp/libs/endt/BlockDecompile.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"

#include <boost/thread.hpp>

#include "shared/GCL/alg/set_operations.h"

YBase* base = 0;
std::map<long,long> map_aak_rightblock;
bool	b_preview = false;

struct	CorrStruct {
	long	uid;
	u_int64_t	mask;
	std::vector<u_int64_t> refs;
	std::vector<long> docs;
};

CorrStruct	CorrKinds [64];
long	CorrKinds_size = 0;

long	ParaToUniquePara (Ref aRef)
{
	long aSize, *aIDs = (long*) base->LoadAttrEx (aRef.DocId, IDD2_PARAIDS, aSize), aResult = 0;
	if (aRef.Sub < aSize)
		aResult = aIDs [aRef.Sub];

	if (aIDs)
		gk_free (aIDs);

	return aResult;
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;
	return mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
}

struct thread_data_struct {
	int done;
	SplayMap<long,u_int64_t> resps_masks;
	YBase *base;
	Index *resps;
	std::deque<long> docs_to_process;
};

#define MAX_THREADS 16
thread_data_struct thread_data [MAX_THREADS];

long *dic_docs = 0, dic_docs_count = 0;
Index *respondents;
ACE_Recursive_Thread_Mutex resps_masks_mutex;
std::vector<long>::const_iterator resps_it, corrs_it;
std::vector<long> docs_for_resps, keys_in_index_correspondent;
std::set<long> corrs_finddocinfo;
u_int32_tcaddr_tSplayMap *newCorrs;

RefCollection*	get_resps (long& doc_id)
{
	RWRITE_GUARD (resps_masks_mutex) {
		RefCollection* result = 0;
		if (resps_it == docs_for_resps.end ()) {
			doc_id = 0;
		} else {
			doc_id = *resps_it;
			resps_it++;

			Stream* str = respondents->Open (&doc_id);
			if (str) {
				result = new RefCollection;
				result->Get (str);
				respondents->Close (str);
			}
		}
		return result;
	}
}

void	calculate_resp_mask (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	for (std::deque<long>::const_iterator doc_it = thread_data_ptr->docs_to_process.begin (); doc_it != thread_data_ptr->docs_to_process.end (); doc_it++) {
		long doc_id = *doc_it;
		Stream *str = thread_data_ptr->resps->Open (&doc_id);
		if (str) {
			std::vector<u_int64_t> refs;
			std::vector<long> docs;
			long size = str->Length () / sizeof (Ref);
			refs.resize (size);
			for (int i = 0; i < size; i++) {
				Ref ref;
				str->Read (&ref, sizeof (Ref));
				u_int64_t ati = (((u_int64_t) ref.DocId) << 32) + ref.Sub;
				refs [i] = ati;
				docs.push_back (ref.DocId);
			}
			docs.erase (std::unique (docs.begin (), docs.end ()), docs.end ());
			thread_data_ptr->resps->Close (str);

			u_int64_t kind_mask = 0;
			for (int j = 0; j < CorrKinds_size; j++) {
				if (GCL::has_intersection (refs.begin (), refs.end (), CorrKinds [j].refs.begin (), CorrKinds [j].refs.end ()) || GCL::has_intersection (docs.begin (), docs.end (), CorrKinds [j].docs.begin (), CorrKinds [j].docs.end ()))
					kind_mask |= CorrKinds [j].mask;
			}

			if (kind_mask)
				thread_data_ptr->resps_masks [doc_id] = kind_mask;
		}
	}
	thread_data_ptr->done = 1;
}

StorableSplaySet<CorrRef>* get_corrs (long& doc_id)
{
	RWRITE_GUARD (resps_masks_mutex) {
		StorableSplaySet<CorrRef>* result = 0;
		if (corrs_it == keys_in_index_correspondent.end ()) {
			doc_id = 0;
		} else {
			doc_id = *corrs_it;
			corrs_it++;
			if (newCorrs->contains (doc_id)) {
				DocInfo docinfo;
				if (base->FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
					result = (StorableSplaySet<CorrRef>*)(*newCorrs)[doc_id];
					corrs_finddocinfo.insert (doc_id);
				}
			}
		}
		return result;
	}
}

void	calculate_corr_mask (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	for (;;) {
		long doc_id;
		StorableSplaySet<CorrRef>* at = get_corrs (doc_id);
		if (!doc_id)
			break;

		if (at && at->length ()) {
			std::vector<u_int64_t> resp_refs;
			std::vector<long> resp_docs;
			for (Point p = at->first(); p; at->next (p)) {
				const CorrRef *atP = (*at)[p];
				u_int64_t refP = (((u_int64_t) atP->DocId) << 32) + atP->Block;
				resp_refs.push_back (refP);
				resp_docs.push_back (atP->DocId);
			}
			std::sort (resp_refs.begin (), resp_refs.end ());
			resp_refs.erase (std::unique (resp_refs.begin (), resp_refs.end ()), resp_refs.end ());

			std::sort (resp_docs.begin (), resp_docs.end ());
			resp_docs.erase (std::unique (resp_docs.begin (), resp_docs.end ()), resp_docs.end ());

			u_int64_t corrs_mask = 0;
			for (int i = 0; i < CorrKinds_size; i++) {
				if (GCL::has_intersection (resp_refs.begin (), resp_refs.end (), CorrKinds [i].refs.begin (), CorrKinds [i].refs.end ()) || GCL::has_intersection (resp_docs.begin (), resp_docs.end (), CorrKinds [i].docs.begin (), CorrKinds [i].docs.end ()))
					corrs_mask |= CorrKinds [i].mask;
			}
			if (corrs_mask)
				thread_data_ptr->resps_masks [doc_id] = corrs_mask;
		}
	}
	thread_data_ptr->done = 1;
}

void	get_aaks (Base* base)
{
	if (b_preview)
		return ;

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

ACE_Recursive_Thread_Mutex get_base_mutex;
std::vector<YBase*> base_ptrs;
std::vector<YBase*>::iterator get_base_it;

YBase*	get_base (bool next)
{
	RWRITE_GUARD (get_base_mutex) {
		if (get_base_it == base_ptrs.end ())
			return 0;
		YBase* result = *get_base_it;
		if (next)
			get_base_it++;
		return result;
	}
}

std::set<long> set_dic_docs;
std::deque<long> all_docs_and_editions;

void	create_part_file (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	while (true) {
		YBase *base = get_base (true);
		if (base == 0)
			break;

		std::string part_file_name = base->textFile->FileName;
		part_file_name.erase (part_file_name.find ('.'));
		part_file_name += ".part";
		FILE *out_file = fopen (part_file_name.c_str (), "wt");
		if (!out_file)
			printf ("cant create %s\n", part_file_name.c_str ());

		std::map<long, std::set<long> > map_doc_editions;

		std::set<long> docs_and_editions;
		std::set<long>::const_iterator long_set_it;

		//AttrIndex *docInd = (AttrIndex*) base->FindIndex ("Attrs");

		//printf ("processing refs in %s\n", base_name.c_str ());

		get_aaks (base);
		{
			Stream *str = base->FindIndex ("Aux")->Open ("Edis");
			long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
			str->Read (data, size);
			base->FindIndex ("Aux")->Close (str);
			size >>= 3;
			for (int i = 0; i < size; i++) {
				long edition = *ptr;
				ptr++;
				long doc = *ptr;
				ptr++;
				docs_and_editions.insert (edition);
				docs_and_editions.insert (doc);

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
			delete data;

			//надо также для каждой редакции иметь список ее редакций
			std::map<long,std::set<long> > map_edition_editions;
			for (std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.begin (); map_it != map_doc_editions.end (); map_it++) {
				for (std::set<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
					map_edition_editions.insert (std::map<long,std::set<long> >::value_type (*it, map_it->second));
				}
			}
			map_doc_editions.insert (map_edition_editions.begin (), map_edition_editions.end ());

			DocCollection* all_docs = base->AllDocs ();
			for (int i = 0; i < all_docs->ItemCount; i++)
				docs_and_editions.insert ((*all_docs) [i]);
			delete all_docs;
		}

		long aTopics = docs_and_editions.size (), aPerc = aTopics / 100L, aCurrPerc = 0,  aaPerc = 0;
		aCurrPerc = aaPerc = 0;
		for (std::set<long>::const_iterator docs_and_editions_it = docs_and_editions.begin (); docs_and_editions_it != docs_and_editions.end (); docs_and_editions_it++) {
			long docId = *docs_and_editions_it;

			if (set_dic_docs.find (docId) != set_dic_docs.end ())
				continue;

			std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (docId);
			bool is_aak = aak_it != map_aak_rightblock.end ();

			if (++aCurrPerc > aPerc) {
				aCurrPerc = 0;
				printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
			}

			long lRefs;
			RespRef *iddrefs = (RespRef*) base->LoadAttr (docId, IDD_REFS, lRefs), *copy = iddrefs;

			if (lRefs) {
				lRefs /= sizeof (RespRef);

				long lBlocks, *blocks = (long*) base->LoadAttr (docId, IDD_REFS_BLOCKS, lBlocks), *blocks_ptr = blocks;

				std::map<long,std::set<long> >::const_iterator map_doc_editions_it = map_doc_editions.find (docId);

				for (long aref = 0; aref < lRefs; aref++, iddrefs++, blocks_ptr += 2) {
					long refsid = iddrefs->DocId;

					if (!std::binary_search (all_docs_and_editions.begin (), all_docs_and_editions.end (), refsid) ||
						(refsid == docId) ||
						((map_doc_editions_it != map_doc_editions.end ()) && (map_doc_editions_it->second.find (refsid) != map_doc_editions_it->second.end ()))
						)
						continue;

					CorrRef corrRefAdd;
					corrRefAdd.Sub      = iddrefs->Sub;
					corrRefAdd.DocId    = docId;
					corrRefAdd.Para     = iddrefs->ParaId;
					corrRefAdd.RealPara = *blocks_ptr;
					corrRefAdd.Block    = *(blocks_ptr+1);

					if (is_aak && aak_it->second == corrRefAdd.Block)
						continue;

					if (out_file)
						fprintf (out_file, "%ld: %ld.%ld.%ld.%ld.%ld\n", iddrefs->DocId, corrRefAdd.Block, corrRefAdd.DocId, corrRefAdd.Para, corrRefAdd.RealPara, corrRefAdd.Sub);
				}

				gk_free (copy);
				if (blocks)
					gk_free (blocks);
			}
		}

		if (out_file)
			fclose (out_file);
	}

	thread_data_ptr->done = 1;
}


int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	if (!strcmp (argv [1], "-clearnewcorr")) {
		StdBigBase *out_base = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		out_base->FindIndex ("NewCorr")->KeyCount = 0;
		delete out_base;
		exit (EXIT_SUCCESS);
	}

	for (int i = 1; i < argc; i++)
		b_preview |= !stricmp (argv [i], "-preview");

	if (!strcmp (argv [1], "-partswork")) {
		int begin_arg = 2 + (b_preview ? 1 : 0);

		int bases;
		for (bases = begin_arg + 1; bases < argc; bases++) {
			std::set<long> docs_and_editions;
			std::set<long>::const_iterator long_set_it;

			printf ("docs and editions in %s", argv [bases]); fflush (stdout);
			YBase *base = new YBase (argv [bases], ACE_OS_O_RDONLY);
			base->IsOk ();
			base_ptrs.push_back (base);

			short   aDicSeg = DICTIONARY_SEGMENT;
			Stream *str = base->FindIndex ("Segment")->Open (&aDicSeg);
			if (str) {
				dic_docs_count = str->Length () >> 2;
				long *_dic_docs = new long [dic_docs_count];
				str->Read (_dic_docs, str->Length ());
				base->FindIndex ("Segment")->Close (str);
				for (int i = 0; i < dic_docs_count; i++)
					set_dic_docs.insert (_dic_docs [i]);
				delete [] _dic_docs;
			}

			//получить список документов и редакций - объединить edis и AllDocs
			{
				Stream *str = base->FindIndex ("Aux")->Open ("Edis");
				long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
				str->Read (data, size);
				base->FindIndex ("Aux")->Close (str);
				size >>= 3;
				for (int i = 0; i < size; i++) {
					long edition = *ptr;
					ptr++;
					long doc = *ptr;
					ptr++;
					docs_and_editions.insert (edition);
					docs_and_editions.insert (doc);
				}
			}
			DocCollection* all_docs = base->AllDocs ();
			for (int i = 0; i < all_docs->ItemCount; i++)
				docs_and_editions.insert ((*all_docs) [i]);
			delete all_docs;

			printf (": %ld\n", docs_and_editions.size ());

			for (long_set_it = docs_and_editions.begin (); long_set_it != docs_and_editions.end (); long_set_it++)
				all_docs_and_editions.push_back (*long_set_it);
		}

		std::sort (all_docs_and_editions.begin (), all_docs_and_editions.end ());
		get_base_it = base_ptrs.begin ();

		if (0 == atol (argv [begin_arg])) {
			FILE *out_file = fopen (argv [begin_arg], "wt");
			if (!out_file)
				printf ("cant create %s\n", argv [begin_arg]); fflush (stdout);

			for (bases = begin_arg + 1; bases < argc; bases++, get_base_it++) {
				std::map<long, std::set<long> > map_doc_editions;

				std::set<long> docs_and_editions;
				std::set<long>::const_iterator long_set_it;

				base = *get_base_it;
				//docInd = (AttrIndex*) base->FindIndex ("Attrs");

				printf ("processing refs in %s\n", argv [bases]);

				get_aaks (base);
				{
					Stream *str = base->FindIndex ("Aux")->Open ("Edis");
					long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
					str->Read (data, size);
					base->FindIndex ("Aux")->Close (str);
					size >>= 3;
					for (int i = 0; i < size; i++) {
						long edition = *ptr;
						ptr++;
						long doc = *ptr;
						ptr++;
						docs_and_editions.insert (edition);
						docs_and_editions.insert (doc);

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
					delete data;

					//надо также для каждой редакции иметь список ее редакций
					std::map<long,std::set<long> > map_edition_editions;
					for (std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.begin (); map_it != map_doc_editions.end (); map_it++) {
						for (std::set<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
							map_edition_editions.insert (std::map<long,std::set<long> >::value_type (*it, map_it->second));
						}
					}
					map_doc_editions.insert (map_edition_editions.begin (), map_edition_editions.end ());

					DocCollection* all_docs = base->AllDocs ();
					for (int i = 0; i < all_docs->ItemCount; i++)
						docs_and_editions.insert ((*all_docs) [i]);
					delete all_docs;
				}

				long aTopics = docs_and_editions.size (), aPerc = aTopics / 100L, aCurrPerc = 0,  aaPerc = 0;
				aCurrPerc = aaPerc = 0;
				for (std::set<long>::const_iterator docs_and_editions_it = docs_and_editions.begin (); docs_and_editions_it != docs_and_editions.end (); docs_and_editions_it++) {
					long docId = *docs_and_editions_it;

					if (set_dic_docs.find (docId) != set_dic_docs.end ())
						continue;

					std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (docId);
					bool is_aak = aak_it != map_aak_rightblock.end ();

					if (++aCurrPerc > aPerc) {
						aCurrPerc = 0;
						printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
					}

					long lRefs;
					RespRef *iddrefs = (RespRef*) base->LoadAttr (docId, IDD_REFS, lRefs), *copy = iddrefs;

					if (lRefs) {
						lRefs /= sizeof (RespRef);

						long lBlocks, *blocks = (long*) base->LoadAttr (docId, IDD_REFS_BLOCKS, lBlocks), *blocks_ptr = blocks;

						std::map<long,std::set<long> >::const_iterator map_doc_editions_it = map_doc_editions.find (docId);

						for (long aref = 0; aref < lRefs; aref++, iddrefs++, blocks_ptr += 2) {
							long refsid = iddrefs->DocId;

							if (!std::binary_search (all_docs_and_editions.begin (), all_docs_and_editions.end (), refsid) ||
								(refsid == docId) ||
								((map_doc_editions_it != map_doc_editions.end ()) && (map_doc_editions_it->second.find (refsid) != map_doc_editions_it->second.end ()))
								)
								continue;

							CorrRef corrRefAdd;
							corrRefAdd.Sub      = iddrefs->Sub;
							corrRefAdd.DocId    = docId;
							corrRefAdd.Para     = iddrefs->ParaId;
							corrRefAdd.RealPara = *blocks_ptr;
							corrRefAdd.Block    = *(blocks_ptr+1);

							if (is_aak && aak_it->second == corrRefAdd.Block)
								continue;

							fprintf (out_file, "%ld: %ld.%ld.%ld.%ld.%ld\n", iddrefs->DocId, corrRefAdd.Block, corrRefAdd.DocId, corrRefAdd.Para, corrRefAdd.RealPara, corrRefAdd.Sub);
						}

						gk_free (copy);
						if (blocks)
							gk_free (blocks);
					}
				}

				delete base;
				printf( "\n" ); fflush( stdout );	
			}

			if (out_file)
				fclose (out_file);
		} else {
			long threads_count = atol (argv [begin_arg]), ok_threads = 0;
			if (threads_count > MAX_THREADS)
				threads_count = MAX_THREADS;
			for (long threads = 0; threads < threads_count; threads++, ok_threads++) {
				thread_data [threads].done = 0;
				boost::thread thread (create_part_file, threads);
				thread.detach ();
			}
			for (;;) {
				YBase* base = get_base (false);
				if (base) {
					ACE_OS::sleep (5);
				} else {
					long dones = 0;
					for (int thread_id = 0; thread_id < threads_count; thread_id++)
						if (thread_data [thread_id].done)
							dones++;
					if (dones == ok_threads)
						break;
					else
						ACE_OS::sleep (1);
				}
			}
		}

		exit (EXIT_SUCCESS);
	}

	{
	SearchBase *base = new SearchBase (argv [1]);
	base->IsOk ();
	base->check_version ();
	delete base->AllDocs ();

	HIndex* index_kind = (HIndex*) base->FindIndex ("Kind");
	char full_key [1024];
	for (BTIterator it (index_kind); !it.End (); ++it) {
		HIndex::HIndexKey *k = (HIndex::HIndexKey*) it.Key ();
		if (k->chCount)
			continue;
		
		index_kind->FullName (k, full_key);
		printf ("Read Kind: %s\n", full_key); fflush (stdout);
		long uid = base->kind_key_to_uid (full_key);
		if (!uid) {
			printf ("no uid for kind %s\n", full_key); fflush (stdout);
		}
		u_int64_t mask = base->kind_uid_to_bit (uid);
		Stream *str = index_kind->Index::OpenN (k,0);
		if (str) {
			long length = str->Length () / sizeof (Ref);
			CorrKinds [CorrKinds_size].refs.resize (length);;
			for (int i = 0; i < length; i++) {
				Ref ref;
				str->Read (&ref, sizeof (Ref));
				u_int64_t ati = (((u_int64_t) ref.DocId) << 32) + ref.Sub;
				CorrKinds [CorrKinds_size].refs [i] = ati;
				if (0 == ref.Sub)
					CorrKinds [CorrKinds_size].docs.push_back (ref.DocId);
			}
			CorrKinds [CorrKinds_size].docs.erase (std::unique (CorrKinds [CorrKinds_size].docs.begin (), CorrKinds [CorrKinds_size].docs.end ()), CorrKinds [CorrKinds_size].docs.end ());

			CorrKinds [CorrKinds_size].uid = uid;
			CorrKinds [CorrKinds_size].mask = mask;
			index_kind->Close (str);
			CorrKinds_size++;
		}
	}
	delete base;
	}

	base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->IsOk ();
	base->open_saw_bases (ACE_OS_O_RDONLY);
	BTIterator *it;

	//docInd = (AttrIndex*) base->FindIndex ("Attrs");
	respondents = base->FindIndex ("Respondent");

	SplayMap<long,u_int64_t> resps_masks, corrs_masks;

	short   aDicSeg = DICTIONARY_SEGMENT;
	Stream *str = base->FindIndex ("Segment")->Open (&aDicSeg);
	if (str) {
		dic_docs_count = str->Length () >> 2;
		dic_docs = new long [dic_docs_count];
		str->Read (dic_docs, str->Length ());
		base->FindIndex ("Segment")->Close (str);
	}

	std::vector<long> docs, docs_and_editions, all_docs, skip_docs;
	std::vector<long>::const_iterator long_vector_it;
	std::map<long, std::set<long> > *map_doc_editions = new std::map<long, std::set<long> >;

	printf ("Calculate Edis\n"); fflush (stdout);
	str = base->FindIndex ("Aux")->Open ("Edis");
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
			ptr++;
		}
		delete data;
	}
	std::sort (docs_and_editions.begin (), docs_and_editions.end ());
	docs_and_editions.erase (std::unique (docs_and_editions.begin (), docs_and_editions.end ()), docs_and_editions.end ());

	get_aaks (base);

	DocCollection *collection_alldocs = base->AllDocs ();
	static const AttrKey key = {ID_BORDER, IDD_INFO};
	printf ("get all topics: begin ");
	for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
		for (it = new BTIterator ((*base_it)->FindIndex ("Attrs"), &key); !it->End (); ++(*it) ) {
			AttrKey * ptr = (AttrKey *) it->Key();
			if (ptr->AttrTag != IDD_INFO)
				break;

			long id = ptr->DocId;
			all_docs.push_back (id);

			if (!std::binary_search (docs_and_editions.begin (), docs_and_editions.end (), id)) {
				if (collection_alldocs->IndexOf (&id) == -1)
					skip_docs.push_back (id);
				else
					docs.push_back (id);
			}
		}
		delete it;
	}
	delete collection_alldocs;

	std::sort (all_docs.begin (), all_docs.end ()); all_docs.erase (std::unique (all_docs.begin (), all_docs.end ()), all_docs.end ());
	std::sort (skip_docs.begin (), skip_docs.end ()); skip_docs.erase (std::unique (skip_docs.begin (), skip_docs.end ()), skip_docs.end ());
	std::sort (docs.begin (), docs.end ()); docs.erase (std::unique (docs.begin (), docs.end ()), docs.end ());

	docs_and_editions.insert (docs_and_editions.begin (), docs.begin (), docs.end ());
	std::sort (docs_and_editions.begin (), docs_and_editions.end ());
	docs_and_editions.erase (std::unique (docs_and_editions.begin (), docs_and_editions.end ()), docs_and_editions.end ());
	docs.swap (std::vector<long> ());
	printf ("end\nAllTopics: %ld\n", all_docs.size ());

	long threads_count = 1, thread_id;

	if (argc > 2 && atol (argv [2]))
		threads_count = atol (argv [2]);
	else
	if (argc > 3 && atol (argv [3]))
		threads_count = atol (argv [3]);

	if (threads_count != 1)
		printf ("Threads: %ld\n", threads_count);

	for (long_vector_it = all_docs.begin (); long_vector_it != all_docs.end (); long_vector_it++) {
		long doc_id = *long_vector_it;
		if (!bsearch (&doc_id, dic_docs, dic_docs_count, sizeof (long), longcmp))
			if (!std::binary_search (skip_docs.begin (), skip_docs.end (), doc_id))
				docs_for_resps.push_back (doc_id);
	}

	long aTopics = docs_for_resps.size (), aPerc = aTopics / 100L, aCurrPerc = 0,  aaPerc = 0;
	long _time = time (0);
	printf ("Processing respondents (masks: %ld)\n", CorrKinds_size);

	const int magic_count = 4; //кол-во потоков для обсчета. Не может быть слишком большим, а то памяти не хватит
	
	{
	for (BTIterator it (respondents); !it.End (); ++it) {
		long doc_id = *(long*) it.Key ();
		thread_data [doc_id % magic_count].docs_to_process.push_back (doc_id);
	}
	}

	resps_it = docs_for_resps.begin ();
	newCorrs = new u_int32_tcaddr_tSplayMap ((caddr_t)0);
	for (thread_id = 0; thread_id < magic_count/*threads_count*/; thread_id++) {
		thread_data [thread_id].done = 0;
		thread_data [thread_id].base = new YBase (argv [1], ACE_OS_O_RDONLY);
		thread_data [thread_id].base->IsOk ();
		thread_data [thread_id].resps = thread_data [thread_id].base->FindIndex ("Respondent");
		boost::thread thread (calculate_resp_mask, thread_id);
		thread.detach ();
	}
	for (;;) {
		int dones = 0;
		for (thread_id = 0; thread_id < magic_count/*threads_count*/; thread_id++)
			if (thread_data [thread_id].done)
				dones++;
		if (dones == magic_count/*threads_count*/)
			break;
		else
			ACE_OS::sleep (1);
	}
	for (thread_id = 0; thread_id < magic_count/*threads_count*/; thread_id++) {
		SplayMap<long,u_int64_t> *resps_masks_ptr = &thread_data [thread_id].resps_masks;
		for (Point p = resps_masks_ptr->first (); p; resps_masks_ptr->next (p)) {
			long doc_id = resps_masks_ptr->key (p);
			u_int64_t mask = resps_masks_ptr->contents (p);
			resps_masks [doc_id] = mask;
		}
		resps_masks_ptr->clear ();

		thread_data [thread_id].docs_to_process.swap (std::deque<long> ());
		delete thread_data [thread_id].base;
	}

	{
	for (int j = 0; j < CorrKinds_size; j++) {
		std::vector<long> empty_docs;
		CorrKinds [j].docs.swap (empty_docs);

		std::vector<u_int64_t> empty_refs;
		CorrKinds [j].refs.swap (empty_refs);
	}
	}

	printf ("Done. Resps_masks: %ld, time: %ldsec\n", resps_masks.length (), (long)(time (0) - _time));

	_time = time (0);
	{
		str = base->FindIndex ("Aux")->Open ("Edis");
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			ptr++;
			long doc = *ptr;
			ptr++;

			std::map<long, std::set<long> >::iterator it = map_doc_editions->find (doc);
			if (it == map_doc_editions->end ()) {
				std::set<long> editions;
				editions.insert (edition);
				editions.insert (doc);
				map_doc_editions->insert (std::map<long, std::set<long> >::value_type (doc, editions));
			} else {
				it->second.insert (edition);
			}
		}
		delete data;

		//надо также для каждой редакции иметь список ее редакций
		std::map<long,std::set<long> > map_edition_editions;
		for (std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions->begin (); map_it != map_doc_editions->end (); map_it++) {
			for (std::set<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
				map_edition_editions.insert (std::map<long,std::set<long> >::value_type (*it, map_it->second));
			}
		}
		map_doc_editions->insert (map_edition_editions.begin (), map_edition_editions.end ());
	}

	bool write_in_txt = false;
	FILE *out_file = 0;
	if (argc > 2 && strcmp (argv [2], "-daily")) {
		if (atol (argv [2])) {
			threads_count = atol (argv [2]);
			if (argv [3]) {
				write_in_txt = true;
				out_file = fopen (argv [3], "wt");
			}
		} else {
			write_in_txt = true;
			out_file = fopen (argv [2], "wt");
		}
	}

	if (!write_in_txt) {
		printf( "\nProcessing all refs\n", aTopics ); fflush( stdout );
		aCurrPerc = aaPerc = 0;
		for (long_vector_it = docs_for_resps.begin (); long_vector_it != docs_for_resps.end (); long_vector_it++) {
			long docId = *long_vector_it;

			std::map<long,long>::const_iterator aak_it = map_aak_rightblock.find (docId);
			bool is_aak = aak_it != map_aak_rightblock.end ();

			if (++aCurrPerc > aPerc) {
				aCurrPerc = 0;
				printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
			}

			long lRefs;
			RespRef *iddrefs = (RespRef*) base->LoadAttr (docId, IDD_REFS, lRefs), *copy = iddrefs;

			if (lRefs) {
				lRefs /= sizeof (RespRef);

				long lBlocks, *blocks = (long*) base->LoadAttr (docId, IDD_REFS_BLOCKS, lBlocks), *blocks_ptr = blocks;

				std::map<long,std::set<long> >::const_iterator map_doc_editions_it = map_doc_editions->find (docId);

				for (long aref = 0; aref < lRefs; aref++, iddrefs++, blocks_ptr += 2) {
					long refsid = iddrefs->DocId;

					if (!std::binary_search( docs_and_editions.begin (), docs_and_editions.end (), refsid) ||
						(refsid == docId) ||
						((map_doc_editions_it != map_doc_editions->end ()) && (map_doc_editions_it->second.find (refsid) != map_doc_editions_it->second.end ()))
						)
						continue;

					CorrRef corrRefAdd;
					corrRefAdd.Sub      = iddrefs->Sub;
					corrRefAdd.DocId    = docId;
					corrRefAdd.Para     = iddrefs->ParaId;
					corrRefAdd.RealPara = *blocks_ptr;
					corrRefAdd.Block    = *(blocks_ptr+1);

					if (is_aak && aak_it->second == corrRefAdd.Block)
						continue;

					if (write_in_txt) {
						fprintf (out_file, "%ld: %ld.%ld.%ld.%ld.%ld\n", iddrefs->DocId, corrRefAdd.Block, corrRefAdd.DocId, corrRefAdd.Para, corrRefAdd.RealPara, corrRefAdd.Sub);
					} else {
						StorableSplaySet<CorrRef>* nc = (StorableSplaySet<CorrRef>*)(*newCorrs)[iddrefs->DocId];
						if ( !nc ) {
							nc = new StorableSplaySet<CorrRef>;
							(*newCorrs)[refsid] = (caddr_t) nc;
						}
						nc->add(corrRefAdd);
					}
				}

				gk_free (copy);
				if (blocks)
					gk_free (blocks);
			}
		}
		printf ("Done. NewCorrs: %ld, time: %ldsec\n", newCorrs->length (), (long)(time (0) - _time));
	}

	delete base;
	if (out_file)
		fclose (out_file);

	printf( "\n" ); fflush( stdout );

	bool b_daily = false;
	if ((argc == 3 && !stricmp (argv [2], "-daily")) || (argc == 4 && !stricmp (argv [3], "-daily")))
		b_daily = true;

	base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	base->open_saw_bases (ACE_OS_O_RDWR);
	//docInd = (AttrIndex*) base->FindIndex ("Attrs");
	Index* newCorrIndex = base->FindIndex ("NewCorr");
	Index* index = base->FindIndex ("Correspondent");
	Index* indexr = base->FindIndex ("Respondent");
	aPerc = index->KeyCount / 100L;
	aCurrPerc = aaPerc = 0;

	std::set<long> processed_resps;
	long *pdocIdT;

	if (write_in_txt) {
		//вроде в этом цикле ничего и не происходит
		for (it = new BTIterator(index); !it->End(); ++*it ) {
			long id = *(long*)it->Key();
			if (!newCorrs->contains (id))
				continue;

			DocInfo docInfo;
			if (base->FindDocInfo (id, docInfo) == sizeof (DocInfo)) {
				processed_resps.insert (id);
				u_int64_t _mask = resps_masks [id];
				docInfo.hi_long_respondents = (long) ((_mask >> 32) & 0xFFFFFFFF);
				docInfo.long_respondents = (long) (_mask & 0xFFFFFFFF);
				base->ReplaceAttr (id, IDD_INFO, &docInfo, sizeof (docInfo));
			}
		}
		delete it;
	} else {
		std::vector<long> processed_ids;

		for (it = new BTIterator (index); !it->End (); ++*it)
			keys_in_index_correspondent.push_back (*(long*)it->Key());
		delete it;

		_time = time (0);
		printf ("Calculate corrs_masks\n"); fflush (stdout);
		corrs_it = keys_in_index_correspondent.begin ();
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].done = 0;
			boost::thread thread (calculate_corr_mask, thread_id);
			thread.detach ();
			ACE_OS::sleep (1);
		}
		for (;;) {
			int dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].done)
					dones++;
			if (dones == threads_count)
				break;
			else
				ACE_OS::sleep (5);
		}
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			SplayMap<long,u_int64_t> *resps_masks_ptr = &thread_data [thread_id].resps_masks;
			for (Point p = resps_masks_ptr->first (); p; resps_masks_ptr->next (p)) {
				long doc_id = resps_masks_ptr->key (p);
				u_int64_t mask = resps_masks_ptr->contents (p);
				corrs_masks [doc_id] = mask;
			}
			resps_masks_ptr->clear ();
		}
		printf ("Done. Corrs_masks: %ld, time: %ldsec\n\n", corrs_masks.length (), (long)(time (0) - _time));

		_time = time (0);
		printf ("Flushing index NewCorr\n"); fflush (stdout);
		for (long_vector_it = keys_in_index_correspondent.begin (); long_vector_it != keys_in_index_correspondent.end (); long_vector_it++) {
			long doc_id = *long_vector_it;

			if (++aCurrPerc > aPerc) {
				aCurrPerc = 0;
				printf ("%ld%%\r", ++aaPerc); fflush (stdout);
			}

			if (!newCorrs->contains (doc_id))
				continue;

			StorableSplaySet<CorrRef>* at = (StorableSplaySet<CorrRef>*)(*newCorrs)[doc_id];
			if (at && at->length ()) {
				Stream *str = newCorrIndex->Open (&doc_id, 1);
				at->Put (str);
				str->Trunc ();
				newCorrIndex->Close (str);
				processed_ids.push_back (doc_id);

				if (corrs_finddocinfo.find (doc_id) != corrs_finddocinfo.end ()) {
					DocInfo docinfo;
					base->FindDocInfo (doc_id, docinfo);
					u_int64_t _mask = resps_masks [doc_id];
					docinfo.hi_long_respondents = (long) ((_mask >> 32) & 0xFFFFFFF);
					docinfo.long_respondents = (long) (_mask & 0xFFFFFFF);
					base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (DocInfo));
				}

				at->clear ();
				delete at;
			}
		}

		std::vector<long> to_delete;
		for (it = new BTIterator (newCorrIndex); !it->End (); ++(*it)) {
			long id = *(long*) it->Key ();
			if (!std::binary_search (processed_ids.begin (), processed_ids.end (), id))
				to_delete.push_back (id);
		}
		delete it;
		for (std::vector<long>::const_iterator it = to_delete.begin (); it != to_delete.end (); it++) {
			long id = *it;
			newCorrIndex->Delete (&id);
		}
		printf ("Done. Keys in NewCorrs: %ld, time: %ldsec\n", newCorrIndex->KeyCount, (long)(time (0) - _time));
	}

	printf( "\nFlushing DocInfo.Respondents\n" ); fflush( stdout );
	aPerc = resps_masks.length() / 100L, aCurrPerc = aaPerc = 0;
	//плюс еще типизированные респонденты
	for ( Point ii = resps_masks.first(); ii; resps_masks.next(ii) ) {
		if ( ++aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
		}

		long docId = resps_masks.key (ii);
		if (processed_resps.find (docId) == processed_resps.end ()) {
			DocInfo docInfo;
			if (base->FindDocInfo (docId, docInfo) == sizeof (DocInfo)) {
				u_int64_t mask = resps_masks.contents (ii);
				docInfo.hi_long_respondents = (long) ((mask >> 32) & 0xFFFFFFFF);
				docInfo.long_respondents = (long) (mask & 0xFFFFFFFF);
				base->ReplaceAttr (docId, IDD_INFO, &docInfo, sizeof (docInfo));
			}
		}
	}
	processed_resps.swap (std::set<long> ());
	resps_masks.clear ();

	printf( "\nRemove garbage\n" ); fflush( stdout );
	aPerc = all_docs.size () / 100L, aCurrPerc = aaPerc = 0;
	for (long_vector_it = all_docs.begin (); long_vector_it != all_docs.end (); long_vector_it++) {
		if (++aCurrPerc > aPerc) {
			aCurrPerc = 0;
			printf ("%ld%%\r", ++aaPerc); fflush (stdout);
		}
		base->DelAttrKey (*long_vector_it, IDD_REFS_BLOCKS);
	}
	all_docs.swap (std::vector<long> ());
	printf ("\n");

	std::set<long> contents_ids;
	for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
		AttrKey contents_key = {ID_BORDER, IDD_CONTENTS};
		BTIterator attrs_it ((*base_it)->FindIndex ("Attrs"));
		for (attrs_it.Set (&contents_key); !attrs_it.End (); ++attrs_it) {
			AttrKey* key = (AttrKey*)attrs_it.Key ();
			if (key->AttrTag == IDD_CONTENTS)
				contents_ids.insert (key->DocId);
			else
				break;
		}
	}

	delete newCorrs;

	printf( "\nTune index Correspondent\n" ); fflush( stdout );
	aPerc = index->KeyCount / 100L;
	aCurrPerc = aaPerc = 0;
	std::set<long> to_delete;
	for (it = new BTIterator( index ); !it->End(); ++*it ) {
		pdocIdT = (long*)it->Key();

		aCurrPerc++;
		if ( aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
		}

		if (!b_daily && !std::binary_search (docs_and_editions.begin (), docs_and_editions.end (), *pdocIdT)) {
			to_delete.insert (*pdocIdT);
			continue;
		}

		StorableSplaySet<Ref> corrs;
		Stream *str = index->keyOpen (pdocIdT, 0);
		corrs.Get(str);
		index->Close (str);
		
		StorableSplaySet<Ref> modcorrs;
		for (Point p = corrs.first (); p; corrs.next (p)) {
			bool may = false;
			std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions->find (*pdocIdT);
			if (map_it == map_doc_editions->end ())
				may = true;
			else {
				if (map_it->second.find (corrs.contents(p).DocId) == map_it->second.end ())
					may = true;
			}
			if (may) {
				Ref atP = corrs.contents (p);
				modcorrs.add (atP);
			}
		}

		if (modcorrs.length ()) {
			if (modcorrs != corrs) {
				str = index->OpenN (pdocIdT, 0);
				modcorrs.Put (str);
				str->Trunc ();
				index->Close (str);
			}
		} else {
			to_delete.insert (*pdocIdT);
		}
	}
	delete it;
	{
	for (std::set<long>::const_iterator it = to_delete.begin (); it != to_delete.end (); it++) {
		long docId = *it;
		index->Delete (&docId);
	}
	to_delete.clear ();
	}
	printf ("\n"); fflush(stdout);

	printf( "Tune index Respondent\n" ); fflush( stdout );
	aPerc = indexr->KeyCount / 100L, aCurrPerc = aaPerc = 0;
	for (it = new BTIterator( indexr ); !it->End(); ++*it ) {
		pdocIdT = (long*)it->Key();

		aCurrPerc++;
		if ( aCurrPerc > aPerc ) {
			aCurrPerc = 0;
			printf( "%ld%%\r", ++aaPerc ); fflush(stdout);
		}

		StorableSplaySet<Ref> refs;
		Stream *str = indexr->keyOpen( pdocIdT, 0 );
		refs.Get(str);
		
		StorableSplaySet<Ref> modrefs;
		for ( Point p = refs.first(); p; refs.next(p) ) {
			Ref atP = refs.contents(p);
			if (!b_daily && !std::binary_search (docs_and_editions.begin (), docs_and_editions.end (), atP.DocId))
				continue;

			bool may = false;
			std::map<long, std::set<long> >::const_iterator map_it = map_doc_editions->find (*pdocIdT);
			if (map_it == map_doc_editions->end () || map_it->second.find (refs.contents(p).DocId) == map_it->second.end ())
				may = true;

			if (may)
				modrefs.add (atP);
		}

		if (modrefs.first ()) {
			indexr->Close(str);
			str = indexr->OpenN (pdocIdT, 0);
			modrefs.Put (str);
			str->Trunc ();
		} else {
			to_delete.insert (*pdocIdT);
		}
		indexr->Close (str);
	}
	delete it;
	docs_and_editions.swap (std::vector<long> ());

	{
	for (std::set<long>::const_iterator it = to_delete.begin (); it != to_delete.end (); it++) {
		long docId = *it;
		indexr->Delete (&docId);
	}
	to_delete.clear ();
	}
	printf( "\n" ); fflush(stdout);

	{
	printf ("Tune IDD_BLOBS\n"); fflush (stdout);
	DocCollection checkids;
	for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
		AttrKey key = {ID_BORDER, IDD_BLOBS};
		BTIterator it ((*base_it)->FindIndex ("Attrs")); it.Set (&key);
		for (;;) {
			key = *(AttrKey*) it.Key();
			if (key.AttrTag != IDD_BLOBS)
				break;
			checkids.Add (key.DocId);
			it.next ();
		}
	}

	for (int i = 0; i < checkids.ItemCount; i++) {
		long id = checkids [i], length = 0, blobSize = 0;
		char* buf = (char*) base->LoadAttr (id, IDD_BLOCKS, length), *blobInfos = 0;
		if (length) {
			char* ptr = buf;
			long pos = 0;

			while ( pos < length ) {
				long para = *(long*)ptr;
				pos += sizeof(para);
				ptr += sizeof(para);
				long type = *(long*)ptr;
				pos += sizeof(para);
				ptr += sizeof(para);				
				int len = strlen( ptr ) + 1;
				BlobInfo* info = 0;

				if (strstr (ptr, "Unknown name") && strcmp (ptr, "Unknown name")) {
					long id = atol (ptr + 13);
					Index *blobs = base->base_for_blob (id)->FindIndex ("Blob");
					Stream* blob = blobs->Open (&id);
					if (blob) {
						long aStrLen = 0;

						ObjInfo objInfo;
						blob->Read (&objInfo, sizeof (objInfo));
						blob->Seek (sizeof (objInfo) + objInfo.size);
						blob->Read (&aStrLen, sizeof (aStrLen));
						if (aStrLen > 1) {
							info = (BlobInfo*) malloc (sizeof (BlobInfo) + aStrLen - 1);
							info->Para = para;
							info->type = objInfo.type;
							blob->Read (info->Name, aStrLen);
							info->Name [aStrLen-1] = '\0';
						}
						blobs->Close( blob );
					}					
				} else {
					info = (BlobInfo*) malloc (sizeof (BlobInfo) + len - 1);
					info->Para = para;
					info->type = type;
					strcpy (info->Name, ptr);
				}

				if (info) {
					int newlen = strlen (info->Name) + sizeof (BlobInfo);
					blobInfos = (char*) realloc (blobInfos, blobSize + newlen);
					memcpy (blobInfos + blobSize, info, newlen);
					blobSize += newlen;
					free( info );
				}

				ptr += len;
				pos += len;
			}

			if (blobSize)
				base->ReplaceAttr (key.DocId, IDD_BLOBS, blobInfos, blobSize);
			else
				base->DelAttrKey (key.DocId, IDD_BLOBS);
			free (buf);
		}
	}
	printf( "\n" ); fflush(stdout);
	}

	base->SetReady (TID_NEWCORR);
	printf ("SetReady\n"); fflush(stdout);

	base->close_saw_bases ();
	delete base;
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
