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

int main_logic ( int argc, char *argv[] )
{
	{
		if (argc == 2) {
			YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
			char buffer [64];
			base->textFile->GetAttr (tagPswdAttr, buffer, sizeof (buffer));
			printf ("%s\n", buffer);
			printf ("%ld\n", base->GetClientInfo ());
			delete base;
		} else if (argc == 4) {
			StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			base->textFile->PutAttr (tagPswdAttr, argv [2], strlen (argv [2]) + 1);
			long ki = atol (argv [3]);
			base->textFile->PutAttr (tagKIAttr, &ki, sizeof (ki));
			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	return 0;
}
