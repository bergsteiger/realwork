#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"

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

YBase *base;
std::map<short, DocCollection*> map_segment_docs;

#define	MAX_THREADS	16
struct thread_data_struct {
	YBase *base;
	HIndex *hindex;
	Index* index;
	std::map<std::string,std::vector<short> > map_key_segs;
	volatile int done;
};
thread_data_struct thread_data [MAX_THREADS];
int	threads_count = 1;

std::map<long,std::string> map_id_name;
std::deque<HIndex::HIndexKey*> hindex_keys;
std::deque<HIndex::HIndexKey*>::iterator hindex_keys_thread_it;
std::deque<std::string> plain_keys;
std::deque<std::string>::iterator plain_keys_thread_it;
ACE_Recursive_Thread_Mutex keys_thread_it_mutex;

bool b_refsinindex;
bool b_inpharm_index;

DocCollection *med_topics = 0;

HIndex::HIndexKey*	get_nexthindexkey (bool next)
{
	RWRITE_GUARD (keys_thread_it_mutex) {
		if (hindex_keys_thread_it == hindex_keys.end ())
			return 0;
		HIndex::HIndexKey *result = *hindex_keys_thread_it;
		if (next)
			hindex_keys_thread_it++;
		return result;
	}
}

const char* get_nextplainkey (bool next)
{
	RWRITE_GUARD (keys_thread_it_mutex) {
		if (plain_keys_thread_it == plain_keys.end ())
			return 0;
		const char* result = plain_keys_thread_it->c_str ();
		if (next)
			plain_keys_thread_it++;
		return result;
	}
}

void	do_intersect (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	while (true) {
		HIndex::HIndexKey *key = get_nexthindexkey (true);
		if (!key)
			break;

		DocCollection docs;
		Stream *str = thread_data_ptr->hindex->Index::OpenN (key, 0);
		if (str) {
			if (b_refsinindex)
				docs.FastLoadRefs (str);
			else
				docs.Get (str);
			thread_data_ptr->hindex->Close (str);
		}

		std::vector<short> segs;
		for (std::map<short,DocCollection*>::const_iterator map_it = map_segment_docs.begin (); map_it != map_segment_docs.end (); map_it++)
			if (b_inpharm_index && map_it->first == INPHARM_SEGMENT) {
				if (docs.IsSect (med_topics))
					segs.push_back (map_it->first);
			} else {
				if (docs.IsSect (map_it->second))
					segs.push_back (map_it->first);
			}
		
		if (segs.size ()) {
			std::map<long,std::string>::const_iterator map_it = map_id_name.find (key->id);
			thread_data_ptr->map_key_segs.insert (std::map<std::string,std::vector<short> >::value_type (map_it->second, segs));
		}
	}

	thread_data_ptr->done = 1;
}

void	do_plain_intersect (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	while (true) {
		const char* key = get_nextplainkey (true);
		if (!key)
			break;

		DocCollection docs;
		Stream *str = thread_data_ptr->index->Open (key, 0);
		if (str) {
			if (b_refsinindex)
				docs.FastLoadRefs (str);
			else
				docs.Get (str);
			thread_data_ptr->index->Close (str);
		}

		std::set<short> segs;
		for (int i = 0; i < docs.ItemCount; i++) {
			long id = docs [i], count = 0;
			short *data = (short*) thread_data_ptr->base->LoadAttr (id, IDD_BASES, count), *ptr = data;
			for (int j = 0; j < count / 2; j++, ptr++) 
				segs.insert (*ptr);
			gk_free (data);
		}

		std::vector<short> vector_segs;
		for (std::set<short>::const_iterator seg_it = segs.begin (); seg_it != segs.end (); seg_it++)
			vector_segs.push_back (*seg_it);
		thread_data_ptr->map_key_segs.insert (std::map<std::string,std::vector<short> >::value_type (key, vector_segs));

		/*
		std::vector<short> segs;
		for (std::map<short,DocCollection*>::const_iterator map_it = map_segment_docs.begin (); map_it != map_segment_docs.end (); map_it++)
			if (docs.IsSect (map_it->second))
				segs.push_back (map_it->first);
		thread_data_ptr->map_key_segs.insert (std::map<std::string,std::vector<short> >::value_type (key, segs));
		*/
	}

	thread_data_ptr->done = 1;
}

