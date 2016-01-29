#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "garutils.h"
#include "stdbase.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

std::map<long,long> map_doc_size_1, map_doc_size_2;
std::set<long> docs1, docs2;
std::map<long,std::set<long> > map_doc1_docs2;

typedef std::deque<u_int64_t> lemmacounts;
std::map<long,lemmacounts> doc_lemmas_counts_1, doc_lemmas_counts_2;

struct thread_data_struct {
	volatile int done;
};

#define	MAX_THREADS	16
thread_data_struct thread_data [MAX_THREADS];

std::set<long> ids;
std::set<long>::const_iterator id_it;
ACE_Recursive_Thread_Mutex id_it_mutex;

long	get_id (bool next)
{
	RWRITE_GUARD (id_it_mutex) {
		if (id_it == ids.end ())
			return 0;
		long result = *id_it;
		if (next)
			id_it++;
		return result;
	}
}

void	calculate_same (int* thread_id)
{
	int this_thread_id = *thread_id;
	printf ("thread %ld started\n", this_thread_id); fflush (stdout);
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	for (;;) {
		long id = get_id (true);
		if (!id) {
			printf ("thread %ld finished\n", this_thread_id); fflush (stdout);
			break;
		}
		long doc1 = id, size1 = map_doc_size_1.find (doc1)->second;

		std::set<long> at_docs2 = map_doc1_docs2.find (doc1)->second;
		for (std::set<long>::const_iterator docs2_it = at_docs2.begin (); docs2_it != at_docs2.end (); docs2_it++) {
			long doc2 = *docs2_it;
			long size2 = map_doc_size_2.find (doc2)->second;

			if ((std::min <long> (size1, size2) * 100) / std::max<long> (size1, size2) > 94) {
				std::map<long,lemmacounts>::const_iterator it1 = doc_lemmas_counts_1.find (doc1);
				std::map<long,lemmacounts>::const_iterator it2 = doc_lemmas_counts_2.find (doc2);
				long common_lemmas = 0, noncommon_lemmas = 0, total_lemmas = 0;
				if (it1 == doc_lemmas_counts_1.end () || it2 == doc_lemmas_counts_2.end ())
					continue;
				lemmacounts::const_iterator in1 = it1->second.begin (), in2 = it2->second.begin ();
				for (; in1 != it1->second.end () && in2 != it2->second.end (); ) {
					u_int64_t at1 = *in1, at2 = *in2;
					if (at1 >> 32 == at2 >> 32) {
						long count1 = (long) (at1 & 0xFFFFFFFF), count2 = (long) (at2 & 0xFFFFFFFF);
						if ((std::min <long> (count1, count2) * 100) / std::max<long> (count1, count2) > 94)
							common_lemmas++;
						else
							noncommon_lemmas++;
						total_lemmas++;
						in1++, in2++;
					} else
					if (at1 >> 32 < at2 >> 32) {
						total_lemmas++;
						noncommon_lemmas++;
						in1++;
					} else {
						total_lemmas++;
						noncommon_lemmas++;
						in2++;
					}
				}
				for (; in1 != it1->second.end (); in1++) noncommon_lemmas++, total_lemmas++;
				for (; in2 != it2->second.end (); in2++) noncommon_lemmas++, total_lemmas++;
				if (((common_lemmas * 100) / total_lemmas > 94) && ((noncommon_lemmas * 100) / total_lemmas < 5))
					printf ("sames %ld and %ld\n", doc1, doc2), fflush (stdout);
			}
		}
	}

	thread_data_ptr->done = 1;
}

