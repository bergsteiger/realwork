#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>

#ifndef _WINDOWS
	extern int gsplit_Method(int argc, char **argv, void *pCntx);
int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {

	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE / 2);

	return res;
}

int main_logic ( int argc, char *argv[] )
	{
		return gsplit_Method(argc, argv, 0);
	}
#endif

