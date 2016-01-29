
#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"

#include "StorableSplaySet.h"

#include "pack.h"

struct	CorrStruct {
	long	uid;
	u_int64_t	mask;
	RefCollection*	refs;
};

CorrStruct	CorrKinds [64];
long	CorrKinds_size = 0;

Base* base;

StorableSplaySet<CorrRef> corrrefs;
Index* newcorr_index;

std::vector<long> processed_ids;

std::map<long, StorableSplaySet<CorrRef>*> map_doc_corrrefs;
std::map<long, StorableSplaySet<CorrRef>*>::const_iterator refs_it;
volatile bool b_waiting_data = true;
ACE_Recursive_Thread_Mutex refs_mutex;

struct thread_data_struct {
	int done;
	std::map<long,u_int64_t> masks;
};
#define MAX_THREADS 16
thread_data_struct thread_data [MAX_THREADS];
#ifdef	__FreeBSD__
pthread_t threads [MAX_THREADS];
int thread_ids [MAX_THREADS];
#endif

StorableSplaySet<CorrRef>*	get_refs (long& doc_id)
{
	RWRITE_GUARD (refs_mutex) {
		StorableSplaySet<CorrRef>* result = 0;
		if (b_waiting_data)
			doc_id = -1;
		else
		if (refs_it == map_doc_corrrefs.end ()) {
			doc_id = 0;
		} else {
			doc_id = refs_it->first;
			result = refs_it->second;
			refs_it++;
		}
		return result;
	}
}

