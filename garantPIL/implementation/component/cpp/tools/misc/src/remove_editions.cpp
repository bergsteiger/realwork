#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);

	std::set<long> editions;
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (str) {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			ptr++;
			ptr++;
			editions.insert (edition);
		}
		free (data);
	}

	Index *newcorr_index = base->FindIndex ("NewCorr");
	std::deque<long> to_delete;
	for (BTIterator it (newcorr_index); !it.End (); ++it) {
		long id = *(long*) it.Key ();
		Stream *str = newcorr_index->Open (&id);
		if (str) {
			long count = str->Length (), ok = 0;
			char* data = new char [count];
			str->Read (data, count);
			CorrRef *from = (CorrRef*) data, *to = from;
			for (count /= sizeof (CorrRef); count; count--, from++) {
				if (editions.find (from->DocId) == editions.end ()) {
					ok += sizeof (CorrRef);
					if (from != to)
						*to = *from;
					to++;
				}
			}

			if (ok) {
				if (ok != str->Length ()) {
					str->Seek (0);
					str->Write (data, ok);
					str->Trunc ();
				}
			} else
				to_delete.push_back (id);
			delete []data;
			newcorr_index->Close (str);
		}
	}

	for (std::deque<long>::const_iterator it = to_delete.begin (); it != to_delete.end (); it++) {
		long id = *it;
		newcorr_index->Delete (&id);
	}

	delete base;

	return 0;
}
