#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "SearchB.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

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

int main_logic ( int argc, char *argv[] )
{
	SearchBase *base = new SearchBase (argv [1], ACE_OS_O_RDONLY);

	Stream *str = base->FindIndex ("Aux")->Open (AUX_INVISIBLE_LENS);
	std::set<u_int64_t> aux_positions;
	if (str) {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		size /= sizeof (long);
		base->FindIndex ("Aux")->Close (str);
		while (ptr - data < size) {
			long id = *ptr++;
			long count = *ptr++;
			for (int i = 0; i < count; i++, ptr += 3) {
				long pos = *ptr;
				u_int64_t position = (((u_int64_t) id) << 32) + pos;
				aux_positions.insert (position);
			}
		}
		gk_free (data);
	}


	Index *index = base->FindIndex ("NWCntxt");

	for (BTIterator it (index); !it.End (); ++it) {
		char* key = (char*) it.Key ();

		std::map<long,DBCore::ULongVector> map_doc_positions_1, map_doc_positions;

		Stream *str0 = index->Open (key), *str1 = index->OpenN (key, 1), *str2 = index->OpenN (key, 2);
		if (str0) {
			DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

			DBCore::Ref_ ref = {0,0,0};
			DBCore::ExtrPair extr;

			while (str_reader->get_next (ref, 0)) {
				long id = ref.doc_id;
				DBCore::ULongVector positions;
				pos_reader->get (positions, ref, extr);
				for (DBCore::ULongVector::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
					long pos = *pos_it;
					if ((pos & ContextSearch::POS_INVISIBLE_BLOCK) == ContextSearch::POS_INVISIBLE_BLOCK) {
						pos &= ContextSearch::POS_TEXT;
						u_int64_t position = (((u_int64_t) id) << 32) + pos;
						printf ("%s %ld.%ld : %s\n", key+1, id, pos, aux_positions.find (position) == aux_positions.end () ? "not found" : "found");
						fflush (stdout);
					}
				}
			}

			index->Close (str2);
			index->Close (str1);
			index->Close (str0);
		}
	}

	delete base;

	return 0;
}
