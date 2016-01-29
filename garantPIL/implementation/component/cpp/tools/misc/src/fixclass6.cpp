#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"
#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

char to_write [1024*1024];

int main_logic ( int argc, char *argv[] )
{
	if (argc == 4 && !strcmp (argv [3], "-copy")) {
		YBase *old_base = new YBase (argv [1], ACE_OS_O_RDONLY);
		old_base->open_saw_bases (ACE_OS_O_RDONLY);
		old_base->IsOk ();

		StdBigBase *new_base = new StdBigBase (argv [2], ACE_OS_O_RDWR);

		for (std::vector<Base*>::const_iterator base_it = old_base->bases_ptrs.begin (); base_it != old_base->bases_ptrs.end (); base_it++) {
			AttrKey attr_key = {0, IDD_CLASS6};
			for (BTIterator it ((*base_it)->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
				AttrKey *key = (AttrKey*) it.Key ();
				if (key->AttrTag != IDD_CLASS6)
					break;
				long size;
				void* data = (*base_it)->LoadAttr (key->DocId, IDD_CLASS6, size);
				new_base->ReplaceAttr (key->DocId, IDD_CLASS6, data, size);
				gk_free (data);
				if (key->DocId % 100 == 0)
					printf ("%ld\r", key->DocId);
			}
		}
		old_base->close_saw_bases ();
		delete old_base;
		delete new_base;

		exit (EXIT_SUCCESS);
	}

	bool two_bases = argc > 2 ? (strcmp (argv [2], "-noidd") ? true : false) : false;

	YBase* aBase = new YBase (argv [two_bases ? 2 : 1], ACE_OS_O_RDONLY);
	aBase->IsOk ();

	std::set<long> docs_with_iddclass6;
	std::map<long,HIndex::HIndexKey*> id_keys;
	std::map<long,std::set<long> > child_ids;
	std::map<long,long> own_id;
	HIndex *class6 = (HIndex*)aBase->FindIndex ("Class6");
	long malloc_size = sizeof (HIndex::HIndexKey) + CLASS_KEY_SIZE;
	for (BTIterator it (class6); !it.End (); ++it) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) malloc (malloc_size);
		memcpy (key, it.Key (), malloc_size);
		id_keys.insert (std::map<long,HIndex::HIndexKey*>::value_type (key->id, key));

		if (key->achCount + key->chCount) {
			own_id.insert (std::map<long,long>::value_type (key->id, key->parent));
			std::set<long> empty_childs;
			child_ids.insert (std::map<long,std::set<long> >::value_type (key->id, empty_childs));
		} else {
			long parent = key->parent;
			while (parent) {
				std::map<long,std::set<long> >::iterator map_iter = child_ids.find (parent);
				if (map_iter != child_ids.end ())
					map_iter->second.insert (key->id);
				parent = own_id.find (parent)->second;
			}
		}
	}

	std::map<long, std::string> map_id_str; //мапа, в которой храним все ключи индекса Class6
	std::map<std::string, long> map_str_id;
	std::map<long, std::deque<Ref> > map_doc_keys; //мапа, в которой храним для документов записи вида: вместо DocId - ключ из map_id_str, Sub - на каком это сабе
	long id = 1;

	char full_name [2048];
	for (std::map<long,HIndex::HIndexKey*>::const_iterator map_it = id_keys.begin (); map_it != id_keys.end (); map_it++) {
		HIndex::HIndexKey* key = map_it->second;
		if (key->chCount + key->achCount == 0) {
			class6->FullName (key, full_name);
			map_id_str.insert (std::map<long, std::string>::value_type (id, full_name));
			map_str_id.insert (std::map<std::string, long>::value_type (full_name, id));
			Stream* str = class6->Index::OpenN (key, 0);
			if (str) {
				RefCollection refs;
				refs.Get (str);
				class6->Close (str);
				for (int i = 0; i < refs.ItemCount; i++) {
					Ref ref = refs [i];
					std::map<long, std::deque<Ref> >::iterator map_doc_keys_iter = map_doc_keys.find (ref.DocId);
					Ref ref_toinsert = {id, ref.Sub};
					if (map_doc_keys_iter == map_doc_keys.end ()) {
						std::deque<Ref> vector_toinsert;
						vector_toinsert.push_back (ref_toinsert);
						map_doc_keys.insert (std::map<long, std::deque<Ref> >::value_type (ref.DocId, vector_toinsert));
					} else {
						map_doc_keys_iter->second.push_back (ref_toinsert);
					}
				}
			}
			id++;
		}
	}

	delete aBase;

	StdBigBase *outBase = new StdBigBase (argv [two_bases ? 2 : 1], ACE_OS_O_RDWR);
	outBase->open_saw_bases (ACE_OS_O_RDWR);

	DocCollection *alldocs = 0, *alldocs_with_iddclass6 = 0;
	alldocs = outBase->AllTopics ();
	alldocs_with_iddclass6 = new DocCollection ();
	AttrKey iddclass6_key = {0, IDD_CLASS6};
	for (std::vector<Base*>::const_iterator base_it = outBase->bases_ptrs.begin (); base_it != outBase->bases_ptrs.end (); base_it++) {
		for (BTIterator it ((*base_it)->FindIndex ("Attrs"), &iddclass6_key); !it.End (); ++it) {
			AttrKey* key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_CLASS6)
				break;
			alldocs_with_iddclass6->Insert (&key->DocId);
		}
	}

	class6 = (HIndex*)outBase->FindIndex ("Class6");
	for (std::map<long,std::set<long> >::const_iterator map_iter = child_ids.begin (); map_iter != child_ids.end (); map_iter++) {
		RefCollection *refs = new RefCollection;
		std::deque<u_int64_t> merged;
		for (std::set<long>::const_iterator it = map_iter->second.begin (); it != map_iter->second.end (); it++) {
			RefCollection* to_merge = new RefCollection ();
			std::map<long,HIndex::HIndexKey*>::const_iterator key_it = id_keys.find (*it);
			if (key_it != id_keys.end ()) {
				Stream* str = class6->Index::OpenN (key_it->second, 0);
				if (str) {
					to_merge->Get (str);
					class6->Close (str);
				}
			}
			for (int i = 0; i < to_merge->ItemCount; i++) {
				Ref at_i = to_merge->GetItem (i);
				u_int64_t ref = ((u_int64_t(at_i.DocId)) << 32) + at_i.Sub;
				merged.push_back (ref);
			}
			delete to_merge;
		}
		std::sort (merged.begin (), merged.end ());
		merged.erase (std::unique (merged.begin (), merged.end ()), merged.end ());
		for (std::deque<u_int64_t>::const_iterator it2 = merged.begin (); it2 != merged.end (); it2++) {
			u_int64_t at_it2 = *it2;
			Ref ref = {at_it2 >> 32, at_it2 & 0xFFFFFFFF};
			refs->Collection::Add (&ref);
		}

		HIndex::HIndexKey *hindexkey = id_keys.find (map_iter->first)->second;
		Stream* str = class6->Index::OpenN (hindexkey, 0);
		if (str) {
			refs->Put (str);
			str->Trunc ();
			class6->Close (str);
		}
		delete refs;
	}

	if (two_bases) {
		//есть и старая база
		YBase *old_base = new YBase (argv [1], ACE_OS_O_RDONLY);
		old_base->IsOk ();
		Stream *str = old_base->FindIndex ("Aux")->Open (AUX_CLASS6_KEYS);
		if (str) {
			long length = str->Length (), l = 0, i = 0, old_id;
			char *old_data = (char*) malloc (length), *ptr = old_data;
			str->Read (old_data, length);
			old_base->FindIndex ("Aux")->Close (str);
			
			std::map<std::string, long> oldmap_str_id;

			while (i < length) {
				long len = strlen (ptr) + 1;
				char *pos = strchr (ptr, ':'), *after_pos = pos+1;
				*pos = 0;
				if (*after_pos) {
					long key_id = atol (ptr);
					oldmap_str_id.insert (std::map<std::string, long>::value_type (after_pos, key_id));
				} else {
					old_id = atol (ptr);
				}
				ptr += len;
				i += len;
			}
			gk_free (old_data);

			std::map<long,long> map_id_corrid;
			for (std::map<long, std::string>::const_iterator it = map_id_str.begin (); it != map_id_str.end (); it++) {
				std::string key = it->second;
				long was_id = map_str_id.find (key)->second, corr_id;
				std::map<std::string, long>::const_iterator corr_id_iter = oldmap_str_id.find (key);
				if (corr_id_iter != oldmap_str_id.end ())
					corr_id = corr_id_iter->second;
				else
					corr_id = old_id++;
				map_id_corrid.insert (std::map<long,long>::value_type (was_id, corr_id));
			}

			long step = map_doc_keys.size () / 100, pos = 0, percents = 0;
			printf ("0%%\r");
			for (std::map<long, std::deque<Ref> >::const_iterator map_doc_keys_iter = map_doc_keys.begin (); map_doc_keys_iter != map_doc_keys.end (); map_doc_keys_iter++) {
				long doc_id = map_doc_keys_iter->first, length = 1;
				if (++pos > step) {
					pos = 0;
					printf ("%ld%%\r", ++percents);
				}

				char *ptr = to_write;
				long count = 0;
				for (std::deque<Ref>::const_iterator refs_iter = map_doc_keys_iter->second.begin (); refs_iter != map_doc_keys_iter->second.end (); refs_iter++) {
					Ref ref = *refs_iter;
					mpcxc_ltoa (ref.Sub, ptr, 10);
					while (*ptr) ptr++;
					*ptr++ = ':';
					mpcxc_ltoa (map_id_corrid.find (ref.DocId)->second, ptr, 10);
					while (*ptr) ptr++;
					ptr++;
					count++;
					if (count > 32760)
						break; //ограничение в дельте shortом
				}
				outBase->ReplaceAttr (doc_id, IDD_CLASS6, to_write, ptr - to_write);
				docs_with_iddclass6.insert (doc_id);
			}

			Stream *str = outBase->FindIndex ("Aux")->Open (AUX_CLASS6_KEYS, 1);
			if (str) {
				for (std::map<long,std::string>::const_iterator it = map_id_str.begin (); it != map_id_str.end (); it++) {
					sprintf (to_write, "%ld:%s", map_id_corrid.find (it->first)->second, it->second.c_str ());
					str->Write (to_write, strlen (to_write)+1);
				}
				sprintf (to_write, "%ld:", old_id);
				str->Write (to_write, strlen (to_write)+1);
				str->Trunc ();
				outBase->FindIndex ("Aux")->Close (str);
			}
		}
		delete old_base;
	} else {
		//одна база
		bool b_no_idd = (argc == 3 && !stricmp (argv [2], "-noidd")) ? true : false;
		if (b_no_idd) {
			if (alldocs_with_iddclass6) {
				delete alldocs_with_iddclass6;
				alldocs_with_iddclass6 = 0;
			}
		} else {
			long step = map_doc_keys.size () / 100, pos = 0, percents = 0;
			printf ("0%%\r");
			for (std::map<long, std::deque<Ref> >::const_iterator map_doc_keys_iter = map_doc_keys.begin (); map_doc_keys_iter != map_doc_keys.end (); map_doc_keys_iter++) {
				long doc_id = map_doc_keys_iter->first, length = 1;
				if (++pos > step) {
					pos = 0;
					printf ("%ld%%\r", ++percents);
				}
				char *ptr = to_write;
				for (std::deque<Ref>::const_iterator refs_iter = map_doc_keys_iter->second.begin (); refs_iter != map_doc_keys_iter->second.end (); refs_iter++) {
					Ref ref = *refs_iter;
					mpcxc_ltoa (ref.Sub, ptr, 10);
					while (*ptr) ptr++;
					*ptr++ = ':';
					mpcxc_ltoa (ref.DocId, ptr, 10);
					while (*ptr) ptr++;
					ptr++;
				}
				outBase->ReplaceAttr (doc_id, IDD_CLASS6, to_write, ptr - to_write);
				docs_with_iddclass6.insert (doc_id);
			}
			printf ("\n");
		}
		Stream *str = outBase->FindIndex ("Aux")->Open (AUX_CLASS6_KEYS, 1);
		if (str) {
			for (std::map<long,std::string>::const_iterator it = map_id_str.begin (); it != map_id_str.end (); it++) {
				sprintf (to_write, "%ld:%s", it->first, it->second.c_str ());
				str->Write (to_write, strlen (to_write)+1);
			}
			sprintf (to_write, "%ld:", id);
			str->Write (to_write, strlen (to_write)+1);
			str->Trunc ();
			outBase->FindIndex ("Aux")->Close (str);
		}
	}

	if (alldocs_with_iddclass6) {
		for (long i = 0; i < alldocs_with_iddclass6->ItemCount; i++) {
			long doc_id = (*alldocs_with_iddclass6) [i];
			if (docs_with_iddclass6.find (doc_id) == docs_with_iddclass6.end ()) {
				outBase->DelAttr (doc_id, IDD_CLASS6);
				printf ("del IDD_CLASS6 for %ld\r", doc_id);
			}
		}
	}

	outBase->close_saw_bases ();
	delete outBase;
	exit (EXIT_SUCCESS);
}

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