void	process_hindex (char *index_name, std::map<std::string,std::vector<short> > &map_key_segs)
{
	map_key_segs.clear ();

	HIndex *hindex = (HIndex*) base->FindIndex (index_name);
	printf ("process index %s, keys: %ld\n", index_name, hindex->KeyCount);

	b_inpharm_index = !strcmp (index_name, "LekForm") || !strcmp (index_name, "Chapter") || !strcmp (index_name, "PhFirm") || !strcmp (index_name, "PhCountry") || !strcmp (index_name, "RegStatus") || !strcmp (index_name, "PhGroup") || !strcmp (index_name, "Atc") || !strcmp (index_name, "Mkb");
	b_refsinindex = !strcmp (index_name, "Kind") || !strcmp (index_name, "Type") || !strcmp (index_name, "Class") || !strcmp (index_name, "KeyWord");
	long b_plus4 = !strcmp (index_name, "KeyWord") ? 0 : 4;

	for (std::deque<HIndex::HIndexKey*>::iterator keys_it = hindex_keys.begin (); keys_it != hindex_keys.end (); keys_it++)
		gk_free (*keys_it);
	hindex_keys.clear ();
	map_id_name.clear ();

	std::map<long,long> map_id_parentid;
	for (BTIterator btit (hindex); !btit.End (); ++btit) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
		map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
		std::string name;
		if (key->level) {
			name = map_id_name.find (key->parent)->second;
			name += "\\";
			name += key->text + b_plus4;
			map_id_name.insert (std::map<long,std::string>::value_type (key->id, name));
		} else {
			name = key->text + b_plus4;
			map_id_name.insert (std::map<long,std::string>::value_type (key->id, name.c_str ()));
		}
		HIndex::HIndexKey *dup = (HIndex::HIndexKey*) malloc (hindex->KeyLength);
		memcpy (dup, key, hindex->KeyLength);
		hindex_keys.push_back (dup);
	}

	hindex_keys_thread_it = hindex_keys.begin ();
	int ok_threads = 0, thread_id;
	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		thread_data [thread_id].hindex = (HIndex*) thread_data [thread_id].base->FindIndex (index_name);
		thread_data [thread_id].done = 0;
		thread_data [thread_id].map_key_segs.clear ();
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		inst->spawn ((ACE_THR_FUNC)do_intersect, &thread_id, THR_DETACHED);
		ok_threads++;
		ACE_OS::sleep (1);
	}

	for (;;) {
		HIndex::HIndexKey *key = get_nexthindexkey (false);
		if (key) {
			ACE_OS::sleep (1);
		} else {
			int dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
		}
	}

	for (thread_id = 0; thread_id < threads_count; thread_id++)
		map_key_segs.insert (thread_data [thread_id].map_key_segs.begin (), thread_data [thread_id].map_key_segs.end ());
}

