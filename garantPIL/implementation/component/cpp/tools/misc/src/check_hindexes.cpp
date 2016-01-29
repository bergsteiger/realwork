#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{	
	{
		YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
		char* indexes [] = {"ServiceInfo", "Type", "Keyword", "PublishedIn", "Territory", "Class", "DocKind", "Adopted", ""};
		int result = 0;
		BTIterator *it;
		for (int i = 0; indexes [i][0]; i++) {
			char* name = indexes [i];
			printf ("checking %s\n", name); fflush (stdout);
			std::set<long> ids;
			std::map<long,std::string> map_id_name;
			for (it = new BTIterator (base->FindIndex (name)); !it->End (); ++(*it)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) it->Key ();
				long id = key->id;
				if (ids.find (id) == ids.end ()) {
					ids.insert (id);
					map_id_name.insert (std::map<long,std::string>::value_type (id, key->text));
				} else {
					printf ("found duplicate id %ld (%s, %s)\n", id, map_id_name.find (id)->second.c_str (), key->text); fflush (stdout);
					result = 1;
				}
			}
		}
		delete base;
	}
}
