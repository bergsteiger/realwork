#include "shared/Core/fix/mpcxc.h"

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

int main_logic ( int argc, char *argv[] )
{
	YBase *from_base = new YBase (argv [2], ACE_OS_O_RDONLY);
	from_base->IsOk ();
	StdBigBase *to_base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	to_base->IsOk ();
	//short seg = (short)(atol (argv [3]) & 0x7FFF);

	AttrKey key = {ID_BORDER, IDD_PROFDATE};
	for (BTIterator it(from_base->FindIndex ("Attrs"), &key); !it.End (); ++it) {
		AttrKey *akey = (AttrKey*) it.Key ();
		if (akey->AttrTag != IDD_PROFDATE)
			break;
		long id = akey->DocId, size = 0;
		date* dates = (date*) from_base->LoadAttr (id, IDD_PROFDATE, size);
		DocInfo docinfo;
		if (to_base->FindDocInfo (id, docinfo) == sizeof (docinfo)) {
			to_base->ReplaceAttr (id, IDD_PROFDATE, dates, size);

			/*
			StorableSplaySet<short> belongs;
			to_base->LoadAttr (id, IDD_BASES, belongs);
			belongs.add (seg);
			((AttrIndex*)to_base->FindIndex ("Attrs"))->Replace (id, IDD_BASES, belongs);

			if (docinfo.Status & DS_DOC) {
				Stream *str = to_base->FindIndex ("Segment")->Open (&seg, 1);
				if (str) {
					DocCollection docs;
					docs.Get (str);
					docs.Add (id);
					str->Seek (0);
					docs.Put (str);
					str->Trunc ();
					to_base->FindIndex ("Segment")->Close (str);
				}
			}
			*/
		}
		gk_free (dates);
	}

	printf ("\n");
	delete to_base;
	delete from_base;
	return 0;
}
