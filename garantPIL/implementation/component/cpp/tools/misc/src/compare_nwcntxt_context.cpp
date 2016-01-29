#include "shared/Core/fix/mpcxc.h"

#include "SearchB.h"
#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"
#include "collection_iterator.h"

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

int main_logic ( int argc, char *argv[] )
{
	ToolsBase *base1 = new ToolsBase (argv [1]);
	ToolsBase *base2 = new ToolsBase (argv [2]);
	Index *indexs = base1->FindIndex ("Context.str");

	std::vector<long> changed_docs;
	{
		BTIterator indexs_it (indexs);
		if (!indexs_it.End()) {
			Stream *str = indexs->keyOpen (indexs_it.Key (), 1);
			if (str) {
				changed_docs.resize (str->Length () / sizeof (long));
				str->Read (&changed_docs[0], str->Length ());
				indexs->Close (str);
			}
		}
	}

	{
	printf ("compare NWCntxt\n");

	Index *index1 = base1->FindIndex ("NWCntxt");
	Index *index2 = base2->FindIndex ("NWCntxt");

	for (BTIterator it (index1); !it.End (); it++) {
		char* key = (char*) it.Key ();

		std::map<long,DBCore::ULongVector> map_doc_positions_1, map_doc_positions_s, map_doc_positions_2;

		Stream *str0 = index1->Open (key), *str1 = index1->OpenN (key, 1), *str2 = index1->OpenN (key, 2);
		if (str0) {
			DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

			DBCore::Ref_ ref = {0,0,0};
			DBCore::ExtrPair extr;

			while (str_reader->get_next (ref, 0)) {
				long id = ref.doc_id;
				if (!std::binary_search (changed_docs.begin (), changed_docs.end (), id)) {
					DBCore::ULongVector positions;
					pos_reader->get (positions, ref, extr);
					map_doc_positions_1.insert (std::map<long,DBCore::ULongVector>::value_type (id, positions));
				}
			}

			index1->Close (str2);
			index1->Close (str1);
			index1->Close (str0);
		}

		if (indexs->IsExist (key)) {
			Stream *str0 = indexs->Open (key), *str1 = indexs->OpenN (key, 1), *str2 = indexs->OpenN (key, 2);
			if (str0) {
				DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
				DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

				DBCore::Ref_ ref = {0,0,0};
				DBCore::ExtrPair extr;

				while (str_reader->get_next (ref, 0)) {
					long id = ref.doc_id;
					DBCore::ULongVector positions;
					pos_reader->get (positions, ref, extr);
					map_doc_positions_s.insert (std::map<long,DBCore::ULongVector>::value_type (id, positions));
				}

				indexs->Close (str2);
				indexs->Close (str1);
				indexs->Close (str0);
			}
		}

		map_doc_positions_s.insert (map_doc_positions_1.begin (), map_doc_positions_1.end ());

		if (index2->IsExist (key)) {
			Stream *str0 = index2->Open (key), *str1 = index2->OpenN (key, 1), *str2 = index2->OpenN (key, 2);
			if (str0) {
				DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
				DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

				DBCore::Ref_ ref = {0,0,0};
				DBCore::ExtrPair extr;

				while (str_reader->get_next (ref, 0)) {
					long id = ref.doc_id;
					DBCore::ULongVector positions;
					pos_reader->get (positions, ref, extr);
					map_doc_positions_2.insert (std::map<long,DBCore::ULongVector>::value_type (id, positions));
				}

				index2->Close (str2);
				index2->Close (str1);
				index2->Close (str0);
			}
		}

		std::map<long,DBCore::ULongVector>::const_iterator it_s = map_doc_positions_s.begin ();
		std::map<long,DBCore::ULongVector>::const_iterator it_2 = map_doc_positions_2.begin ();
		while (it_s != map_doc_positions_s.end () && it_2 != map_doc_positions_2.end ()) {
			if (it_s->first < it_2->first) {
				printf ("%s: %ld in base1, not in base2\n", key + 1, it_s->first);
				it_s++;
			} else if (it_s->first == it_2->first) {
				if (it_s->second != it_2->second) {
					DBCore::ULongVector diff1, diff2;
					std::set_difference (it_s->second.begin (), it_s->second.end (), it_2->second.begin (), it_2->second.end (), std::back_inserter (diff1));
					std::set_difference (it_2->second.begin (), it_2->second.end (), it_s->second.begin (), it_s->second.end (), std::back_inserter (diff2));
					printf ("%s: diff for %ld\n", key + 1, it_s->first);
					if (diff1.size ()) {
						printf ("in base1, not in base2:");
						for (DBCore::ULongVector::const_iterator pos_it = diff1.begin (); pos_it != diff1.end (); pos_it++)
							printf (" %ld", *pos_it);
						printf ("\n");
					}
					if (diff2.size ()) {
						printf ("in base2, not in base1:");
						for (DBCore::ULongVector::const_iterator pos_it = diff2.begin (); pos_it != diff2.end (); pos_it++)
							printf (" %ld", *pos_it);
						printf ("\n");
					}
				}
				it_s++;
				it_2++;
			} else {
				printf ("%s: %ld in base2, not in base1\n", key + 1, it_2->first);
				it_2++;
			}
		}
		while (it_s != map_doc_positions_s.end ()) {
			printf ("%s: %ld in base1, not in base2\n", key + 1, it_s->first);
			it_s++;
		}
		while (it_2 != map_doc_positions_2.end ()) {
			printf ("%s: %ld in base2, not in base1\n", key + 1, it_2->first);
			it_2++;
		}
	}

	printf ("ok\n");
	}

	{
	Index *index1 = base1->FindIndex ("SWords");
	Index *index2 = base2->FindIndex ("SWords");

	printf ("compare SWords\n");

	std::deque<long> etadocs;
	for (BTIterator etait (index2); !etait.End (); ++etait)
		etadocs.push_back (*(long*)etait.Key ());

	for (std::deque<long>::const_iterator doc_it = etadocs.begin (); doc_it != etadocs.end (); doc_it++) {
		long id = *doc_it;
		if (std::binary_search (changed_docs.begin (), changed_docs.end (), id)) {
			char keys [64];
			ACE_OS::memset (keys, 0, sizeof (keys));
			ACE_OS::memcpy (keys + 1, &id, sizeof (long));

			Stream* strs = indexs->Open (keys);
			Stream* str2 = index2->Open (&id);

			if (strs && str2) {
				if (strs->Length () == str2->Length ()) {
					char* datas = new char [strs->Length ()];
					char* data2 = new char [str2->Length ()];
					strs->Read (datas, strs->Length ());
					str2->Read (data2, str2->Length ());
					if (memcmp (datas, data2, strs->Length ()))
						printf ("%ld: mismatch in data\n", id);
					delete []datas;
					delete []data2;
				} else {
					printf ("%ld: length in base1 = %ld, in base2 = %ld\n", id, strs->Length (), str2->Length ());
				}
			} else if (strs) {
				printf ("%ld: in base1, not in base2\n", id);
			} else {
				printf ("%ld: in base2, not in base1\n", id);
			}
			if (strs) indexs->Close (strs);
			if (str2) index2->Close (str2);
		} else {
			Stream* str1 = index1->Open (&id);
			Stream* str2 = index2->Open (&id);

			if (str1 && str2) {
				if (str1->Length () == str2->Length ()) {
					char* data1 = new char [str1->Length ()];
					char* data2 = new char [str2->Length ()];
					str1->Read (data1, str1->Length ());
					str2->Read (data2, str2->Length ());
					if (memcmp (data1, data2, str1->Length ()))
						printf ("%ld: mismatch in data\n", id);
					delete []data1;
					delete []data2;
				} else {
					printf ("%ld: length in base1 = %ld, in base2 = %ld\n", id, str1->Length (), str2->Length ());
				}
			} else if (str1) {
				printf ("%ld: in base1, not in base2\n", id);
			} else {
				printf ("%ld: in base2, not in base1\n", id);
			}

			if (str1) index1->Close (str1);
			if (str2) index2->Close (str2);
		}
	}
	printf ("ok\n");
	}

#ifndef	WIN64
	delete base2;
	delete base1;
#endif

	return 0;
}