int main_logic ( int argc, char *argv[] )
{
	{
	FILE *file = mpcxc_fopen (argv [3], "rt");
	if (file) {
		char str [64];
		while (!feof (file)) {
			if (!fgets (str, sizeof (str), file))
				break;

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			long doc1, doc2;
			sscanf (str, "sames: %ld %ld", &doc1, &doc2);
			docs1.insert (doc1);
			docs2.insert (doc2);
			std::map<long,std::set<long> >::iterator map_it = map_doc1_docs2.find (doc1);
			if (map_it == map_doc1_docs2.end ()) {
				std::set<long> docs;
				docs.insert (doc2);
				map_doc1_docs2.insert (std::map<long,std::set<long> >::value_type (doc1, docs));
			} else {
				map_it->second.insert (doc2);
			}			
		}
		fclose (file);
	}
	}

	Base* base1 = new YBase (argv [1], ACE_OS_O_RDONLY);
	Index* index_1 = base1->FindIndex ("NWCntxt");
	Base* base2 = new YBase (argv [2], ACE_OS_O_RDONLY);
	Index* index_2 = base2->FindIndex ("NWCntxt");

	{
		DocCollection *alldocs = base1->AllDocs ();
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i];
			if (docs1.find (id) == docs1.end ())
				continue;
			ids.insert (id);
			DocInfo docinfo;
			base1->FindDocInfo (id, docinfo);
			map_doc_size_1.insert (std::map<long,long>::value_type (id, docinfo.Size));
		}
		delete alldocs;
	}

	{
		DocCollection *alldocs = base2->AllDocs ();
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i];
			if (docs2.find (id) == docs2.end ())
				continue;			
			DocInfo docinfo;
			base2->FindDocInfo (id, docinfo);
			map_doc_size_2.insert (std::map<long,long>::value_type (id, docinfo.Size));
		}

		delete alldocs;
	}


	std::set<std::string> all_lemmas;
	{
	for (BTIterator btit1 (index_1); !btit1.End (); ++btit1) {
		const char* key = (const char*)btit1.Key ();
		if (key[0] & 0x80)
			break;
		all_lemmas.insert (key+1);
	}
	for (BTIterator btit2 (index_2); !btit2.End (); ++btit2) {
		const char* key = (const char*)btit2.Key ();
		if (key[0] & 0x80)
			break;
		all_lemmas.insert (key+1);
	}
	}

	{
	for (BTIterator btit (index_1); !btit.End (); ++btit) {
		const char* key = (const char*)btit.Key ();
		if (key[0] & 0x80)
			break;
		Stream *str0 = index_1->Open (key), *str1 = index_1->OpenN (key, 1), *str2 = index_1->OpenN (key, 2);
		char *qqq = strdup (key+1);
		Recoding (cd_win, cd_dos, qqq);
		printf ("%s\r", qqq); fflush (stdout);
		free (qqq);
		if (str0) {
			long lemma = std::distance (all_lemmas.begin(), all_lemmas.find (key+1));

			DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, false, 0);

			DBCore::Ref_ ref = {0,0,0};
			DBCore::ExtrPair extr;
			while (str_reader->get_next (ref)) {
				long id = ref.doc_id;

				DBCore::ULongVector positions;
				pos_reader->get (positions, ref, extr);
				long count_in_doc = 0;
				for (DBCore::ULongVector::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
					long pos = *pos_it;
					if ((pos & ContextSearch::POS_INVISIBLE_BLOCK) == ContextSearch::POS_INVISIBLE_BLOCK)
						continue;
					if ((pos & ContextSearch::POS_INVISIBLE) == ContextSearch::POS_INVISIBLE)
						continue;
					pos &= ContextSearch::POS_TEXT;
					count_in_doc++;
				}
				if (count_in_doc && (map_doc_size_1.find (id) != map_doc_size_1.end ())) {
					std::map<long, lemmacounts>::iterator it = doc_lemmas_counts_1.find (id);
					if (it == doc_lemmas_counts_1.end ())
						it = doc_lemmas_counts_1.insert (std::map<long,lemmacounts>::value_type (id, lemmacounts ())).first;
					u_int64_t put = ((u_int64_t)lemma << 32) + count_in_doc;
					it->second.push_back (put);
				}
			}

			index_1->Close (str2);
			index_1->Close (str1);
			index_1->Close (str0);
		}
	}
	printf ("\n");
	}
	//delete base1;

	{
	for (BTIterator btit (index_2); !btit.End (); ++btit) {
		const char* key = (const char*)btit.Key ();
		if (key[0] & 0x80)
			break;
		Stream *str0 = index_2->Open (key), *str1 = index_2->OpenN (key, 1), *str2 = index_2->OpenN (key, 2);
		char *qqq = strdup (key+1);
		Recoding (cd_win, cd_dos, qqq);
		printf ("%s\r", qqq); fflush (stdout);
		free (qqq);
		if (str0) {
			long lemma = std::distance (all_lemmas.begin(), all_lemmas.find (key+1));

			DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, false, 0);

			DBCore::Ref_ ref = {0,0,0};
			DBCore::ExtrPair extr;
			while (str_reader->get_next (ref)) {
				long id = ref.doc_id;

				DBCore::ULongVector positions;
				pos_reader->get (positions, ref, extr);

				long count_in_doc = 0;
				for (DBCore::ULongVector::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
					long pos = *pos_it;
					if ((pos & ContextSearch::POS_INVISIBLE_BLOCK) == ContextSearch::POS_INVISIBLE_BLOCK)
						continue;
					if ((pos & ContextSearch::POS_INVISIBLE) == ContextSearch::POS_INVISIBLE)
						continue;
					pos &= ContextSearch::POS_TEXT;
					count_in_doc++;
				}
				if (count_in_doc && (map_doc_size_2.find (id) != map_doc_size_2.end ())) {
					std::map<long, lemmacounts>::iterator it = doc_lemmas_counts_2.find (id);
					if (it == doc_lemmas_counts_2.end ())
						it = doc_lemmas_counts_2.insert (std::map<long,lemmacounts>::value_type (id, lemmacounts ())).first;
					u_int64_t put = ((u_int64_t)lemma << 32) + count_in_doc;
					it->second.push_back (put);
				}
			}

			index_2->Close (str2);
			index_2->Close (str1);
			index_2->Close (str0);
		}
	}
	printf ("\n");
	}
	//delete base2;

	int threads_count = 1;
	if (argv [4]) {
		threads_count = atol (argv [4]);
		if (threads_count > MAX_THREADS)
			threads_count = MAX_THREADS;
	}

	id_it = ids.begin ();
	long thread_id, ok_threads = 0;
	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		thread_data [thread_id].done = 0;
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		inst->spawn ((ACE_THR_FUNC)calculate_same, &thread_id, THR_DETACHED);
		ok_threads++;
		ACE_OS::sleep (2);
	}

	long last_time;
	bool b_timeout = false;
	for (;;) {
		long id = get_id (false);
		if (id) {
			printf ("\nthreads checked, %ld\n", id);
			last_time = time (0);
			ACE_OS::sleep (10);
		} else {
			int dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else {
				if (time (0) - last_time > 3600) {
					b_timeout = true;
					printf ("\ntimeout"); fflush (stdout);
					break;
				}
				ACE_OS::sleep (10);
			}
		}
	}

	printf ("\ndelete threads"); fflush (stdout);

	return 0;
}
