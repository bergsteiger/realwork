#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"
#include "StorableSplaySet.h"

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

struct	CorrStruct {
	long	uid;
	u_int64_t	mask;
	RefCollection*	refs;
};

CorrStruct	CorrKinds [64];
long	CorrKinds_size = 0;

int main_logic ( int argc, char *argv[] )
{
	if (argc != 4)
		return 0;

	std::map<long,DocCollection*> map_segment_docs;
	if (!stricmp (argv [2], "kindcorr_chg")) {
		ToolsBase *tbase = new ToolsBase (argv [1]);
		Index *segment_index = tbase->FindIndex ("Segment");
		for (int i = 1; i < 401; i++) {
			Stream *str = segment_index->Open (&i);
			if (str) {
				DocCollection *docs = new DocCollection;
				docs->Get (str);
				segment_index->Close (str);
				map_segment_docs.insert (std::map<long,DocCollection*>::value_type (i, docs));
			}
		}

		HIndex *index_kind = (HIndex*) tbase->FindIndex ("Kind");
		char full_key [1024];
		for (BTIterator it (index_kind); !it.End (); ++it) {
			HIndex::HIndexKey *k = (HIndex::HIndexKey*) it.Key ();

			if (k->level == 0) {
				Stream *str = index_kind->Index::OpenN (k,0);
				if (str) {
					RefCollection refs;
					refs.Get (str);
					index_kind->Close (str);
				}
			}

			if (k->chCount)
				continue;
			
			index_kind->FullName (k, full_key);
			long uid = tbase->kind_key_to_uid (full_key);
			if (!uid)
				continue;

			u_int64_t mask = tbase->kind_uid_to_bit (uid);
			if (!mask)
				continue;
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
		delete tbase;
	}

	StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	base->IsOk ();

	FILE *in_file = fopen (argv [3], "rt");

	char in_str [128];
	if (!stricmp (argv [2], "newcorr_chg")) {
		long id = 0;
		StorableSplaySet<CorrRef> *refs;
		Index *index = base->FindIndex ("NewCorr");

		while (!feof (in_file)) {
			if (!fgets (in_str, sizeof (in_str), in_file))
				break;

			int length = strlen (in_str);
			while (length && (in_str [length-1] == 10 || in_str [length-1] == 13))
				in_str [--length] = 0;

			if (!length)
				continue;

			if (in_str [0] == ':') {
				printf ("write data for %ld, size: %ld\n", id, refs->length ());
				Stream *str = index->Open (&id, 1);
				if (str) {
					refs->Put (str);
					str->Trunc ();
					index->Close (str);
				}
				delete refs;
			} else if (in_str [length-1] == ':') {
				id = atol (in_str);
				printf ("read data for %ld\n", id);
				refs = new StorableSplaySet <CorrRef>;
			} else {
				CorrRef ref;
				sscanf (in_str, "%ld.%ld.%ld.%ld.%ld", &ref.Sub, &ref.DocId, &ref.Para, &ref.RealPara, &ref.Block);
				refs->add (ref);
			}
		}
	} if (!stricmp (argv [2], "newcorr_del")) {
		Index *index = base->FindIndex ("NewCorr");
		long id = 0;
		StorableSplaySet<CorrRef> *refs;
		std::set<long> deleted;
		while (!feof (in_file)) {
			if (!fgets (in_str, sizeof (in_str), in_file))
				break;

			int length = strlen (in_str);
			while (length && (in_str [length-1] == 10 || in_str [length-1] == 13))
				in_str [--length] = 0;

			if (!length)
				continue;

			if (in_str [0] == ':') {
				printf ("write data for %ld\n", id);
				Stream *str = index->Open (&id, 1);
				if (str) {
					for (Point p = refs->first (); p; refs->next (p)) {
						CorrRef atp = refs->contents (p);
						if (deleted.find (atp.DocId) == deleted.end ())
							str->Write (&atp, sizeof (atp));
					}
					if (str->Tell () == 0) {
						index->Close (str);
						index->Delete (&id);
					} else {
						str->Trunc ();
						index->Close (str);
					}
				}
				deleted.clear ();
				delete refs;
			} else if (in_str [length-1] == ':') {
				id = atol (in_str);
				printf ("read data for %ld\n", id);
				refs = new StorableSplaySet <CorrRef>;
				Stream *str = index->Open (&id);
				if (str) {
					refs->Get (str);
					index->Close (str);
				}
			} else {
				deleted.insert (atol (in_str));
			}
		}
	} else if (!stricmp (argv [2], "docinfo_chg")) {
		while (!feof (in_file)) {
			if (!fgets (in_str, sizeof (in_str), in_file))
				break;

			int length = strlen (in_str);
			while (length && (in_str [length-1] == 10 || in_str [length-1] == 13))
				in_str [--length] = 0;

			if (!length)
				continue;

			long id;
			u_int64_t mask;
			sscanf (in_str, "%ld:%lld", &id, &mask);
			DocInfo docinfo;
			if (base->FindDocInfo (id, docinfo) == sizeof (DocInfo)) {
				printf ("replace mask for %ld\n", id);
				docinfo.hi_long_respondents = (long) ((mask >> 32) & 0xFFFFFFFF);
				docinfo.long_respondents = (long) (mask & 0xFFFFFFFF);
				base->ReplaceAttr (id, IDD_INFO, &docinfo, sizeof (docinfo));
			}
		}
	} else if (!stricmp (argv [2], "kindcorr_chg")) {
		std::vector<long> kindcorr_docs;
		while (!feof (in_file)) {
			if (!fgets (in_str, sizeof (in_str), in_file))
				break;

			int length = strlen (in_str);
			while (length && (in_str [length-1] == 10 || in_str [length-1] == 13))
				in_str [--length] = 0;

			if (!length)
				continue;

			long id = atol (in_str);
			if (id)
				kindcorr_docs.push_back (id);
		}

		Index *newcorrs_index = base->FindIndex ("NewCorr"), *kindcorr_index = base->FindIndex ("KindCorr");
		KindCorrRef towrite [1024];
		gk_bzero (towrite, sizeof (towrite));

		for (std::vector<long>::const_iterator it = kindcorr_docs.begin (); it != kindcorr_docs.end (); it++) {
			long id = *it;

			Stream* str = newcorrs_index->Open (&id);
			if (str) {
				printf ("%ld\r", id);
				int all_count = str->Length () / sizeof (CorrRef), corrrefs_count = 0;

				CorrRef buffer [1024];
				std::map<long,RefCollection*> map_sub_refs;
				while (all_count) {
					long count = str->Read (buffer, sizeof (buffer)) / sizeof (CorrRef);
					all_count -= count;
					CorrRef *ptr = buffer;
					for (int i = 0; i < count; i++, ptr++) {
						Ref at_i = {ptr->DocId, ptr->Block};
						std::map<long,RefCollection*>::iterator map_it = map_sub_refs.find (ptr->Sub);
						if (map_it == map_sub_refs.end ()) {
							RefCollection *refs = new RefCollection;
							refs->Insert (&at_i);
							map_sub_refs.insert (std::map<long,RefCollection*>::value_type (ptr->Sub, refs));
						} else {
							map_it->second->Insert (&at_i);
						}
					}
				}
				newcorrs_index->Close (str);

				for (std::map<long,RefCollection*>::iterator subs_it = map_sub_refs.begin (); subs_it != map_sub_refs.end (); subs_it++) {
					std::map<long,u_int64_t> map_segment_mask;
					for (int corrs = 0; corrs < CorrKinds_size; corrs++) {
						RefCollection *refs = new RefCollection (*subs_it->second);
						refs->Intersect (CorrKinds [corrs].refs);
						if (refs->ItemCount) {
							for (std::map<long,DocCollection*>::const_iterator seg_it = map_segment_docs.begin (); seg_it != map_segment_docs.end (); seg_it++) {
								if (refs->IsSect (*seg_it->second)) {
									std::map<long,u_int64_t>::iterator res_it = map_segment_mask.find (seg_it->first);
									if (res_it == map_segment_mask.end ()) {
										map_segment_mask.insert (std::map<long,u_int64_t>::value_type (seg_it->first, CorrKinds [corrs].mask));
									} else {
										res_it->second |= CorrKinds [corrs].mask;
									}
								}
							}
						}
						delete refs;
					}
					delete subs_it->second;

					KindCorrRef* ptr = towrite;
					long size = 0;
					for (std::map<long,u_int64_t>::const_iterator map_mask_it = map_segment_mask.begin (); map_mask_it != map_segment_mask.end (); map_mask_it++, ptr++, size += sizeof (*ptr)) {
						ptr->seg = (short) (map_mask_it->first & 0xFFFF);
						ptr->mask = map_mask_it->second;
					}

					if (size) {
						Ref ref = {id, subs_it->first};

						str = kindcorr_index->Open (&ref, 1);
						if (str) {
							str->Write (towrite, size);
							kindcorr_index->Close (str);
						}
					}
				}
				map_sub_refs.clear ();
			}
		}
	}

	fclose (in_file);
	delete base;

	return 0;
}
