#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "SearchB.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

#include <boost/thread.hpp>

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

DocCollection *alldocs;

u_int64_t **lemmas_ptrs;
long *lemmas_in_docs, *ptrs_count;
std::vector<long> vector_docsize;

bool	is_same (long doc1, long doc2, long same_value)
{
	long dist1 = alldocs->IndexOf (&doc1), size1 = vector_docsize [dist1];
	long dist2 = alldocs->IndexOf (&doc2), size2 = vector_docsize [dist2];
	//printf ("is_same: doc1 = %ld, doc2 = %ld, dist1 = %ld, dist2 = %ld, size1 = %ld, size2 = %ld\n", doc1, doc2, dist1, dist2, size1, size2);
	if ((std::min <long> (size1, size2) * 100) / std::max<long> (size1, size2) >= same_value) {
		long count1 = lemmas_in_docs [dist1], count2 = lemmas_in_docs [dist2];
		if (count1 == 0 || count2 == 0) {
			//printf ("is_same: count 0, return false\n");
			return false;
		}
		long common_lemmas = 0, noncommon_lemmas = 0, total_lemmas = 0, in1 = 0, in2 = 0;
		u_int64_t *ptrs1 = lemmas_ptrs [dist1], *ptrs2 = lemmas_ptrs [dist2];
		//printf ("is_same: calculate lemmas\n");
		for (; in1 < count1 && in2 < count2; ) {
			u_int64_t at1 = ptrs1 [in1], at2 = ptrs2 [in2];
			if (at1 >> 32 == at2 >> 32) {
				long count1 = (long) (at1 & 0xFFFFFFFF), count2 = (long) (at2 & 0xFFFFFFFF);
				if ((std::min <long> (count1, count2) * 100) / std::max<long> (1, std::max<long> (count1, count2)) > 94)
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
		for (; in1 < count1; in1++) noncommon_lemmas++, total_lemmas++;
		for (; in2 < count2; in2++) noncommon_lemmas++, total_lemmas++;
		//printf ("is_same: total: %ld, common: %ld, noncommon: %ld\n", total_lemmas, common_lemmas, noncommon_lemmas);
		if (total_lemmas && ((common_lemmas * 100) / total_lemmas >= same_value) && ((noncommon_lemmas * 100) / total_lemmas <= (100 - same_value))) {
			//printf ("return true\n");
			return true;
		}
	}
	//printf ("return false\n");
	return false;
}

struct thread_data_struct {
	volatile long done;
	SearchBase *base;
};

#define	MAX_POOL	16
long same_value = 95;

thread_data_struct thread_data [MAX_POOL];
std::vector<HIndex::HIndexKey*> adopteds;
std::vector<HIndex::HIndexKey*>::const_iterator adopteds_it;
Core::Mutex adopted_mutex;

HIndex::HIndexKey *get_adopted (bool next)
{
	GUARD (adopted_mutex);
	HIndex::HIndexKey *result = 0;
	if (adopteds_it != adopteds.end ()) {
		result = *adopteds_it;
		if (next)
			adopteds_it++;
	}
	return result;
}

void	do_adopteds (long &this_thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	SearchBase *base = thread_data_ptr->base;
	Index* index = base->FindIndex ("Adopted");
	while (true) {
		HIndex::HIndexKey *key = get_adopted (true);
		if (!key)
			break;

		Stream* str = index->Index::keyOpen (key, 0);
		if (0 == str)
			continue;
		printf ("%ld %s\n", key->id, key->text); fflush (stdout);
		DocCollection docs;
		docs.Get (str);
		index->Close (str);

		docs.Intersect (*alldocs);
		if (0 == docs.ItemCount)
			continue;

		for (int i = 0; i < docs.ItemCount - 1; i++) {
			long doc1 = docs [i];
			//if (doc1 != 123423308 && doc1 != 124410813 && doc1 != 124410817)
			//	continue;
			for (int j = i + 1; j < docs.ItemCount; j++) {
				long doc2 = docs [j];
				//if (doc2 != 124516356 && doc2 != 124516947 && doc2 != 124516824)
				//	continue;
				if (is_same (doc1, doc2, same_value)) {
					long codesize1, codesize2;
					char* idd_codes1 = (char*) base->LoadAttr (doc1, IDD_ID, codesize1);
					char* idd_codes2 = (char*) base->LoadAttr (doc2, IDD_ID, codesize2);
					std::set<std::string> codes1, codes2;
					char* ptr = idd_codes1;
					if (codesize1) {
							while (ptr - idd_codes1 < codesize1) {
							codes1.insert (ptr);
							ptr += strlen (ptr) + 1;
						}
						gk_free (idd_codes1);
					}
					if (codesize2) {
						ptr = idd_codes2;
						while (ptr - idd_codes2 < codesize2) {
							codes2.insert (ptr);
							ptr += strlen (ptr) + 1;
						}
						gk_free (idd_codes2);
					}
					if (codesize1 && codesize2) {
						//у обоих есть CODE
						std::vector<std::string> same_codes;
						std::set_intersection (codes1.begin (), codes1.end (), codes2.begin (), codes2.end (), std::back_inserter (same_codes));
						if (same_codes.size ()) {
							//есть совпадающие номера
							long datesize1, datesize2;
							char* idd_dates1 = (char*) base->LoadAttr (doc1, IDD_DATE, datesize1);
							char* idd_dates2 = (char*) base->LoadAttr (doc2, IDD_DATE, datesize2);

							if (datesize1 && datesize2) {
								//у обоих есть DATE
								if (!memcmp (idd_dates1, idd_dates2, std::min<long> (datesize1, datesize2))) {
									//совпадают date
									printf ("3: %ld %ld\n", std::min<long> (doc1, doc2), std::max<long> (doc1, doc2));
								} else {
									//разные date
									printf ("4: %ld %ld\n", std::min<long> (doc1, doc2), std::max<long> (doc1, doc2));
								}
							} else {
								//у кого-то нет date
								printf ("5: %ld %ld\n", datesize1 ? doc1 : doc2, datesize1 ? doc2 : doc1);
							}

							if (idd_dates1) gk_free (idd_dates1);
							if (idd_dates2) gk_free (idd_dates2);
						} else {
							//ничего не выводим
						}
					} else {
						if (codesize1 + codesize2 == 0) {
							//у обоих нет CODE
							long datesize1, datesize2;
							char* idd_dates1 = (char*) base->LoadAttr (doc1, IDD_DATE, datesize1);
							char* idd_dates2 = (char*) base->LoadAttr (doc2, IDD_DATE, datesize2);
							if (datesize1 && datesize2 && !memcmp (idd_dates1, idd_dates2, std::min<long> (datesize1, datesize2))) {
								//совпадают date
								printf ("2: %ld %ld\n", std::min<long> (doc1, doc2), std::max<long> (doc1, doc2));
							} else if (datesize1) {						
								printf ("6: %ld %ld\n", doc1, doc2);
							} else if (datesize2) {
								printf ("6: %ld %ld\n", doc2, doc1);
							} else {
								printf ("6: %ld %ld\n", std::min<long> (doc1, doc2), std::max<long> (doc1, doc2));
							}
							if (idd_dates1) gk_free (idd_dates1);
							if (idd_dates2) gk_free (idd_dates2);
						} else {
							long datesize1, datesize2;
							char* idd_dates1 = (char*) base->LoadAttr (doc1, IDD_DATE, datesize1);
							char* idd_dates2 = (char*) base->LoadAttr (doc2, IDD_DATE, datesize2);
							if (datesize1 && datesize2 && !memcmp (idd_dates1, idd_dates2, std::min<long> (datesize1, datesize2))) {
								//совпадают date
								printf ("1: %ld %ld\n", codesize1 ? doc1 : doc2, codesize1 ? doc2 : doc1);
							} else if (datesize1 + datesize2 == 0) {
								printf ("6: %ld %ld\n", codesize1 ? doc1 : doc2, codesize1 ? doc2 : doc1);
							} else if (datesize1) {
								printf ("6: %ld %ld\n", doc1, doc2);
							} else {
								printf ("6: %ld %ld\n", doc2, doc1);
							}
							if (idd_dates1) gk_free (idd_dates1);
							if (idd_dates2) gk_free (idd_dates2);
						}
					}
				}
			}
		}
	}

	InterlockedIncrement (&thread_data_ptr->done);
}

int main_logic ( int argc, char *argv[] )
{
	if (!argv [1])
		return 0;

	if (argc > 2 && argv [2]) {
		same_value = std::max <long> (1, std::min <long> (100, atol (argv [2])));
		printf ("same_value is %ld\n", same_value);
	}

	SearchBase* base = new SearchBase (argv [1]);
	base->IsOk (); base->FindIndex ("Attrs"); delete base->AllDocs ();
	if (argc == 5) {
		alldocs = new DocCollection;
		Index *index = base->FindIndex ("Adopted");
		long part = atol (argv [4]), apart = 0;
		for (BTIterator it (index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			if (!key->chCount) {
				if ((++apart % 4) == part) {
					Stream* str = index->Index::keyOpen (key, 0);
					if (0 == str)
						continue;
					DocCollection docs;
					docs.Get (str);
					index->Close (str);
					alldocs->Merge (docs);
				}
			}
		}
		printf ("partial: %ld\n", alldocs->ItemCount);
	} else {
		alldocs = new DocCollection;
		Index *index = base->FindIndex ("Adopted");
		for (BTIterator it (index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			if (!key->chCount) {
				Stream* str = index->Index::keyOpen (key, 0);
				if (0 == str)
					continue;
				DocCollection docs;
				docs.Get (str);
				index->Close (str);
				alldocs->Merge (docs);
			}
		}
		printf ("adopteds: %ld\n", alldocs->ItemCount);

		delete alldocs;
		alldocs = base->AllDocs ();
		printf ("alldocs: %ld\n", alldocs->ItemCount);
	}

	{
		vector_docsize.reserve (alldocs->ItemCount);
		AttrKey key = {(*alldocs)[0], IDD_INFO};
		Index* attrs_index = base->FindIndex ("Attrs");
		for (BTIterator it (attrs_index, &key); !it.End (); ++it) {
			AttrKey *attr_key = (AttrKey*) it.Key ();
			if (attr_key->AttrTag != IDD_INFO)
				break;
			long id = attr_key->DocId;

			if (alldocs->IndexOf (&id) == -1)
				continue;

			//if (id != 123423308 && id != 124410813 && id != 124410817 && id != 124516356 && id != 124516824 && id != 124516947) {
			//	vector_docsize.push_back (0);
			//	continue;
			//}

			Stream *str = attrs_index->Open (attr_key);
			if (str) {
				DocInfo docinfo;
				str->Read (&docinfo, sizeof (docinfo));
				attrs_index->Close (str);
				vector_docsize.push_back (docinfo.Size);
			}
		}
	}

	Index* index = base->FindIndex ("NWCntxt");

	{
		lemmas_in_docs = new long [alldocs->ItemCount];
		ptrs_count = new long [alldocs->ItemCount];
		lemmas_ptrs = new u_int64_t* [alldocs->ItemCount];
		long counter = 0;
		for (std::vector<long>::const_iterator it_size = vector_docsize.begin (); counter < alldocs->ItemCount; counter++, it_size++) {
			lemmas_in_docs [counter] = 0;
			long size = std::max<long> (1, *it_size / 64);
			ptrs_count [counter] = size;
			lemmas_ptrs [counter] = (u_int64_t*) malloc (size * sizeof (u_int64_t));
		}
	}

	{
	long lemma = 0;	
	for (BTIterator btit (index); !btit.End (); ++btit, lemma++) {
		const char* key = (const char*)btit.Key ();
		if (key[0] & 0x80)
			break;
		Stream *str0 = index->Open (key), *str1 = index->OpenN (key, 1), *str2 = index->OpenN (key, 2);
		if (str0) {
/*
			char qqq [64];
			strcpy (qqq, key+1);
			Recoding (cd_win, cd_dos, qqq);
			printf ("%s\r", qqq);
*/

			DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

			DBCore::Ref_ ref = {0,0,0};
			DBCore::ExtrPair extr;
			long dist = 0, page = 0, inpagecount = 0, maxinpage = alldocs->Count [page], *id_ptr = (long*) alldocs->Pages [page];

			while (str_reader->get_next (ref, 0)) {
				long id = ref.doc_id;
				//if (id != 123423308 && id != 124410813 && id != 124410817 && id != 124516356 && id != 124516824 && id != 124516947)
				//	continue;
				while (id_ptr && *id_ptr < id) {
					if (inpagecount < maxinpage - 1) {
						dist++;
						inpagecount++;
						id_ptr++;
					} else if (page < alldocs->PageCount) {
						page++;
						maxinpage = alldocs->Count [page];
						id_ptr = (long*) alldocs->Pages [page];
						inpagecount = 0;
						dist++;
					} else {
						id_ptr = 0;
					}
				}

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
				if (count_in_doc && id_ptr && *id_ptr == id) {
					long in_docs = lemmas_in_docs [dist], old_count = ptrs_count [dist];
					u_int64_t* data = lemmas_ptrs [dist];
					if (in_docs == old_count - 1) {
						old_count <<= 1;
						data = (u_int64_t*) realloc (data, (old_count) * sizeof (u_int64_t));
						lemmas_ptrs [dist] = data;
						ptrs_count [dist] = old_count;
					}
					data [in_docs] = ((u_int64_t)lemma << 32) + count_in_doc;
					in_docs++;
					lemmas_in_docs [dist] = in_docs;
				}
			}

			index->Close (str2);
			index->Close (str1);
			index->Close (str0);
		}
	}
	}

	index = base->FindIndex ("Adopted");
	for (BTIterator it (index); !it.End (); ++it) {
		HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
		if (!key->chCount) {
			HIndex::HIndexKey* dup = (HIndex::HIndexKey*) malloc (index->KeyLength);
			memcpy (dup, key, index->KeyLength);
			adopteds.push_back (dup);
		}
	}
	adopteds_it = adopteds.begin ();

	long thr, threads_count = std::max <long> (1, std::min <long> (MAX_POOL, (argc >= 4 ? atol (argv [3]) : 6))), ok_threads = 0;
	printf ("run %ld threads\n", threads_count);
	for (thr = 0; thr < threads_count; thr++) {
		thread_data [thr].base = new SearchBase (argv [1]);
		thread_data [thr].base->IsOk ();
		thread_data [thr].base->FindIndex ("Attrs");
		delete thread_data [thr].base->AllDocs ();			
		thread_data [thr].done = 0;
		boost::thread thread (do_adopteds, thr);
		thread.detach ();
		ok_threads++;
		ACE_OS::sleep (1);
	}
	bool b_timeout = false;
	for (;;) {
		HIndex::HIndexKey *key = get_adopted (false);
		if (key) {
			ACE_OS::sleep (5);
		} else {
			int dones = 0;
			for (thr = 0; thr < threads_count; thr++)
				if (InterlockedCompareExchange (&thread_data [thr].done, 0, 0))
					dones++;
			if (dones == ok_threads)
				break;
		}
	}

	return 0;
}