#ifdef	__FreeBSD__
void*	calculate_mask (void *thread_id)
{
	int this_thread_id = *(int*)thread_id;
#else
void	calculate_mask (int* thread_id)
{
	int this_thread_id = *thread_id;
#endif
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	for (;;) {
		long doc_id;
		StorableSplaySet<CorrRef> *refs = get_refs (doc_id);
		if (doc_id == -1) {
			//данные готовятся, ничего не делаем
		} else if (doc_id == 0) {
			//данные кончились, надо будет прочитать следующую порцию
			thread_data_ptr->done = 1;
		} else 	{
			RefCollection resp_refs;
			for (Point p = refs->first(); p; refs->next(p)) {
				const CorrRef *atP = (*refs) [p];
				Ref ref = {atP->DocId, atP->Block};
				resp_refs.Add (ref);
			}
			u_int64_t corrs_mask = 0;
			for (int i = 0; i < CorrKinds_size; i++) {
				if (CorrKinds [i].refs && resp_refs.IsSect2 (CorrKinds [i].refs))
					corrs_mask |= CorrKinds [i].mask;
			}
			thread_data_ptr->masks.insert (std::map<long,u_int64_t>::value_type (doc_id, corrs_mask));
		}
	}
}

void	do_write (long id)
{
	Stream *str = newcorr_index->Open (&id, 1);
	corrrefs.Put (str);
	str->Trunc ();
	newcorr_index->Close (str);
	processed_ids.push_back (id);

	corrrefs.clear ();
}

void	do_write_info (long id)
{
	processed_ids.push_back (id);
	corrrefs.clear ();
}

void	do_write_newcorr (long id)
{
	Stream *str = newcorr_index->Open (&id, 1);
	corrrefs.Put (str);
	str->Trunc ();
	newcorr_index->Close (str);
	corrrefs.clear ();
}

void	do_write_newcorr (Stream *str, bool b_close) {
	long size = corrrefs.length () * sizeof (CorrRef);
	char *unpacked = new char [size];
	CorrRef *ptr = (CorrRef*) unpacked;
	for (Point p = corrrefs.first (); p; corrrefs.next (p), ptr++) {
		CorrRef atp = corrrefs.contents (p);
		memcpy (ptr, &atp, sizeof (atp));
	}
	char *packed = new char [size * 2];
	long packed_size = G_ZIP (unpacked, size, packed, size * 2);
	str->Write (&packed_size, sizeof (long));
	str->Write (&size, sizeof (long));
	str->Write (packed, packed_size);
	if (b_close) {
		str->Trunc ();
		newcorr_index->Close (str);
	}
	delete [] packed;
	delete [] unpacked;
	corrrefs.clear ();
}

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;

	if (!strcmp (argv [1], "-newcorronly")) {
		base = new StdBigBase (argv [2], ACE_OS_O_RDWR);

		long b_pack_newcorr = false;
		{
			Stream *str = base->FindIndex ("Aux")->Open (AUX_PACKED_NEWCORR);
			if (str) {
				str->Read (&b_pack_newcorr, sizeof (long));
				base->FindIndex ("Aux")->Close (str);
			}
		}

		newcorr_index = base->FindIndex ("NewCorr");

		FILE *in_file = fopen (argv [3], "rt");
		long prev_id = 0;
		Stream *newcorr_str;
		while (!feof (in_file)) {
			char str [1024]; str [0] = '\0';

			if (!fgets (str, sizeof (str), in_file))
				break;

			CorrRef corr_ref;
			long id = atol (str);
			char *ptr = strchr (str, ':');
			corr_ref.Block = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.DocId = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.Para = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.RealPara = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.Sub = atol (++ptr);

			if (id != prev_id) {
				if (prev_id) {
					if (prev_id % 100 == 0) printf ("%ld\r", prev_id);
					if (b_pack_newcorr)
						do_write_newcorr (newcorr_str, true);
					else
						do_write_newcorr (prev_id);
				}
				prev_id = id;
				if (b_pack_newcorr) newcorr_str = newcorr_index->Open (&id, 1);
				corrrefs.add (corr_ref);
			} else {
				corrrefs.add (corr_ref);
				if (b_pack_newcorr && corrrefs.length () == 10000)
					do_write_newcorr (newcorr_str, false);
			}
		}
		if (prev_id)
			if (b_pack_newcorr)
				do_write_newcorr (newcorr_str, true);
			else
				do_write_newcorr (prev_id);

		printf ("\n");
		fclose (in_file);
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [1], "-infoonly")) {
		return 0;
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
			CorrKinds [CorrKinds_size].refs = new RefCollection ();
			CorrKinds [CorrKinds_size].refs->Get (str);
			CorrKinds [CorrKinds_size].uid = uid;
			CorrKinds [CorrKinds_size].mask = mask;
			index_kind->Close (str);
			CorrKinds_size++;
		}
	}
	delete base;
	}

	base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	newcorr_index = base->FindIndex ("NewCorr");

	if (argv [3]) {
		long threads_count = atol (argv [3]), thread_id;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].done = 1;
	#ifdef	__FreeBSD__
			thread_ids [thread_id] = thread_id;
			int res = pthread_create (&threads [thread_id], 0, calculate_mask, &thread_ids [thread_id]);
			if (res != 0) {
				printf ("error running thread %ld\n", thread_id);
			} else {
				printf ("thread %ld from %ld created\n", thread_id, threads_count);
			}
	#else
			ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
			inst->spawn ((ACE_THR_FUNC)calculate_mask, &thread_id, THR_DETACHED);
	#endif
			ACE_OS::sleep (1);
		}

		bool b_file_finished = false;
		FILE *in_file = fopen (argv [2], "rt");
		long prev_id = 0;
		StorableSplaySet<CorrRef>* portion = 0;
		for (;;) {
			int dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].done)
					dones++;

			if (dones == threads_count) {
				{
					RWRITE_GUARD (refs_mutex) {
						b_waiting_data = true;
						for (thread_id = 0; thread_id < threads_count; thread_id++) {
							thread_data [thread_id].masks.clear ();
							thread_data [thread_id].done = 0;
						}
						
						for (std::map<long, StorableSplaySet<CorrRef>*>::iterator map_it = map_doc_corrrefs.begin (); map_it != map_doc_corrrefs.end (); map_it++) {
							long doc_id = map_it->first;
							processed_ids.push_back (doc_id);
							Stream *str = newcorr_index->Open (&doc_id, 1);
							if (str) {
								map_it->second->Put (str);
								str->Trunc ();
								newcorr_index->Close (str);
							}
							delete map_it->second;
						}
						map_doc_corrrefs.clear ();
					}
				}

				if (b_file_finished)
					break;

				//прочитать следующую порцию
				bool portion_finished = false;
				while (!feof (in_file)) {
					char str [1024]; str [0] = '\0';

					if (!fgets (str, sizeof (str), in_file))
						break;

					CorrRef corr_ref;
					long id = atol (str);
					char *ptr = strchr (str, ':');
					corr_ref.Block = atol (++ptr);
					ptr = strchr (ptr, '.');
					corr_ref.DocId = atol (++ptr);
					ptr = strchr (ptr, '.');
					corr_ref.Para = atol (++ptr);
					ptr = strchr (ptr, '.');
					corr_ref.RealPara = atol (++ptr);
					ptr = strchr (ptr, '.');
					corr_ref.Sub = atol (++ptr);

					if (id != prev_id) {
						if (prev_id)
							map_doc_corrrefs.insert (std::map<long, StorableSplaySet<CorrRef>*>::value_type (prev_id, portion));
						prev_id = id;
						portion = new StorableSplaySet<CorrRef>;
						portion->add (corr_ref);
						if (map_doc_corrrefs.size () == 5000) {
							portion_finished = true;
							break;
						}
					} else {
						portion->add (corr_ref);
					}
				}

				if (!portion_finished) {
					//если файл кончился
					map_doc_corrrefs.insert (std::map<long, StorableSplaySet<CorrRef>*>::value_type (prev_id, portion));
					fclose (in_file);
					b_file_finished = true;
				}

				printf ("portion from %ld to %ld\n", map_doc_corrrefs.begin ()->first, map_doc_corrrefs.rbegin ()->first);
				{
					RWRITE_GUARD (refs_mutex) {
						refs_it = map_doc_corrrefs.begin ();
						b_waiting_data = false;
					}
				}
			}
		}
	} else {
		FILE *in_file = fopen (argv [2], "rt");
		long prev_id = 0;
		while (!feof (in_file)) {
			char str [1024]; str [0] = '\0';

			if (!fgets (str, sizeof (str), in_file))
				break;

			CorrRef corr_ref;
			long id = atol (str);
			char *ptr = strchr (str, ':');
			corr_ref.Block = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.DocId = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.Para = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.RealPara = atol (++ptr);
			ptr = strchr (ptr, '.');
			corr_ref.Sub = atol (++ptr);

			if (id != prev_id) {
				if (prev_id) {
					if (prev_id % 10 == 0) printf ("%ld\r", prev_id);
					do_write (prev_id);
				}
				corrrefs.add (corr_ref);
				prev_id = id;
			} else {
				corrrefs.add (corr_ref);
			}
		}
		if (prev_id)
			do_write (prev_id);
		printf ("\n");
		fclose (in_file);
	}

	{
	std::vector<long> to_delete;
	for (BTIterator btit (newcorr_index); !btit.End (); ++btit) {
		long id = *(long*) btit.Key ();
		if (!std::binary_search (processed_ids.begin (), processed_ids.end (), id))
			to_delete.push_back (id);
	}
	for (std::vector<long>::const_iterator it = to_delete.begin (); it != to_delete.end (); it++) {
		long id = *it;
		newcorr_index->Delete (&id);
	}
	}

	printf ("\n");

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
