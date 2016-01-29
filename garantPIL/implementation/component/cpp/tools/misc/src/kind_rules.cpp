
#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"

#include <stack>
#include "gardefs.h"
#include "SearchB.h"
#include "recode.h"

int	main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

SearchBase* base = 0;
bool	b_recode = false;
char	shrinked_str [2048];
char*	shrink_str (char* index_str)
{
	char* toput = shrinked_str;
	*toput = 0;
	char *token = strtok (index_str, "\\");
	while (token) {
		if (toput != shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = strlen (token)-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	return shrinked_str;
}

bool	local_compare_hstr (char* index_str, const char* user_str)
{
	char* toput = shrinked_str;
	*toput = 0;
	char *token = strtok (index_str, "\\");
	while (token) {
		if (toput != shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = strlen (token)-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	return !strcmp (shrinked_str, user_str);
}

IndexReq*	build_hindex_req (const char* index_name, std::vector<std::string> &strs, int search_op = SO_AND | SO_KEYS_AND)
{
	if (!strs.size ())
		return 0;

	IndexReq* req = 0;

	HIndex* index = (HIndex*)base->FindIndex (index_name);
	req = (IndexReq*) malloc (sizeof (IndexReq) + strs.size () * index->KeyLength);
	req->ItemCount = strs.size ();
	req->ItemSize  = index->KeyLength;
	req->SearchOp  = search_op;
	strcpy (req->Name, index_name);

	std::map<long,std::string> map_id_name;
	std::map<long,long> map_id_parentid;
	std::set<std::string> full_names;

	for (BTIterator btit (index); !btit.End (); ++btit) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
		map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
		if (key->level) {
			std::string name = map_id_name.find (key->parent)->second;
			name += "\\";
			name += key->text+4;
			map_id_name.insert (std::map<long,std::string>::value_type (key->id, name));
			full_names.insert (name);
		} else {
			map_id_name.insert (std::map<long,std::string>::value_type (key->id, key->text+4));
			full_names.insert (key->text+4);
		}
	}

	long max_count = 0;
	for (std::vector<std::string>::const_iterator keys_it = strs.begin (); keys_it != strs.end (); keys_it++) {
		if (full_names.find (*keys_it) != full_names.end ())
			max_count++;
	}

	if (max_count == strs.size ()) {
		max_count = 0;
		for (BTIterator btit (index); !btit.End () && max_count < strs.size (); ++btit) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
			std::string name = map_id_name.find (key->id)->second;
			char* toput = (char*)(req+1);
			for (std::vector<std::string>::const_iterator keys_it = strs.begin (); keys_it != strs.end (); keys_it++, toput += req->ItemSize) {
				if (!strcmp (name.c_str (), keys_it->c_str ())) {
					max_count++;
					memcpy (toput, key, req->ItemSize);
					break;
				}
			}
		}
	} else {
		for (std::vector<std::string>::const_iterator keys_it = strs.begin (); keys_it != strs.end (); keys_it++) {
			if (full_names.find (*keys_it) == full_names.end ())
				printf ("Error, not found %s\n", keys_it->c_str ());
		}
		return 0;
	}
		
	return req;
}

IndexReq*	build_index_req (const char* index_name, std::vector<std::string> &strs)
{
	IndexReq* req = 0;
	if (strs.size ()) {
		Index* index = base->FindIndex (index_name);
		req = (IndexReq*) malloc (sizeof (IndexReq) + strs.size () * index->KeyLength);
		req->ItemCount = 0;
		req->ItemSize  = index->KeyLength;
		req->SearchOp  = SO_AND | SO_KEYS_AND;
		strcpy (req->Name, index_name);
		char* toput = (char*)(req+1);
		for (std::vector<std::string>::const_iterator it = strs.begin (); it != strs.end (); it++) {
			for (BTIterator btit (index); !btit.End (); ++btit) {
				char* aKey = (char*) btit.Key();
				if (!strcmp (aKey, it->c_str ())) {
					memcpy (toput, aKey, req->ItemSize);
					req->ItemCount++;
					toput += req->ItemSize;
				}
			}
		}
		if (req->ItemCount != strs.size ())
			return 0;
	}
	return req;
}

IndexReq*	build_short_req (const char* index_name, std::vector<short> &shorts, int search_op = SO_AND)
{
	IndexReq* req = 0;
	if (shorts.size ()) {
		Index* index = base->FindIndex (index_name);
		req = (IndexReq*) malloc (sizeof (IndexReq) + shorts.size () * sizeof (short));
		req->ItemCount = 0;
		req->ItemSize  = sizeof (short);
		req->SearchOp  = search_op;
		strcpy (req->Name, index_name);
		short* toput = (short*)(req+1);
		for (std::vector<short>::const_iterator it = shorts.begin (); it != shorts.end (); it++) {
			short key = *it;
			memcpy (toput, &key, sizeof (key));
			req->ItemCount++;
			toput++;
		}
	}
	return req;
}

IndexReq*	build_date_req (const char* index_name, std::vector<date> &dates)
{
	IndexReq* req = 0;
	if (dates.size ()) {
		Index* index = base->FindIndex (index_name);
		req = (IndexReq*) malloc (sizeof (IndexReq) + dates.size () * sizeof (date));
		req->ItemCount = 0;
		req->ItemSize  = sizeof (date);
		req->SearchOp  = SV_RANGE | SO_AND;
		strcpy (req->Name, index_name);
		date* toput = (date*)(req+1);
		for (std::vector<date>::const_iterator it = dates.begin (); it != dates.end (); it++) {
			date key = *it;
			memcpy (toput, &key, sizeof (key));
			req->ItemCount++;
			toput++;
		}
	}
	return req;
}

int main_logic ( int argc, char *argv[] )
{
	if (argc < 4)
		return 0;

	base = new SearchBase (argv [1]);
	base->IsOk ();
	base->check_version ();
	delete base->AllDocs ();

	bool b_english_base = false;
	{
	Stream *hereStr = base->FindIndex ("Aux")->Open ("Here");
	short hcount = (short) hereStr->Length () / sizeof (short), *heres = (short*) malloc (hereStr->Length ());
	hereStr->Read (heres, hereStr->Length ());
	base->FindIndex ("Aux")->Close (hereStr);

	for (int i = 0; i<hcount; i++) if (heres [i] == 32 || (heres [i] >= 240 && heres [i] <= 255)) {
		b_english_base = true;
		break;
	}

	free (heres);
	}

	std::map<std::string,RefCollection*> map_key_refs;
	std::map<std::string, std::string> map_key_fullkey;
	FILE *kindFile = fopen (argv [2], "rt");
	while (!feof (kindFile)) {
		char str [256];

		if (!fgets (str, sizeof (str), kindFile))
			continue;

		int length = strlen (str);
		while (length && (str [length-1] == 10 || str [length-1] == 13 || str [length-1] == ' '))
			str [--length] = 0;

		Recoding (cd_dos, cd_win, str);
		map_key_fullkey.insert (std::map<std::string,std::string>::value_type (shrink_str (str), str));
	}
	fclose (kindFile);

	std::vector<std::string> classes, types, prefixes, norms, sources, not_sources, territories;
	std::vector<short> segments, statuses, statuses_ex;
	std::vector<date> dates;
	long phase = 0;	
	RefCollection *kind_refs = new RefCollection (); //список документов.блоков, которым проставлен какой-либо KIND

	FILE *rulesFile = fopen (argv [3], "rt");
	if (!rulesFile)
		exit (EXIT_FAILURE);

	bool b_writeidd = true;
	if (argv [4] && !stricmp (argv [4], "-noidd"))
		b_writeidd = false;

	while (!feof (rulesFile)) {
		char str [256];

		if (!fgets (str, sizeof (str), rulesFile))
			continue;

		int length = strlen (str);
		while (length && (str [length-1] == 10 || str [length-1] == 13 || str [length-1] == ' '))
			str [--length] = 0;

		Recoding (cd_dos, cd_win, str);

		if (!strlen (str))
			continue;

		if (!stricmp (str, "[TYPE]"))
			phase = 1;
		else
		if (!stricmp (str, "[SOURCE]"))
			phase = 2;
		else
		if (!stricmp (str, "[TERRITORY]"))
			phase = 3;
		else
		if (!stricmp (str, "[CLASS]"))
			phase = 4;
		else
		if (!stricmp (str, "[SEGMENT]"))
			phase = 9;
		else
		if (!stricmp (str, "[STATUS]"))
			phase = 11;
		else
		if (!stricmp (str, "[DATE]"))
			phase = 12;
		else
		if (!stricmp (str, "[NORM]"))
			phase = 7;
		else
		if (!stricmp (str, "[STATUSEX]"))
			phase = 13;
		else
		if (!strcmp (str, "[KIND]"))
			phase = 99;
		else
		if (str [0] == '[') {
			printf ("Unknown %s\n", str);
		} else {
			switch (phase) {
				case 1:
					types.push_back (str);
					break;
				case 2:
					sources.push_back (str);
					break;
				case 3:
					territories.push_back (str);
					break;
				case 4:
					classes.push_back (str);
					break;
				case 5:
					prefixes.push_back (str);
					break;
				case 12: //DATE
					{
						long day, month, year;
						sscanf (str, "%ld/%ld/%ld", &day, &month, &year);
						date adate;
						adate.da_day = day;
						adate.da_mon = month;
						adate.da_year = year;
						dates.push_back (adate);
					}
					break;
				case 9: //SEGMENT
					segments.push_back (atol (str));
					break;
				case 11:
					statuses.push_back (atol (str));
					break;
				case 13:
					statuses_ex.push_back (atol (str));
					break;
				case 7:
					norms.push_back (str);
					break;
				case 99:
					{
					bool b_ok = true;
					std::map<std::string,std::string>::const_iterator key_it = map_key_fullkey.find (str);
					if (key_it == map_key_fullkey.end ()) {
						printf ("KIND %s not found\n", str);
						//нет такого ключа
						b_ok = false;
					}

					IndexReq *reqs [20];
					IndexReq *classes_req = 0;
					if (classes.size () && !(classes_req = build_hindex_req ("Class", classes)))
						b_ok = false;
					IndexReq *types_req = 0;
					if (types.size () && !(types_req = build_hindex_req ("Type", types)))
						b_ok = false;
					IndexReq *territories_req = 0;
					if (territories.size () && !(territories_req = build_hindex_req ("Territory", territories)))
						b_ok = false;
					IndexReq *norms_req = build_index_req ("Category", norms);
					IndexReq *sources_req = 0;
					if (sources.size () && !(sources_req = build_hindex_req ("Adopted", sources)))
						b_ok = false;
					IndexReq *prefixes_req = build_hindex_req ("DocKind", prefixes);
					IndexReq *segments_req = build_short_req ("Segment", segments);
					IndexReq *statuses_req = build_short_req ("Status", statuses);
					IndexReq *statusesex_req = build_short_req ("Status_ex", statuses_ex);
					IndexReq *date_req = build_date_req ("Date", dates);

					long req_count = 0;
					if (classes_req)
						reqs [req_count++] = classes_req;
					if (norms_req)
						reqs [req_count++] = norms_req;
					if (sources_req)
						reqs [req_count++] = sources_req;
					if (prefixes_req)
						reqs [req_count++] = prefixes_req;
					if (types_req)
						reqs [req_count++] = types_req;
					if (territories_req)
						reqs [req_count++] = territories_req;
					if (segments_req)
						reqs [req_count++] = segments_req;
					if (statuses_req)
						reqs [req_count++] = statuses_req;
					if (statusesex_req)
						reqs [req_count++] = statusesex_req;
					if (date_req)
						reqs [req_count++] = date_req;

					if (b_ok) {
						SearchResult *result = base->Search (req_count, reqs, 0, SO_AND, 0, 0, 0, false, false);
						if (result) {
							SortedCollection* list = result->list;
							if (list && list->ItemCount) {
								kind_refs->Merge (*list);

								std::map<std::string,RefCollection*>::iterator map_it = map_key_refs.find (key_it->second.c_str ());
								if (map_it == map_key_refs.end ()) {
									RefCollection *refs = new RefCollection ();
									refs->Merge (*list);
									map_key_refs.insert (std::map<std::string,RefCollection*>::value_type (key_it->second.c_str (), refs));
								} else {
									map_it->second->Merge (*list);
								}
							}

							delete list;
							delete result;
						}
						for (int i = 0; i < req_count; i++)
							delete reqs [i];
					}
					classes.clear ();
					types.clear ();
					prefixes.clear ();
					norms.clear ();
					sources.clear ();
					not_sources.clear ();
					territories.clear ();
					segments.clear ();
					statuses.clear ();
					statuses_ex.clear ();
					dates.clear ();
					phase = 0;
					}
					break;
			}
		}
	}

	delete base;

	{
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);

		HIndex *kinds = (HIndex*) base->FindIndex ("Kind");
		for (BTIterator it (kinds); !it.End (); ++it) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) it.Key ();
			if (!key->chCount) {
				Stream* str = kinds->keyOpen (key, 0);
				RefCollection* refs = new RefCollection ();
				refs->Get (str);
				kind_refs->Merge (*refs);
				kinds->Close (str);
			}
		}

		RefCollection *all_docs = new RefCollection ();
		all_docs->Merge (*base->AllDocs ());

		{
		//надо добавить еще редакции
		Stream *str = base->FindIndex ("Aux")->Open ("Edis");
		if (str) {
			DocCollection edis;
			long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
			str->Read (data, size);
			base->FindIndex ("Aux")->Close (str);
			size >>= 3;
			for (int i = 0; i < size; i++) {
				long edition = *ptr;
				ptr++;
				ptr++;
				edis.Add (edition);
			}
			free (data);
			all_docs->Merge (edis);
		}
		}

		all_docs->m_bCompType = COMP_MINUS;
		all_docs->Minus (*kind_refs);
		if (all_docs->ItemCount) {
			std::map<std::string,RefCollection*>::iterator map_it = map_key_refs.find (map_key_fullkey.find (b_english_base ? "Documents\\Federal acts" : "Акты органов власти\\Федеральные акты")->second.c_str ());
			if (map_it == map_key_refs.end ())
				map_key_refs.insert (std::map<std::string,RefCollection*>::value_type (map_key_fullkey.find (b_english_base ? "Documents\\Federal acts" : "Акты органов власти\\Федеральные акты")->second.c_str (), all_docs));
			else
				map_it->second->Merge (*all_docs);
		}

		std::map<long,std::set<std::string> > map_doc_kinds;
		
		for (std::map<std::string,RefCollection*>::iterator map_it = map_key_refs.begin (); map_it != map_key_refs.end (); map_it++) {
			RefCollection *refs = map_it->second;
			printf ("Write KIND %s for %ld docs\n", map_it->first.c_str (), refs->DocCount ()); fflush (stdout);

			char *key = strdup (map_it->first.c_str ()), *prev_level = 0;
			std::stack<std::string> keys;
			do {
				keys.push (key);
				prev_level = strrchr (key, '\\');
				if (prev_level) *prev_level = '\0';
			} while (prev_level);
			free (key);

			while (keys.size ()) {
				std::string topkey = keys.top ();
				keys.pop ();
				Stream *str = kinds->Open (topkey.c_str (), 1);
				if (str) {
					RefCollection at_str;
					at_str.Get (str);
					at_str.Merge (*refs);
					str->Seek (0);
					at_str.Put (str);
					str->Trunc ();
					kinds->Close (str);
				}
			}

			if (b_writeidd) for (int i = 0; i < refs->ItemCount; i++) {
				Ref ati = (*refs) [i];

				char to_write [1024];
				sprintf (to_write, "%ld:%s", ati.Sub, map_it->first.c_str ());
				/*
				AttrKey key = {ati.DocId, IDD_KIND};
				long size;
				char *kinds = (char*) base->LoadAttr (ati.DocId, IDD_KIND, size), *ptr = kinds;
				bool found = false;
				for (; ptr - kinds < size && !found; ptr += strlen (ptr)+1)
					found = !strcmp (ptr, to_write);
				if (!found)
					base->PutAttr (ati.DocId, IDD_KIND, to_write, strlen (to_write) + 1);
				gk_free (kinds);
				*/
				std::map<long,std::set<std::string> >::iterator kind_it = map_doc_kinds.find (ati.DocId);
				if (kind_it == map_doc_kinds.end ()) {
					std::set<std::string> to_add;
					to_add.insert (to_write);
					map_doc_kinds.insert (std::map<long,std::set<std::string> >::value_type (ati.DocId, to_add));
				} else {
					kind_it->second.insert (to_write);
				}
			}
			delete refs;
		}

		if (b_writeidd) {			
			//сначала посчитаем старые, у которых 0:$DUMMY$
			for (std::map<long,std::set<std::string> >::const_iterator it = map_doc_kinds.begin (); it != map_doc_kinds.end (); it++) {
				long new_size = 0;
				std::set<std::string>::const_iterator str_it;
				for (str_it = it->second.begin (); str_it != it->second.end (); str_it++)
					new_size += str_it->size () + 1;
				char *new_data = new char [new_size], *new_ptr = new_data;
				for (str_it = it->second.begin (); str_it != it->second.end (); str_it++) {
					strcpy (new_ptr, str_it->c_str ());
					new_ptr += str_it->size () + 1;
				}

				long id = it->first, old_size = 0;
				char *old_data = (char*) base->LoadAttr (id, IDD_KIND, old_size);
				if (old_size) {
					if (old_size == 300 && !strcmp (old_data, "0:$DUMMY$")) {
						base->ReplaceAttr (id, IDD_KIND, new_data, new_size);
					} else {
						for (new_ptr = new_data; new_ptr - new_data < new_size; new_ptr += strlen (new_ptr) + 1) {
							bool found = false;
							for (char *ptr = old_data; ptr - old_data < old_size && !found; ptr += strlen (ptr) + 1)
								found = !strcmp (ptr, new_ptr);
							if (!found)
								base->PutAttr (id, IDD_KIND, new_ptr, strlen (new_ptr) + 1);
						}
					}
					gk_free (old_data);
				} else {
					base->ReplaceAttr (id, IDD_KIND, new_data, new_size);
				}
				delete []new_data;
			}

			AttrKey key = {ID_BORDER, IDD_KIND};
			std::vector<long> to_delete;
			for (BTIterator it (base->FindIndex ("Attrs"), &key); !it.End (); ++it) {
				AttrKey *key = (AttrKey*) it.Key ();
				if (key->AttrTag != IDD_KIND)
					break;
				long id = key->DocId, size = 0;
				if (map_doc_kinds.find (id) != map_doc_kinds.end ())
					continue;
				char *data = (char*) base->LoadAttr (id, IDD_KIND, size);
				if (size) {
					if (size == 300 && !strcmp (data, "0:$DUMMY$"))
						to_delete.push_back (id);
					gk_free (data);
				}
			}
			for (std::vector<long>::const_iterator del_it = to_delete.begin (); del_it != to_delete.end (); del_it++)
				base->DelAttr (*del_it, IDD_KIND);
		}

		delete base;
	}

	exit (EXIT_SUCCESS);
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
