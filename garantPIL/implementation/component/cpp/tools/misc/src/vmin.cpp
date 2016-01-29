#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "shared\GCL\alg\set_operations.h"

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

inline int operator < (const date& a, const date& b) {
	return CompDates ( (date*)&a, (date*)&b ) < 0;
}

int main_logic ( int argc, char *argv[] )
{
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->IsOk ();

	DocCollection *alldocs = base->AllDocs (), docs_with_vmin;
	std::vector<long> vector_with_iddsortdate, vector_with_vmin;
	Index* docind = base->FindIndex ("Attrs");
	std::map<date,DocCollection*> map_date_docs;
	for (int i = 0; i < alldocs->ItemCount; i++) {
		long id = (*alldocs) [i];

		AttrKey	included_key = {id, IDD_VINCLUDED};
		Stream *str = docind->Open (&included_key);
		date vincluded; vincluded.da_year = 2099;
		if (str) {
			str->Read (&vincluded, sizeof (vincluded));
			docind->Close (str);
		}

		AttrKey	anonced_key = {id, IDD_VANONCED};
		date vanonced; vanonced.da_year = 2099;
		str = docind->Open (&anonced_key);
		if (str) {
			str->Read (&vanonced, sizeof (vanonced));
			docind->Close (str);
		}

		if (vanonced.da_year == 2099 && vincluded.da_year == 2099)
			continue;

		date vmin = vincluded;
		if (is_lt (vanonced, vincluded))
			vmin = vanonced;
		std::map<date,DocCollection*>::iterator map_it = map_date_docs.find (vmin);
		if (map_it == map_date_docs.end ()) {
			DocCollection *docs = new DocCollection;
			docs->Add (id);
			map_date_docs.insert (std::map<date,DocCollection*>::value_type (vmin, docs));
		} else {
			map_it->second->Add (id);
		}
	}
	{
		AttrIndex *attrs = (AttrIndex*) base->FindIndex ("Attrs");
		AttrKey key = {ID_BORDER, IDD_SORTDATE};
		for (BTIterator it (attrs, &key); !it.End (); ++it) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_SORTDATE)
				break;
			vector_with_iddsortdate.push_back (key->DocId);
		}
	}
	printf ("%ld\n", map_date_docs.size ());

	delete base;

	StdBigBase *out = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	Index *dates = out->FindIndex ("SortDate");
	std::deque<date> olddates;
	for (BTIterator it (dates); !it.End (); ++it) {
		olddates.push_back (*(date*)it.Key ());
	}
	for (std::deque<date>::const_iterator del_it = olddates.begin (); del_it != olddates.end (); del_it++) {
		date deldate = *del_it;
		dates->DelKey (&deldate);
	}
	for (std::map<date,DocCollection*>::const_iterator map_it = map_date_docs.begin (); map_it != map_date_docs.end (); map_it++) {
		date vmin = map_it->first;
		Stream* str = dates->Open (&vmin, 1);
		if (str) {
			DocCollection *docs = map_it->second;
			docs->Put (str);
			dates->Close (str);

			for (int i = 0; i < docs->ItemCount; i++) {
				long id = (*docs) [i];
				vector_with_vmin.push_back (id);
				docs_with_vmin.Insert (&id);
				out->ReplaceAttr (id, IDD_SORTDATE, &vmin, sizeof (vmin));
			}
		}
	}
	std::sort (vector_with_vmin.begin (), vector_with_vmin.end ());
	printf ("%ld - %ld", alldocs->ItemCount, docs_with_vmin.ItemCount);
	alldocs->Minus (docs_with_vmin);
	printf (" = %ld\n", alldocs->ItemCount);
	for (int i = 0; i < alldocs->ItemCount; i++)
		out->DelAttr ((*alldocs)[i], IDD_SORTDATE);

	GCL::set_difference (vector_with_iddsortdate, vector_with_vmin);
	for (std::vector<long>::const_iterator it = vector_with_iddsortdate.begin (); it != vector_with_iddsortdate.end (); it++)
		out->DelAttr (*it, IDD_SORTDATE);

	delete out;

	return 0;
}
