#include "ace/ACE.h"
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
#include "pack.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);

		AttrIndex* attrs = (AttrIndex*) base->FindIndex ("Attrs");
		AttrKey key = {ID_BORDER, IDD_DIV};
		BTIterator it (attrs); it.Set (&key);
		for ( ; ; it.next ()) {
			key = *(AttrKey*) it.Key ();
			if (key.AttrTag != IDD_DIV)
				break;
			long doc_id = key.DocId, size = 0;
			char *data = (char*) base->LoadAttr (doc_id, IDD_DIV, size);
			base->ReplaceAttr (doc_id, IDD_DIV, data, size);
			gk_free (data);
			printf ("%ld\r", doc_id);
		}
		printf ("\n");
		delete base;
		
		exit (EXIT_SUCCESS);
	}

	return 0;
}
