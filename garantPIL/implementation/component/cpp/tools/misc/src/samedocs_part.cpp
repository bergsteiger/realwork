#include "shared/Core/fix/mpcxc.h"
#include "ace/OS.h"
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

typedef std::vector<long> docs_vector;

void localrev_adddays (revision& theRev, const int days) 
{ 
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = theRev.RevisionDate.da_year - 1900; 
	atm.tm_mday = theRev.RevisionDate.da_day; 
	atm.tm_mon  = theRev.RevisionDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)days * 24l * 3600l; 
	ptm   = localtime( &atime ); 
	theRev.RevisionDate.da_year = ptm -> tm_year + 1900; 
	theRev.RevisionDate.da_day = ptm -> tm_mday; 
	theRev.RevisionDate.da_mon = ptm -> tm_mon + 1;	 
} 

int compare_DocRele (const void *l1, const void *l2)
{
	DocRele *at1 = (DocRele*) l1;
	DocRele *at2 = (DocRele*) l2;
	if (at1->Rele < at2->Rele) return 1;
	if (at1->Rele > at2->Rele) return -1;
	if (at1->DocId > at2->DocId) return 1;
	if (at1->DocId < at2->DocId) return -1;
	return 0;
}

int main_logic ( int argc, char *argv[] )
{
	if (argc < 3)
		return 0;

	Base* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	Ref same_ref;
	char *str = new char [64 * 1024 * 1024], ref_str [32];
	std::vector<u_int64_t> same_refs;

	if (!stricmp (argv [2], "vincluded")) {
		Index *attrs = base->FindIndex ("Attrs"), *dates = base->FindIndex ("VIncluded");
		AttrKey included_key = {0, IDD_VINCLUDED};
		date	included_date;

		for (int i = 3; i < argc; i++) {
			FILE* part_file = mpcxc_fopen (argv [i], "rt");
			if (part_file) {
				while (!feof (part_file)) {
					if (!fgets (str, 64 * 1024 * 1024, part_file))
						break;

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length)
						continue;

					long doc_id_i = atol (str);

					included_key.DocId = doc_id_i;
					Stream *str = attrs->Open (&included_key);
					if (str) {
						str->Read (&included_date, sizeof (date));
						attrs->Close (str);
						revision rev;
						gk_bzero (&rev, sizeof (rev));
						rev.RevisionDate = included_date;
						localrev_adddays (rev, 9*7);
						base->ReplaceAttr (doc_id_i, IDD_VINCLUDED, &rev.RevisionDate, sizeof (date));
						str = dates->Index::OpenN (&included_date, 0);
						if (str) {
							DocCollection docs;
							docs.Get (str);
							long item = docs.IndexOf (&doc_id_i);
							if (item != -1) {
								docs.atDelete (item);
								str->Seek (0);
								docs.Put (str);
								str->Trunc ();
							}
							dates->Close (str);
							if (!docs.ItemCount) {
								dates->Delete (&included_date);
							}
						}
						str = dates->Index::OpenN (&rev.RevisionDate, 0);
						if (str) {
							DocCollection docs;
							docs.Get (str);
							docs.Insert (&doc_id_i);
							str->Seek (0);
							docs.Put (str);
							str->Trunc ();
							dates->Close (str);
						}
					}
				}
			}
		}
		exit (EXIT_SUCCESS);
	}

	std::set<long> processed_ids;
	bool b_delete = false, b_nocheck = false;
	for (int i = 2; i < argc; i++) {
		if (!strcmp (argv [i], "-delete")) {
			b_delete = true;
			continue;
		}
		if (!strcmp (argv [i], "-nocheck")) {
			b_nocheck = true;
			continue;
		}

		FILE* part_file = mpcxc_fopen (argv [i], "rt");
		if (part_file) {
			while (!feof (part_file)) {
				if (!fgets (str, 64 * 1024 * 1024, part_file))
					break;

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				char* delimiter = strchr (str, ':');
				strncpy (ref_str, str, delimiter - str);
				ref_str [delimiter - str] = 0;
				long id = atol (str), size = 0;

				printf ("%ld\r", id);

				DocInfo docinfo;
				if (b_nocheck || base->FindDocInfo (id, docinfo) == sizeof (docinfo)) {
					processed_ids.insert (id);
					std::set<long> _same_docs;
					same_refs.clear ();
					for (char* ptr = delimiter+2; *ptr; ) {
						same_ref.DocId = atol (ptr);
						same_ref.Sub = atol (strchr (ptr, '.') + 1);
						if (_same_docs.find (same_ref.DocId) == _same_docs.end ()) {
							_same_docs.insert (same_ref.DocId);
							u_int64_t to_put = (((u_int64_t)same_ref.DocId) << 16) + same_ref.Sub;
							same_refs.push_back (to_put);
						}
						char* next_ptr = strchr (ptr, ' ');
						if (!next_ptr)
							break;
						ptr = next_ptr + 1;
					}
					DocRele *to_write = (DocRele*) malloc (same_refs.size () * sizeof (DocRele)), *ptr = to_write;
					std::set<long> now_docs;
					for (std::vector<u_int64_t>::const_iterator it = same_refs.begin (); it != same_refs.end (); it++, ptr++, size += sizeof (DocRele)) {
						u_int64_t at_it = *it;
						ptr->DocId = (long)(at_it >> 16);
						ptr->Rele = (short) (at_it & 0xffff);
						now_docs.insert (ptr->DocId);
					}

					bool replace = true;
					/*
					этот код объедин€ет те данные, которые уже прописаны в базу, с теми, которые собираютс€ прописать
					long was_size;
					DocRele* was = (DocRele*) base->LoadAttr (id, IDD_SAMEDOCS, was_size);
					if (was_size) {
						was_size /= sizeof (DocRele); ptr = was;
						std::set<long> was_docs;
						for (int sames = 0; sames < was_size; sames++, ptr++)
							was_docs.insert (ptr->DocId);

						if (was_docs == now_docs && was_size == was_docs.size ()) {
							replace = false;
						} else {
							std::set<short> cos_set;
							std::map<short, docs_vector> map_cos;
							std::set<long> processed_docs;

							ptr = was;
							for (int docs = 0; docs < was_size; docs++, ptr++ ) {
								short long_cos = ptr->Rele;
								long this_id = ptr->DocId;
								if (processed_docs.find (this_id) == processed_docs.end ()) {
									processed_docs.insert (this_id);
									cos_set.insert (long_cos);
									std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
									map_cos_iter->second.push_back (this_id);
								}
							}

							for (std::vector<u_int64_t>::const_iterator it = same_refs.begin (); it != same_refs.end (); it++, ptr++, size += sizeof (DocRele)) {
								u_int64_t at_it = *it;
								long this_id = (long)(at_it >> 16);
								if (processed_docs.find (this_id) == processed_docs.end ()) {
									processed_docs.insert (this_id);
									short long_cos = (short) (at_it & 0xffff);
									cos_set.insert (long_cos);
									std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
									map_cos_iter->second.push_back (this_id);
								}
							}

							std::vector<DocRele> same_docs;
							for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
								short long_cos = *cos_set_it;
								if (long_cos < 2900 || same_docs.size () == 100)
									break;
								std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
								for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
									DocRele doc_rele = {*docs_iter, long_cos};
									same_docs.push_back (doc_rele);
									if (same_docs.size () == 100)
										break;
								}
							}

							gk_free (to_write);
							to_write = (DocRele*) malloc (same_docs.size () * sizeof (DocRele)), ptr = to_write;
							size = 0;
							for (std::vector<DocRele>::const_iterator it = same_docs.begin (); it != same_docs.end (); it++, ptr++, size += sizeof (DocRele)) {
								ptr->DocId = it->DocId;
								ptr->Rele = it->Rele;
							}
						}
						gk_free (was);
					}
					*/
					if (replace) {
						if (size) {
							qsort (to_write, size / sizeof (DocRele), sizeof (DocRele), compare_DocRele);
							base->ReplaceAttr (id, IDD_SAMEDOCS, to_write, size);
						} else
							base->DelAttr (id, IDD_SAMEDOCS);
					}
					gk_free (to_write);
				}
			}
			fclose (part_file);
		}
	}
	printf ("\n");

	if (b_delete) {
		std::set<long> docs_to_delete;
		Index* attrs = base->FindIndex ("Attrs");
		AttrKey attrkey = {ID_BORDER, IDD_SAMEDOCS};
		for (BTIterator it (attrs, &attrkey); !it.End (); ++it) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_SAMEDOCS)
				break;
			if (processed_ids.find (key->DocId) == processed_ids.end ())
				docs_to_delete.insert (key->DocId);
		}
		for (std::set<long>::const_iterator set_it = docs_to_delete.begin (); set_it != docs_to_delete.end (); set_it++) {
			printf ("delete IDD_SAMEDOCS for %ld\r", *set_it);
			base->DelAttr (*set_it, IDD_SAMEDOCS);
		}
		printf ("\n");
	}

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
