#include "shared/Core/fix/mpcxc.h"

#include <locale.h>

#include "shared/Core/sys/AutoInit.h"

#include "garutils.h"
#include "ROCBase.h"
#include "recode.h"

#include "garantCore/Search/Facade/Factory.h"
#include "garantCore/Search/impl/Filters_i/Filters.h"
#include <boost/thread.hpp>

int compare_using_sort_cache (const void* arg1, const void* arg2) {
	const RefwRele* at1 = reinterpret_cast<const RefwRele*> (arg1);
	const RefwRele* at2 = reinterpret_cast<const RefwRele*> (arg2);
	int res = at2->Rele - at1->Rele;
	return (res == 0)? SortAttrCache::instance ()->compare (at1->DocId, at2->DocId) : res;
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
	return main_logic (argc, argv);
}

#define	MAX_SEGS	600
#define	MAX_THREADS	16

std::map<std::string, void*> map_request_data [MAX_SEGS];
std::map<std::string, long> map_request_size  [MAX_SEGS];

struct thread_data_struct {
	SearchBase *base;
	volatile int done;
};

thread_data_struct thread_data [MAX_THREADS];
std::set<short> _here_segs;
std::vector<std::string> requests;
std::vector<std::string>::const_iterator request_it;
ACE_Recursive_Thread_Mutex request_it_mutex;

char*	get_request (bool next)
{
	RWRITE_GUARD (request_it_mutex) {
		if (request_it == requests.end ())
			return 0;
		char *result = strdup (request_it->c_str ());
		if (next)
			request_it++;
		return result;
	}
}

std::map<long, long> map_doc_segscount;
std::map<long, short*> map_doc_segs;

void	calculate_search (long& thread_id)
{
	printf ("thread %ld started\n", thread_id); fflush (stdout);
	thread_data_struct* thread_data_ptr = & (thread_data [thread_id]);

	IndexReq* req = (IndexReq*) malloc (sizeof (IndexReq) + 1024);
	req->ItemCount = 1;
	req->ItemSize  = 0;
	req->SearchOp = SO_AND | SO_KEYS_AND | SV_MBODIES;
	strcpy (req->Name, "Morpho");
	IndexReq *reqs [1];
	reqs [0] = req;

	SearchBase* base = thread_data_ptr->base;
	Search::ISearcher_var m_searcher = Search::Factory::make_searcher (base);
	Search::SearchProp search_prop;

	SortAttrCache::instance ()->load (base);

	Search::BooleanFilter filter;

	const DocCollection& data = AllDocsCache::instance ()->get_med_docs (base);
	filter << Search::Filter (const_cast <DocCollection*> (&data), Search::so_NOT);

	const DocCollection& edis = AllDocsCache::instance ()->get_editions (base);
	filter << Search::Filter (const_cast <DocCollection*> (&edis), Search::so_NOT);

	search_prop.filter = filter.in ();

	for (long count = 0; ; count++) {
		char* request_str = get_request (true);
		if (!request_str) {
			printf ("thread %ld finished\n", thread_id); fflush (stdout);
			break;
		}
		char* ptr = (char gk_huge*)(req+1);
		strcpy (ptr, request_str);

		printf ("%ld.%ld.%s ", thread_id, count, ptr); fflush (stdout);

		//SearchResult * result = base->Search (1, reqs, 0, SO_AND, 0, 1, 0, false, true);
		Search::IQuery_var query = Search::Factory::make_query (Search::BODY_TYPE, request_str);
		Search::SearchResult* res = m_searcher->execute (query.in (), search_prop);

		if (res->list.in () && res->list.in ()->ItemCount) {
			//перекинуть в массив, и отсортировать
			RefwReleCollection* list = (RefwReleCollection*) res->list.in ();
			long items = list->ItemCount, i;
			RefwRele* data = new RefwRele [items], *ptr = data;
			for (i = 0; i < items; i++, ptr++) {
				RefwRele *ati = (RefwRele*) list->GetItem (i);
				memcpy (ptr, ati, sizeof (RefwRele));
			}
			//delete list;
			qsort (data, items, sizeof (RefwRele), compare_using_sort_cache);

			std::map<long, std::deque<RefwRele> > map_seg_docs;
			for (i = 1; i < MAX_SEGS; i++) {
				std::deque<RefwRele> empty;
				map_seg_docs.insert (std::map<short, std::deque<RefwRele> >::value_type ((short) i, empty));
			}
			for (i = 0, ptr = data; i < items; i++, ptr++) {
				long doc_id = ptr->DocId;
				RefwRele at_ptr = *ptr;
				long segs_count = map_doc_segscount.find (doc_id)->second;
				short* segs = map_doc_segs.find (doc_id)->second;
				for (long seg = 0; seg < segs_count; segs++, seg++) {
					if (_here_segs.find (*segs) == _here_segs.end ())
						continue;
					std::deque<RefwRele> *docs = &map_seg_docs.find (*segs)->second;
					if (docs->size () < 60)
						docs->push_back (at_ptr);
				}
			}
			delete data;

			std::map<long, std::deque<RefwRele> >::const_iterator it;
			for (it = map_seg_docs.begin (); it != map_seg_docs.end (); it++) {
				if (it->second.size ()) {
					long seg = it->first, size = sizeof (long) + it->second.size () * sizeof (RefwRele), *data = (long*) malloc (size), *long_ptr = data;
					*long_ptr++ = it->second.size ();
					RefwRele *ptr = (RefwRele*) long_ptr;
					for (std::deque<RefwRele>::const_iterator v_it = it->second.begin (); v_it != it->second.end (); v_it++, ptr++) {
						RefwRele at_v_it = *v_it;
						memcpy (ptr, &at_v_it, sizeof (RefwRele));
					}
					{
						RWRITE_GUARD (request_it_mutex) {
							map_request_size [seg].insert (std::map<std::string, long>::value_type (request_str, size));
							map_request_data [seg].insert (std::map<std::string, void*>::value_type (request_str, data));
						}
					}
				}
			}
		}
		free (request_str);
		delete res;
	}
	thread_data_ptr->done = 1;
}

