#include "shared/Core/fix/mpcxc.h"

#include <deque>
#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"
#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "long.long.SplayMap.h"
#include "btiter.h"

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	std::deque<u_int64_t> blocks_in_docs;
	typedef std::map<long, u_int64_t> map_seg_mask;
	std::map<u_int64_t,map_seg_mask> data; //мапа [ ссылка : мапа [ сегмент : маска ]]

	if (!strcmp (argv [1], "-smart")) {
		std::set<long> heres;
		for (int i = 3; i < argc; i++) {
			YBase *base = new YBase (argv [i], ACE_OS_O_RDONLY);
			base->IsOk ();
			base->open_saw_bases (ACE_OS_O_RDONLY);

			{
			Stream *here_str = base->FindIndex ("Aux")->Open ("Here");
			short hcount = (short) here_str->Length () / sizeof (short), *heres_ptr = (short*) malloc (here_str->Length ());
			here_str->Read (heres_ptr, here_str->Length ());
			base->FindIndex ("Aux")->Close (here_str);
			for (int i = 0; i < hcount; i++)
				heres.insert (heres_ptr [i]);
			gk_free (heres_ptr);
			}

			DocCollection docs_and_editions;
			{
				std::vector<long> vector_docs_and_editions;
				for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
					AttrKey iddinfo_key = {ID_BORDER, IDD_INFO};
					Index *attrs = (*base_it)->FindIndex ("Attrs");
					for (BTIterator it (attrs, &iddinfo_key); !it.End (); ++it) {
						AttrKey* key = (AttrKey*) it.Key ();
						if (key->AttrTag != IDD_INFO)
							break;
						DocInfo docinfo;
						(*base_it)->FindDocInfo (key->DocId, docinfo);
						if (docinfo.Status & (DS_DOC|DS_EDITION))
							vector_docs_and_editions.push_back (key->DocId);
					}
				}
				std::sort (vector_docs_and_editions.begin (), vector_docs_and_editions.end ());
				vector_docs_and_editions.erase (std::unique (vector_docs_and_editions.begin (), vector_docs_and_editions.end ()), vector_docs_and_editions.end ());
				for (std::vector<long>::const_iterator it = vector_docs_and_editions.begin (); it != vector_docs_and_editions.end (); it++) {
					long id = *it;
					docs_and_editions.Collection::Add (&id);
				}

				int i;
				for (i = 0; i < docs_and_editions.ItemCount; i++) {
					long id = docs_and_editions [i], sub_count;
					u_int64_t ref = ((u_int64_t)id) << 32;
					blocks_in_docs.push_back (ref);
					SubDesc *subs = (SubDesc*) base->LoadAttr (id, IDD_SUBS, sub_count), *sub_ptr = subs;
					sub_count /= sizeof (SubDesc);
					for (int i = 0; i < sub_count; i++, sub_ptr++) {					
						ref = (((u_int64_t)id) << 32) + sub_ptr->Sub;
						blocks_in_docs.push_back (ref);
					}
					gk_free (subs);
				}
				std::sort (blocks_in_docs.begin (), blocks_in_docs.end ());
			}

			base->close_saw_bases ();
			delete base;
		}

		FILE *part_file = fopen (argv [2], "rt");
		long seg = 0;
		while (!feof (part_file)) {
			char str [1024]; str [0] = '\0';
			fgets (str, sizeof (str), part_file);

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			if (*(long*)&str == 979854707) {
				//seg:
				seg = atol (str+5);
			} else {
				long doc, sub;
				u_int64_t mask;
				doc = atol (str);
				sub = atol (strchr (str, '.') + 1);
				mask = _atoi64 (strchr (str, ':') + 1);
				u_int64_t ref = (((u_int64_t)doc) << 32) + sub;

				if (heres.find (seg) != heres.end ()) {
					if (!std::binary_search (blocks_in_docs.begin (), blocks_in_docs.end (), ref))
						continue;

					std::map<u_int64_t,map_seg_mask>::iterator it = data.find (ref);
					if (it == data.end ()) {
						map_seg_mask empty_map;
						empty_map.insert (map_seg_mask::value_type (seg, mask));
						data.insert (std::map<u_int64_t,map_seg_mask>::value_type (ref, empty_map));
					} else {
						//такой документ в мапе уже есть
						map_seg_mask *map_seg_mask_ptr = &it->second;
						map_seg_mask::iterator map_it = map_seg_mask_ptr->find (seg);
						if (map_it == map_seg_mask_ptr->end ()) {
							//такого сегмента нет
							map_seg_mask_ptr->insert (map_seg_mask::value_type (seg, mask));
						} else {
							//такой сегмент есть, надо сложить маски
							map_it->second |= mask;
						}
					}
				}
			}
		}
		fclose (part_file);

	} else {
		YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		base->open_saw_bases (ACE_OS_O_RDONLY);

		std::set<long> heres;
		{
		Stream *here_str = base->FindIndex ("Aux")->Open ("Here");
		short hcount = (short) here_str->Length () / sizeof (short), *heres_ptr = (short*) malloc (here_str->Length ());
		here_str->Read (heres_ptr, here_str->Length ());
		base->FindIndex ("Aux")->Close (here_str);
		for (int i = 0; i < hcount; i++)
			heres.insert (heres_ptr [i]);
		gk_free (heres_ptr);
		}

		DocCollection docs_and_editions;
		{
			std::vector<long> vector_docs_and_editions;
			for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
				AttrKey iddinfo_key = {ID_BORDER, IDD_INFO};
				Index *attrs = (*base_it)->FindIndex ("Attrs");
				for (BTIterator it (attrs, &iddinfo_key); !it.End (); ++it) {
					AttrKey* key = (AttrKey*) it.Key ();
					if (key->AttrTag != IDD_INFO)
						break;
					DocInfo docinfo;
					(*base_it)->FindDocInfo (key->DocId, docinfo);
					if (docinfo.Status & (DS_DOC|DS_EDITION))
						vector_docs_and_editions.push_back (key->DocId);
				}
			}
			std::sort (vector_docs_and_editions.begin (), vector_docs_and_editions.end ());
			vector_docs_and_editions.erase (std::unique (vector_docs_and_editions.begin (), vector_docs_and_editions.end ()), vector_docs_and_editions.end ());
			for (std::vector<long>::const_iterator it = vector_docs_and_editions.begin (); it != vector_docs_and_editions.end (); it++) {
				long id = *it;
				docs_and_editions.Collection::Add (&id);
			}

			int i;
			for (i = 0; i < docs_and_editions.ItemCount; i++) {
				std::deque<u_int64_t> blocks_in_doc;

				long id = docs_and_editions [i], sub_count;
				u_int64_t ref = ((u_int64_t)id) << 32;
				blocks_in_doc.push_back (ref);
				SubDesc *subs = (SubDesc*) base->LoadAttr (id, IDD_SUBS, sub_count), *sub_ptr = subs;
				sub_count /= sizeof (SubDesc);
				for (int i = 0; i < sub_count; i++, sub_ptr++) {					
					ref = (((u_int64_t)id) << 32) + sub_ptr->Sub;
					blocks_in_doc.push_back (ref);
				}
				gk_free (subs);
				std::sort (blocks_in_doc.begin (), blocks_in_doc.end ());
				for (std::deque<u_int64_t>::const_iterator it = blocks_in_doc.begin (); it != blocks_in_doc.end (); it++)
					blocks_in_docs.push_back (*it);
			}
			//std::sort (blocks_in_docs.begin (), blocks_in_docs.end ());
		}

		base->close_saw_bases ();
		delete base;

		//итого, из всех документов.сабов надо оставлять только те, которых входят в blocks_in_docs
		for (int i = 2; i < argc; i++) {
			FILE *part_file = fopen (argv [i], "rt");
			long seg = 0;
			while (!feof (part_file)) {
				char str [1024]; str [0] = '\0';
				fgets (str, sizeof (str), part_file);

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				if (*(long*)&str == 979854707) {
					//seg:
					seg = atol (str+5);
				} else {
					long doc, sub;
					u_int64_t mask;
					doc = atol (str);
					sub = atol (strchr (str, '.') + 1);
					mask = _atoi64 (strchr (str, ':') + 1);

					u_int64_t ref = (((u_int64_t)doc) << 32) + sub;

					if (heres.find (seg) != heres.end ()) {
						if (!std::binary_search (blocks_in_docs.begin (), blocks_in_docs.end (), ref))
							continue;

						std::map<u_int64_t,map_seg_mask>::iterator it = data.find (ref);
						if (it == data.end ()) {
							map_seg_mask empty_map;
							empty_map.insert (map_seg_mask::value_type (seg, mask));
							data.insert (std::map<u_int64_t,map_seg_mask>::value_type (ref, empty_map));
						} else {
							//такой документ в мапе уже есть
							map_seg_mask *map_seg_mask_ptr = &it->second;
							map_seg_mask::iterator map_it = map_seg_mask_ptr->find (seg);
							if (map_it == map_seg_mask_ptr->end ()) {
								//такого сегмента нет
								map_seg_mask_ptr->insert (map_seg_mask::value_type (seg, mask));
							} else {
								//такой сегмент есть, надо сложить маски
								map_it->second |= mask;
							}
						}
					}
				}
			}
			fclose (part_file);
		}
	}

	for (std::map<u_int64_t,map_seg_mask>::const_iterator it = data.begin (); it != data.end (); it++) {
		printf ("%ld.%ld:", (long)(it->first >> 32), (long)(it->first & 0xFFFFFFFF));
		const map_seg_mask *map_seg_mask_ptr = &it->second;
		for (map_seg_mask::const_iterator map_it = map_seg_mask_ptr->begin (); map_it != map_seg_mask_ptr->end (); map_it++)
			printf (" %ld.%lld", map_it->first, map_it->second);
		printf ("\n");
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
