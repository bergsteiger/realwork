#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "gardefs.h"
#include "stdbase.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

extern	void	BuildPatternM (ContextPattern&, char*);

int main_logic ( int argc, char *argv[] )
{
	StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	Index *attrs = base->FindIndex ("Attrs");
	AttrKey key = {ID_BORDER, IDD_HANDHANDMASK};
	BTIterator* btit = new BTIterator (attrs, &key);
	std::map<long, std::vector <long> > map_doc_lens;
	for (; !btit->End (); ++(*btit) ) {
		AttrKey *keyptr = (AttrKey*) btit->Key ();

		if (keyptr -> AttrTag != IDD_HANDHANDMASK)
			break;

		long id = keyptr->DocId, size = 0;
		char* masks = (char*) base->LoadAttr (id, IDD_HANDHANDMASK, size), *ptr = masks;
		std::vector<long> lens;
		ContextPattern pattern;
		while (ptr - masks < size) {
			BuildPatternM (pattern, ptr);
			lens.push_back (pattern.WordCount-1);
			ptr += strlen (ptr) + 1;
		}
		lens.push_back (0);
		map_doc_lens.insert (std::map <long, std::vector <long> >::value_type (id, lens));
		gk_free (masks);
	}
	delete btit;
	key.AttrTag = IDD_HANDMASK;
	btit = new BTIterator (attrs, &key);
	for (; !btit->End (); ++(*btit) ) {
		AttrKey *keyptr = (AttrKey*) btit->Key ();

		if (keyptr -> AttrTag != IDD_HANDMASK)
			break;

		long id = keyptr->DocId, size = 0;
		char* masks = (char*) base->LoadAttr (id, IDD_HANDMASK, size), *ptr = masks;
		if (map_doc_lens.find (id) == map_doc_lens.end ()) {
			std::vector<long> lens;
			lens.push_back (0);
			map_doc_lens.insert (std::map <long, std::vector <long> >::value_type (id, lens));			
		}
		std::vector<long> *lens = &map_doc_lens.find (id)->second;
		ContextPattern pattern;
		while (ptr - masks < size) {
			BuildPatternM (pattern, ptr);
			lens->push_back (pattern.WordCount-1);
			ptr += strlen (ptr) + 1;
		}
		gk_free (masks);
	}
	delete btit;

	long size = 0;
	std::map<long, std::vector<long> >::iterator it;
	for (it = map_doc_lens.begin (); it != map_doc_lens.end (); it++) {
		it->second.push_back (0);
		size += sizeof (long) + it->second.size () * sizeof (long);
	}
	if (size) {
		long *data = (long*) malloc (size), *ptr = data;
		for (it = map_doc_lens.begin (); it != map_doc_lens.end (); it++) {
			*ptr++ = it->first;
			for (std::vector<long>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++, ptr++)
				*ptr = *it2;
		}
		Stream* str = base->FindIndex ("Aux")->Open (AUX_HANDMASK_LENS, 1);
		if (str) {
			str->Write (data, size);
			str->Trunc ();
			base->FindIndex ("Aux")->Close (str);
		}
		gk_free (data);
	}
	delete base;

	return 0;
}
