#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "SearchB.h"

#include <algorithm>

struct thread_data_struct {
	volatile int done;
	std::set<std::string> results;
};

#define	MAX_THREADS	16
thread_data_struct thread_data [MAX_THREADS];

std::map<long,std::vector<long> >::const_iterator id_it;
ACE_Recursive_Thread_Mutex id_it_mutex;

std::map<long, std::vector<long> > map_type_docs, map_adopted_docs;
std::map<long, std::vector<long> > map_date_docs;
std::map<long, std::vector<long> > map_code_docs;

long	get_id (bool next)
{
	RWRITE_GUARD (id_it_mutex) {
		if (id_it == map_adopted_docs.end ())
			return 0;
		if (next)
			id_it++;
		return id_it->first;
	}
}

void	calculate_same (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	for (long count = 0;;count++) {
		long id = get_id (true);
		if (!id)
			break;
		printf ("thread %ld, count: %ld, found dups: %ld\n", this_thread_id, count, thread_data_ptr->results.size ()); fflush (stdout);
		std::map<long, std::vector<long> >::const_iterator ado_it = map_adopted_docs.find (id);

		for (std::map<long, std::vector<long> >::const_iterator type_it = map_type_docs.begin (); type_it != map_type_docs.end (); type_it++) {
			std::vector<long> inter1;
			std::set_intersection (type_it->second.begin (), type_it->second.end (), ado_it->second.begin (), ado_it->second.end (), std::back_inserter (inter1));
			if (!inter1.size ())
				continue;

			for (std::map<long, std::vector<long> >::const_iterator date_it = map_date_docs.begin (); date_it != map_date_docs.end (); date_it++) {
				std::vector<long> inter2;
				std::set_intersection (inter1.begin (), inter1.end (), date_it->second.begin (), date_it->second.end (), std::back_inserter (inter2));
				if (!inter2.size ())
					continue;

				for (std::map<long, std::vector<long> >::const_iterator code_it = map_code_docs.begin (); code_it != map_code_docs.end (); code_it++) {
					std::vector<long> inter3;
					std::set_intersection (inter2.begin (), inter2.end (), code_it->second.begin (), code_it->second.end (), std::back_inserter (inter3));
					if (inter3.size () > 1) {
						std::string result ("sames:");
						for (std::vector<long>::const_iterator it = inter3.begin (); it != inter3.end (); it++) {
							char plus [32];
							sprintf (plus, " %ld", *it);
							result += plus;
						}
						thread_data_ptr->results.insert (result);
					}
				}
			}
		}
	}

	thread_data_ptr->done = 1;
}

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	ToolsBase *base = new ToolsBase (argv [1]);

	DocCollection* all_docs = base->AllDocs ();
	std::set<long> alldocs;
	for (int i = 0; i < all_docs->ItemCount; i++)
		alldocs.insert ((*all_docs) [i]);
	delete all_docs;

	Ref* refs = new Ref [10000000];
	long* docs = new long [10000000];

	Index *types = base->FindIndex ("Type"), *adopted = base->FindIndex ("Adopted"), *dates = base->FindIndex ("Date"), *codes = base->FindIndex ("Number");

	printf ("read Type\n");
	for (BTIterator typeit (types); !typeit.End (); ++typeit) {
		HIndex::HIndexKey* typekey = (HIndex::HIndexKey*) typeit.Key ();
		if (typekey->chCount)
			continue;

		Stream* str = types->Index::OpenN (typekey, 0);
		if (str) {
			long length = str->Length ();
			str->Read (refs, length);
			types->Close (str);
			length /= sizeof (Ref);

			Ref* ptr = refs;
			std::vector<long> typedocs;
			for (int i = 0; i < length; i++, ptr++)
				if (ptr->Sub == 0 && alldocs.find (ptr->DocId) != alldocs.end ())
					typedocs.push_back (ptr->DocId);
			map_type_docs.insert (std::map<long,std::vector<long> >::value_type (typekey->id, typedocs));
		}
	}

	printf ("read Adopted\n");
	for (BTIterator adoit (adopted); !adoit.End (); ++adoit) {
		HIndex::HIndexKey* adokey = (HIndex::HIndexKey*) adoit.Key ();
		if (adokey->chCount)
			continue;

		Stream* str = adopted->Index::OpenN (adokey, 0);
		if (str) {
			long length = str->Length ();
			str->Read (docs, length);
			adopted->Close (str);
			length /= sizeof (long);

			std::vector<long> second;
			long* ptr = docs;
			for (int i = 0; i < length; i++, ptr++)
				second.push_back (*ptr);
			map_adopted_docs.insert (std::map<long,std::vector<long> >::value_type (adokey->id, second));
		}
	}

	printf ("read Date\n");
	long dummy_id = 0;
	for (BTIterator dateit (dates); !dateit.End (); ++dateit, dummy_id++) {
		date* datekey = (date*) dateit.Key ();
		Stream* str = dates->Open (datekey);
	
		if (str) {
			long length = str->Length ();
			str->Read (docs, length);
			length /= sizeof (long);
			dates->Close (str);

			std::vector<long> second;			
			long* ptr = docs;
			for (int i = 0; i < length; i++, ptr++)
				second.push_back (*ptr);
			map_date_docs.insert (std::map<long,std::vector<long> >::value_type (dummy_id, second));
		}
	}

	printf ("read Number\n");
	for (BTIterator codeit (codes); !codeit.End (); ++codeit, dummy_id++) {
		Stream* str = codes->Open (codeit.Key ());
		if (str) {
			long length = str->Length ();
			str->Read (docs, length);
			length /= sizeof (long);
			codes->Close (str);

			std::vector<long> second;
			long* ptr = docs;
			for (int i = 0; i < length; i++, ptr++)
				second.push_back (*ptr);
			map_code_docs.insert (std::map<long,std::vector<long> >::value_type (dummy_id, second));
		}
	}

	int threads_count = 1;
	if (argv [2]) {
		threads_count = atol (argv [2]);
		if (threads_count > MAX_THREADS)
			threads_count = MAX_THREADS;
	}

	id_it = map_adopted_docs.begin ();
	printf ("total adopteds: %ld\n", map_adopted_docs.size ());
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
				if (time (0) - last_time > 180) {
					b_timeout = true;
					printf ("\ntimeout"); fflush (stdout);
					break;
				}
				ACE_OS::sleep (10);
			}
		}
	}
	fflush (stdout);
	std::set<std::string> result;
	for (thread_id = 0; thread_id < threads_count; thread_id++)
		result.insert (thread_data [thread_id].results.begin (), thread_data [thread_id].results.end ());
	for (std::set<std::string>::const_iterator str_it = result.begin (); str_it != result.end (); str_it++)
		printf ("%s\n", str_it->c_str ());
	
	return 0;
}