void	process_plain_index (char *index_name, std::map<std::string,std::vector<short> > &map_key_segs)
{
	map_key_segs.clear ();

	Index *index = base->FindIndex (index_name);
	printf ("process index %s, keys: %ld\n", index_name, index->KeyCount);
	b_refsinindex = b_inpharm_index = false;

	bool b_shortindex = !strcmp (index_name, "Status") || !strcmp (index_name, "Segment") || !strcmp (index_name, "Status_ex");
	bool b_codesindex = !strcmp (index_name, "Number") || !strcmp (index_name, "RCode");
	bool b_strindex = !strcmp (index_name, "Category") || !strcmp (index_name, "Tag") || !strcmp (index_name, "IntName") || !strcmp (index_name, "TradeName");

	b_refsinindex = !strcmp (index_name, "Status_ex");
	b_inpharm_index = !strcmp (index_name, "IntName") || !strcmp (index_name, "TradeName");

	bool b_segmentindex = !strcmp (index_name, "Segment");
	bool b_dateindex = !strcmp (index_name, "AnnoDate");
	bool b_refweightindex = !strcmp (index_name, "Tag");

	if (b_codesindex) {
		plain_keys.clear ();
		for (BTIterator btit (index); !btit.End (); ++btit) {
			char *key = (char*)btit.Key ();
			if (strchr (key, '\\'))
				continue;
			plain_keys.push_back (key);
		}

		plain_keys_thread_it = plain_keys.begin ();
		int ok_threads = 0, thread_id;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].index = thread_data [thread_id].base->FindIndex (index_name);
			thread_data [thread_id].done = 0;
			thread_data [thread_id].map_key_segs.clear ();

			ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
			inst->spawn ((ACE_THR_FUNC)do_plain_intersect, &thread_id, THR_DETACHED);
			ok_threads++;
			ACE_OS::sleep (1);
		}

		for (;;) {
			const char *key = get_nextplainkey (false);
			if (key) {
				ACE_OS::sleep (1);
			} else {
				int dones = 0;
				for (thread_id = 0; thread_id < threads_count; thread_id++)
					if (thread_data [thread_id].done)
						dones++;
				if (dones == ok_threads)
					break;
			}
		}

		for (thread_id = 0; thread_id < threads_count; thread_id++)
			map_key_segs.insert (thread_data [thread_id].map_key_segs.begin (), thread_data [thread_id].map_key_segs.end ());
	} else {
		std::string key;
		for (BTIterator btit (index); !btit.End (); ++btit) {
			if (b_shortindex) {
				char str [16];
				long value = *(unsigned short*) btit.Key ();
				key = mpcxc_ltoa (value, str, 10);
				if (!strcmp (index_name, "Status_ex"))
					b_inpharm_index = (value == DS_MEDTOPIC) || (value == DS_MEDTOPIC) || (value == DS_NARCOTIC) || (value == DS_LIFE) || (value == DS_UNRECIPE) || (value == DS_MDICTTOPIC) || (value == DS_ALLOWED) || (value == DS_RECIPE) || (value == DS_NOTNARCOTIC) || (value== DS_NOTLIFE) || (value == DS_NOTALLOWED);
			} else if (b_strindex) {
				key = (char*) btit.Key ();
			} else if (b_dateindex) {
				char str [16];
				date value = *(date*) btit.Key ();
				sprintf (str, "%02ld/%02ld/%04ld", value.da_day, value.da_mon, value.da_year);
				key = str;
			}
			Stream* str = index->Open (btit.Key ());
			if (str) {
				DocCollection docs;
				if (b_refweightindex)
					docs.FastLoadRefWeights (str);
				else if (b_refsinindex)
					docs.FastLoadRefs (str);
				else
					docs.Get (str);
				index->Close (str);

				std::vector<short> segs;
				if (b_segmentindex) {
					segs.push_back (*(short*)btit.Key ());
				} else {
					for (std::map<short,DocCollection*>::const_iterator map_it = map_segment_docs.begin (); map_it != map_segment_docs.end (); map_it++)
						if (b_inpharm_index && map_it->first == INPHARM_SEGMENT) {
							if (docs.IsSect (med_topics))
								segs.push_back (map_it->first);
						} else {
							if (docs.IsSect (map_it->second))
								segs.push_back (map_it->first);
						}
				}
				if (segs.size ())
					map_key_segs.insert (std::map<std::string,std::vector<short> >::value_type (key, segs));
			}
		}
	}
}

