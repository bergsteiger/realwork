#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
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

int main_logic ( int argc, char *argv[] )
{
	DocCollection docs, editions, nodocs, annos;
	DocCollection inpharm;

	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->open_saw_bases (ACE_OS_O_RDONLY);
	for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
		AttrIndex* docInd = (AttrIndex*) (*base_it)->FindIndex ("Attrs");
		static const AttrKey attrkey = {ID_BORDER, IDD_INFO};
		BTIterator* it = new BTIterator (docInd, &attrkey);
		for (; !it->End (); ++(*it)) {
			AttrKey *ptr = (AttrKey *) it->Key ();

			if (ptr->AttrTag != IDD_INFO)
				break;

			Stream* str = docInd->Open (ptr);
			if (!str)
				continue;

			DocInfo docinfo;
			str->Read (&docinfo, sizeof (docinfo));
			docInd->Close (str);

			if (docinfo.Status & DS_DOC)
				docs.Add (ptr->DocId);
			if (docinfo.Status & DS_NODOC)
				nodocs.Add (ptr->DocId);
			if (docinfo.Status & DS_ANNO)
				annos.Add (ptr->DocId);
			if (docinfo.Status & DS_EDITION)
				editions.Add (ptr->DocId);
			if (docinfo.Status_ex & DS_MEDTOPIC)
				inpharm.Add (ptr->DocId);
		}
	}
	base->close_saw_bases ();
	delete base;

	base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	Index *index = base->FindIndex ("Status");
	short key;
	Stream *str;
	if (docs.ItemCount) {
		key = DS_DOC;
		str = index->Open (&key, 1);
		if (str) {
			docs.Put (str);
			str->Trunc ();
			index->Close (str);
		}
	}
	if (nodocs.ItemCount) {
		key = DS_NODOC;
		str = index->Open (&key, 1);
		if (str) {
			nodocs.Put (str);
			str->Trunc ();
			index->Close (str);
		}
	}
	if (editions.ItemCount) {
		key = DS_EDITION;
		str = index->Open (&key, 1);
		if (str) {
			editions.Put (str);
			str->Trunc ();
			index->Close (str);
		}
	}
	if (annos.ItemCount) {
		key = DS_ANNO;
		str = index->Open (&key, 1);
		if (str) {
			annos.Put (str);
			str->Trunc ();
			index->Close (str);
		}
	}
	index = base->FindIndex ("Segment");
	short seg = INPHARM_SEGMENT;
	str = index->Open (&seg, 1);
	if (str) {
		DocCollection docs;
		docs.Get (str);
		str->Seek (0);
		docs.Merge (inpharm);
		docs.Put (str);
		str->Trunc ();
		index->Close (str);
	}
	delete base;

	return 0;
}
