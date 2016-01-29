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

std::map<std::string,std::vector<long> >::const_iterator id_it;
ACE_Recursive_Thread_Mutex id_it_mutex;

std::map<std::string, std::vector<long> > map_type_docs, map_adopted_docs, map_date_docs, map_code_docs;
std::map<std::string, std::vector<long> > map2_type_docs, map2_adopted_docs, map2_date_docs, map2_code_docs;

long	get_id (bool next, std::string &key)
{
	RWRITE_GUARD (id_it_mutex) {
		if (id_it == map_adopted_docs.end ())
			return 0;
		if (next)
			id_it++;
		if (id_it == map_adopted_docs.end ())
			return 0;
		key = id_it->first;
		return 1;
	}
}

void	calculate_same (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	for (long count = 0;;count++) {
		std::string index_key;
		long id = get_id (true, index_key);
		if (!id)
			break;

		printf ("thread %ld, count: %ld, found dups: %ld\n", this_thread_id, count, thread_data_ptr->results.size ()); fflush (stdout);

		std::map<std::string,std::vector<long> >::const_iterator ado_it = map_adopted_docs.find (index_key);
		std::map<std::string,std::vector<long> >::const_iterator ado2_it = map2_adopted_docs.find (index_key);
		if (ado2_it == map2_adopted_docs.end ())
			continue;

		//printf ("adopted: %s\n", index_key.c_str ());

		for (std::map<std::string,std::vector<long> >::const_iterator type_it = map_type_docs.begin (); type_it != map_type_docs.end (); type_it++) {
			std::map<std::string,std::vector<long> >::const_iterator type2_it = map2_type_docs.find (type_it->first);
			if (type2_it == map2_type_docs.end ())
				continue;

			std::vector<long> inter1;
			std::set_intersection (type_it->second.begin (), type_it->second.end (), ado_it->second.begin (), ado_it->second.end (), std::back_inserter (inter1));
			if (!inter1.size ())
				continue;

			std::vector<long> inter2_1;
			std::set_intersection (type2_it->second.begin (), type2_it->second.end (), ado2_it->second.begin (), ado2_it->second.end (), std::back_inserter (inter2_1));
			if (!inter2_1.size ())
				continue;

			//printf ("type: %s\n", type2_it->first.c_str ());

			for (std::map<std::string,std::vector<long> >::const_iterator date_it = map_date_docs.begin (); date_it != map_date_docs.end (); date_it++) {
				std::map<std::string,std::vector<long> >::const_iterator date2_it = map2_date_docs.find (date_it->first);
				if (date2_it == map2_date_docs.end ())
					continue;

				std::vector<long> inter2;
				std::set_intersection (inter1.begin (), inter1.end (), date_it->second.begin (), date_it->second.end (), std::back_inserter (inter2));
				if (!inter2.size ())
					continue;

				std::vector<long> inter2_2;
				std::set_intersection (inter2_1.begin (), inter2_1.end (), date2_it->second.begin (), date2_it->second.end (), std::back_inserter (inter2_2));
				if (!inter2_2.size ())
					continue;

				//printf ("date: %s\n", date2_it->first.c_str ());

				for (std::map<std::string,std::vector<long> >::const_iterator code_it = map_code_docs.begin (); code_it != map_code_docs.end (); code_it++) {
					std::map<std::string,std::vector<long> >::const_iterator code2_it = map2_code_docs.find (code_it->first);
					if (code2_it == map2_code_docs.end ())
						continue;

					//printf ("code: %s\n", code2_it->first.c_str ());

					std::vector<long> inter3;
					std::set_intersection (inter2.begin (), inter2.end (), code_it->second.begin (), code_it->second.end (), std::back_inserter (inter3));

					std::vector<long> inter2_3;
					std::set_intersection (inter2_2.begin (), inter2_2.end (), code2_it->second.begin (), code2_it->second.end (), std::back_inserter (inter2_3));

					if (inter3.size () > 0 && inter2_3.size () > 0) {
						for (std::vector<long>::const_iterator it1 = inter3.begin (); it1 != inter3.end (); it1++) {
							for (std::vector<long>::const_iterator it2 = inter2_3.begin (); it2 != inter2_3.end (); it2++) {
								char str [64];
								sprintf (str, "sames: %ld %ld", *it1, *it2);
								printf ("%s\n", str);
								thread_data_ptr->results.insert (str);
							}
						}
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

	HIndex *types = (HIndex*) base->FindIndex ("Type"), *adopted = (HIndex*) base->FindIndex ("Adopted");
	Index *dates = base->FindIndex ("Date"), *codes = base->FindIndex ("Number");

	printf ("read Type\n");
	for (BTIterator typeit (types); !typeit.End (); ++typeit) {
		HIndex::HIndexKey* typekey = (HIndex::HIndexKey*) typeit.Key ();
		if (typekey->chCount)
			continue;

		char fullname [2048];
		types->FullName (typekey, fullname);

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
			map_type_docs.insert (std::map<std::string,std::vector<long> >::value_type (fullname, typedocs));
		}
	}

	printf ("read Adopted\n");
	for (BTIterator adoit (adopted); !adoit.End (); ++adoit) {
		HIndex::HIndexKey* adokey = (HIndex::HIndexKey*) adoit.Key ();
		if (adokey->chCount)
			continue;

		char fullname [2048];
		adopted->FullName (adokey, fullname);

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
			map_adopted_docs.insert (std::map<std::string,std::vector<long> >::value_type (fullname, second));
		}
	}

	printf ("read Date\n");
	for (BTIterator dateit (dates); !dateit.End (); ++dateit) {
		date* datekey = (date*) dateit.Key ();
		Stream* str = dates->Open (datekey);
	
		if (str) {
			char strdate [32];
			sprintf (strdate, "%ld/%ld/%ld", datekey->da_day, datekey->da_mon, datekey->da_year);
			long length = str->Length ();
			str->Read (docs, length);
			length /= sizeof (long);
			dates->Close (str);

			std::vector<long> second;			
			long* ptr = docs;
			for (int i = 0; i < length; i++, ptr++)
				second.push_back (*ptr);
			map_date_docs.insert (std::map<std::string,std::vector<long> >::value_type (strdate, second));
		}
	}

	printf ("read Number\n");
	for (BTIterator codeit (codes); !codeit.End (); ++codeit) {
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
			map_code_docs.insert (std::map<std::string,std::vector<long> >::value_type ((char*)codeit.Key (), second));
		}
	}

	{
	ToolsBase *base2 = new ToolsBase (argv [2]);

	DocCollection* all_docs = base2->AllDocs ();
	std::set<long> alldocs2;
	for (int i = 0; i < all_docs->ItemCount; i++)
		alldocs2.insert ((*all_docs) [i]);
	delete all_docs;

	HIndex *types = (HIndex*) base2->FindIndex ("Type"), *adopted = (HIndex*) base2->FindIndex ("Adopted");
	Index *dates = base2->FindIndex ("Date"), *codes = base2->FindIndex ("Number");

	printf ("read Type\n");
	for (BTIterator typeit (types); !typeit.End (); ++typeit) {
		HIndex::HIndexKey* typekey = (HIndex::HIndexKey*) typeit.Key ();
		if (typekey->chCount)
			continue;

		char fullname [2048];
		types->FullName (typekey, fullname);

		Stream* str = types->Index::OpenN (typekey, 0);
		if (str) {
			long length = str->Length ();
			str->Read (refs, length);
			types->Close (str);
			length /= sizeof (Ref);

			Ref* ptr = refs;
			std::vector<long> typedocs;
			for (int i = 0; i < length; i++, ptr++)
				if (ptr->Sub == 0 && alldocs2.find (ptr->DocId) != alldocs2.end ())
					typedocs.push_back (ptr->DocId);
			map2_type_docs.insert (std::map<std::string,std::vector<long> >::value_type (fullname, typedocs));
		}
	}

	printf ("read Adopted\n");
	for (BTIterator adoit (adopted); !adoit.End (); ++adoit) {
		HIndex::HIndexKey* adokey = (HIndex::HIndexKey*) adoit.Key ();
		if (adokey->chCount)
			continue;

		char fullname [2048];
		adopted->FullName (adokey, fullname);

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
			map2_adopted_docs.insert (std::map<std::string,std::vector<long> >::value_type (fullname, second));
		}
	}

	printf ("read Date\n");
	for (BTIterator dateit (dates); !dateit.End (); ++dateit) {
		date* datekey = (date*) dateit.Key ();
		Stream* str = dates->Open (datekey);
	
		if (str) {
			char strdate [32];
			sprintf (strdate, "%ld/%ld/%ld", datekey->da_day, datekey->da_mon, datekey->da_year);
			long length = str->Length ();
			str->Read (docs, length);
			length /= sizeof (long);
			dates->Close (str);

			std::vector<long> second;			
			long* ptr = docs;
			for (int i = 0; i < length; i++, ptr++)
				second.push_back (*ptr);
			map2_date_docs.insert (std::map<std::string,std::vector<long> >::value_type (strdate, second));
		}
	}

	printf ("read Number\n");
	for (BTIterator codeit (codes); !codeit.End (); ++codeit) {
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
			map2_code_docs.insert (std::map<std::string,std::vector<long> >::value_type ((char*)codeit.Key (), second));
		}
	}
	}

	int threads_count = 1;
	if (argv [3]) {
		threads_count = atol (argv [3]);
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
		std::string index_key;
		long id = get_id (false, index_key);
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
