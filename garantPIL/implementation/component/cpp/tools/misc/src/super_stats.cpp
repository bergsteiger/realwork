#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		SearchBase* base = new SearchBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		base->is_morpho_exist();
		base->check_version();
		base->get_index ("Status");
		base->FindIndex ("Attrs");

		DocCollection *all = base->AllTopics (ID_BORDER);
		std::map<long,std::vector<long> > map_seg_docs;
		for (int i = 0; i < all->ItemCount; i++) {
			long id = (*all) [i], size = 0;
			short *segs = (short*) base->LoadAttr (id, IDD_BASES, size), *ptr = segs;
			for (int j = 0; j < size / 2; j++, ptr++) {
				std::map<long,std::vector<long> >::iterator it = map_seg_docs.find (*ptr);
				if (it == map_seg_docs.end ()) {
					std::vector<long> begin;
					begin.push_back (id);
					map_seg_docs.insert (std::map<long,std::vector<long> >::value_type (*ptr, begin));
				} else {
					it->second.push_back (id);
				}
			}
			gk_free (segs);
		}
		for (std::map<long,std::vector<long> >::const_iterator it = map_seg_docs.begin (); it != map_seg_docs.end (); it++)
			for (std::vector<long>::const_iterator doc_it = it->second.begin (); doc_it != it->second.end (); doc_it++)
				printf ("%ld: %ld\n", it->first, *doc_it);
		delete base;
		exit (EXIT_SUCCESS);
	}
}