void	correct_str (char *in)
{
	char* out = in;
	while (*in) {
		if (IS_CTX_CHAR_WIN (*in) || *in == '-' || *in == '*' || *in == '.' || *in == ' ' || *in == '№')
			*out++ = *in++;
		else
			in++;
	}
	*out = '\0';
}
	
int main_logic ( int argc, char *argv[] )
{
	{
		FILE *request_file = fopen (argv [2], "rt");
		while (!feof (request_file) && requests.size () < 2500) {
			char request_str [1024]; request_str [0] = '\0';
			fgets (request_str, sizeof (request_str), request_file);

			int length = strlen (request_str);
			while (length && (request_str [length-1] == 10 || request_str [length-1] == 13 || request_str [length-1] == 32))
				request_str [--length] = 0;
			if (!length)
				continue;

			Recoding (cd_dos, cd_win, request_str);
			bool b_valid, b_was;
			strcpy (request_str, convert_quotes (request_str, b_valid, b_was));
			correct_str (request_str);
			requests.push_back (request_str);
		}
		fclose (request_file);

		request_file = fopen (argv [3], "rt");
		while (!feof (request_file) && requests.size () < 2500) {
			char request_str [1024]; request_str [0] = '\0';
			fgets (request_str, sizeof (request_str), request_file);

			int length = strlen (request_str);
			while (length && (request_str [length-1] == 10 || request_str [length-1] == 13))
				request_str [--length] = 0;
			if (!length)
				continue;

			Recoding (cd_dos, cd_win, request_str);
			if (strstr (request_str, ": 0") || strstr (request_str, ":0"))
				*strchr (request_str, ':') = 0;
			else
				continue;

			if (strchr (request_str, '['))
				continue;

			bool b_valid, b_was;
			strcpy (request_str, convert_quotes (request_str, b_valid, b_was));
			correct_str (request_str);
			requests.push_back (request_str);
		}
		fclose (request_file);

		request_it = requests.begin ();

		{
		YBase* base = new YBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		printf ("read IDD_BASES for all docs..."); fflush (stdout);
		DocCollection *all_docs = base->AllDocs ();
		for (long i = 0; i < all_docs->ItemCount; i++) {
			long doc_id = (*all_docs) [i], segs_count;
			map_doc_segs.insert (std::map<long, short*>::value_type (doc_id, (short*) base->LoadAttr (doc_id, IDD_BASES, segs_count)));
			map_doc_segscount.insert (std::map<long, long>::value_type (doc_id, segs_count >> 1));
		}
		printf (" done\n"); fflush (stdout);
		delete all_docs;

		Stream* str = base->FindIndex ("Aux")->Open ("Here");
		if (str) {
			while (str->Tell () < str->Length ()) {
				short seg;
				str->Read (&seg, sizeof (short));
				if (seg < MAX_SEGS)
					_here_segs.insert (seg);
			}
			base->FindIndex ("Aux")->Close (str);
		}

		//delete base;
		printf ("\n");
		}

		int threads_count = 1;
		if (argv [4]) {
			threads_count = atol (argv [4]);
			if (threads_count > MAX_THREADS)
				threads_count = MAX_THREADS;
		}

		long thread_id;
		printf ("Open bases\n");
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			SearchBase* base = new SearchBase (argv [1]);
			base->IsOk ();
			base->check_version ();

			SortAttrCache::instance ()->load (base);

			thread_data [thread_id].base = base;
			thread_data [thread_id].done = 0;
		}
		printf ("Run\n");
		long ok_threads = 0;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			boost::thread thread (calculate_search, thread_id);
			thread.detach ();
			ok_threads++;
			ACE_OS::sleep (2);
		}
		long last_time;
		bool b_timeout = false;
		for (;;) {
			char* request_str = get_request (false);
			if (request_str) {
				printf ("\nthreads checked, %s\n", request_str);
				last_time = time (0);
				free (request_str);
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
		printf ("\ndelete threads"); fflush (stdout);

		//записать кэши
		if (argv [5]) {
			FILE *out_file = fopen (argv [5], "wt");
			for (long segs = 1; segs < MAX_SEGS; segs++) {
				long seg = segs;
				if (map_request_data [seg].size ()) {
					fprintf (out_file, "|%03d\n", seg);
					std::map<std::string, void*> *map_request_data_ptr = &map_request_data [seg];
					std::map<std::string, long>  *map_request_size_ptr = &map_request_size [seg];
					std::map<std::string, long>::const_iterator size_it = map_request_size_ptr->begin ();
					std::map<std::string, void*>::const_iterator data_it = map_request_data_ptr->begin ();
					for (; size_it != map_request_size_ptr->end (); size_it++, data_it++) {
						long size = size_it->second - sizeof (long), count = *(long*) data_it->second;
						fprintf (out_file, "%s|%ld:", size_it->first.c_str (), count);
						RefwRele *ptr = (RefwRele*) ((char*)data_it->second + sizeof (long));
						for (long i = 0; i < size / sizeof (RefwRele); i++, ptr++)
							fprintf (out_file, " %ld.%ld.%ld", ptr->DocId, (long) ptr->Rele, ptr->Word);
						fprintf (out_file, "\n");
					}
				}
			}
			fprintf (out_file, "|0\n");
			fclose (out_file);

			/*if (!b_timeout) {
				for (thread_id = 0; thread_id < threads_count; thread_id++)
					delete thread_data [thread_id].base;
			}*/
		} else {
			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			for (long segs = 1; segs < MAX_SEGS; segs++) {
				long seg = segs;
				if (map_request_data [seg].size ()) {
					std::map<std::string, void*> *map_request_data_ptr = &map_request_data [seg];
					std::map<std::string, long>  *map_request_size_ptr = &map_request_size [seg];
					char str_offsets_name [5], str_results_name [5];
					sprintf (str_offsets_name, "-%03d", seg);
					sprintf (str_results_name, "|%03d", seg);
					std::map<std::string, long>::const_iterator size_it = map_request_size_ptr->begin ();
					std::map<std::string, void*>::const_iterator data_it = map_request_data_ptr->begin ();

					Stream *str_offsets = base->FindIndex ("Aux")->Open (str_offsets_name, 1);
					Stream *str_results = base->FindIndex ("Aux")->Open (str_results_name, 1);
					for (; size_it != map_request_size_ptr->end (); size_it++, data_it++) {
						std::string request_str = size_it->first;
						long size = size_it->second, request_str_size = request_str.size () + 1, str_results_pos = str_results->Tell ();
						str_offsets->Write (&request_str_size, sizeof (long));
						str_offsets->Write (request_str.c_str (), request_str_size);
						str_offsets->Write (&str_results_pos, sizeof (long));

						void* data = data_it->second;
						str_results->Write (data, size);
					}
					str_offsets->Trunc ();
					str_results->Trunc ();
					base->FindIndex ("Aux")->Close (str_offsets);
					base->FindIndex ("Aux")->Close (str_results);
				}
			}
			delete base;
		}
		exit (EXIT_SUCCESS);
	}
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