int main_logic ( int argc, char *argv[] )
{
	if (argv [2])
		threads_count = atol (argv [2]);

	int thread_id;
	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		thread_data [thread_id].base = new YBase (argv [1], ACE_OS_O_RDONLY);
		thread_data [thread_id].base->IsOk ();
	}
	base = thread_data [0].base;

	Stream* str = base->FindIndex ("Aux")->Open ("Here");
	long seg_count = str->Length () / 2;
	short *here_segs = new short [seg_count], *ptr = here_segs;
	str->Read (here_segs, seg_count << 1);
	base->FindIndex ("Aux")->Close (str);

	std::deque<long> editions;
	str = base->FindIndex ("Aux")->Open ("Edis");
	if (str) {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			ptr++;
			ptr++;
			editions.push_back (edition);
		}
	}

	for (int i = 0; i < seg_count; i++, ptr++) {
		str = base->FindIndex ("Segment")->Open (ptr);
		DocCollection *docs = new DocCollection ();
		if (str) {
			docs->Get (str);
			base->FindIndex ("Segment")->Close (str);
		}
		map_segment_docs.insert (std::map<short,DocCollection*>::value_type (*ptr, docs));
	}

	med_topics = base->inpharm_medtopics ();

	delete [] here_segs;

	/*
	printf ("load belongs for editions");
	for (std::deque<long>::const_iterator it = editions.begin (); it != editions.end (); it++) {
		long edition = *it, count = 0;
		short *data = (short*) base->LoadAttr (edition, IDD_BASES, count), *ptr = data;
		for (int j = 0; j < count / 2; j++, ptr++) {
			std::map<short,DocCollection*>::iterator map_it = map_segment_docs.find (*ptr);
			if (map_it != map_segment_docs.end ())
				map_it->second->Add (edition);
		}
		gk_free (data);
	}
	printf ("\n");
	*/

	Index* si = base->FindIndex ("ServiceInfo");
	DocCollection *alldocs = base->AllDocs ();
	printf ("load documents in index ServiceInfo");
	for (BTIterator btit (si); !btit.End (); ++btit) {
		str = si->Index::OpenN (btit.Key (), 0);
		if (str) {
			DocCollection docs;
			docs.FastLoadRefs (str);
			si->Close (str);
			docs.Minus (*alldocs);
			if (docs.ItemCount) {
				for (int i = 0; i < docs.ItemCount; i++) {
					long doc = docs [i], count = 0;
					short *data = (short*) base->LoadAttr (doc, IDD_BASES, count), *ptr = data;
					for (int j = 0; j < count / 2; j++, ptr++) {
						std::map<short,DocCollection*>::iterator map_it = map_segment_docs.find (*ptr);
						if (map_it != map_segment_docs.end ())
							map_it->second->Add (doc);
					}
					gk_free (data);
				}
			}
		}
	}
	printf ("\n");

	std::map<std::string, std::map<std::string,std::vector<short> > > map_index_result;
	char *hindex_names [] = {"Class", "Type", "Kind", "Adopted", "KeyWord", "Territory", "ServiceInfo", "PublishedIn", "LekForm", "Chapter", "PhFirm", "PhCountry", "RegStatus", "PhGroup", "Atc", "Mkb"};
	char *hindex_aux_names [] = {"!Cla", "!Typ", "!Knd", "!Ado", "!KeW", "!Ter", "!SIn", "!Pub", "!LeF", "!Chp", "!PhF", "!PhC", "!ReS", "!PhG", "!Atc", "!Mkb"};

	char *index_names [] = {"Tag", "Status", "Status_ex", "Segment", "Category", "AnnoDate", "IntName", "TradeName", "RCode"}; //, "Number"
	char *aux_names [] = {"!Tag", "!Sta", "!StE", "!Seg", "!Cat", "!AnD", "!InN", "!TrN", "!RCo"}; //, "!Num"
	int index;
	for (index = 0; index < sizeof (index_names) / sizeof (char*); index++) {
		std::map<std::string,std::vector<short> > map_key_segs;
		process_plain_index (index_names [index], map_key_segs);
		map_index_result.insert (std::map<std::string, std::map<std::string,std::vector<short> > >::value_type (aux_names [index], map_key_segs));
	}
	for (index = 0; index < sizeof (hindex_names) / sizeof (char*); index++) {
		std::map<std::string,std::vector<short> > map_key_segs;
		process_hindex (hindex_names [index], map_key_segs);
		map_index_result.insert (std::map<std::string, std::map<std::string,std::vector<short> > >::value_type (hindex_aux_names [index], map_key_segs));
	}

	base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	for (std::map<std::string, std::map<std::string,std::vector<short> > >::const_iterator aux_it = map_index_result.begin (); aux_it != map_index_result.end (); aux_it++) {
		long size = 0;
		std::map<std::string,std::vector<short> >::const_iterator keys_it;
		for (keys_it = aux_it->second.begin (); keys_it != aux_it->second.end (); keys_it++)
			size += keys_it->first.size () + 1 + (keys_it->second.size () + 1) * sizeof (short);

		char *data = new char [size], *ptr = data;
		for (keys_it = aux_it->second.begin (); keys_it != aux_it->second.end (); keys_it++) {
			int str_len = keys_it->first.size () + 1;
			memcpy (ptr, keys_it->first.c_str (), str_len);
			ptr += str_len;
			*(short*)ptr = keys_it->second.size ();
			ptr += sizeof (short);
			for (std::vector<short>::const_iterator seg_it = keys_it->second.begin (); seg_it != keys_it->second.end (); seg_it++, ptr += sizeof (short))
				*(short*)ptr = *seg_it;
		}

		Stream *str = base->FindIndex("Aux")->Open (aux_it->first.c_str (), 1);
		if (str) {
			str->Write (data, size);
			str->Trunc ();
			base->FindIndex("Aux")->Close (str);
		}
		delete [] data;
	}
	delete base;

	return 0;
}
