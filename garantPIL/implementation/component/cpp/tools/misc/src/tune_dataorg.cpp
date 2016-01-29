#include "shared/Core/fix/mpcxc.h"

#include "protect.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	BasesOrgProtection borg;
	if (borg.tune_protection (argv [1]) == BasesOrgProtection::OK)
		exit (EXIT_SUCCESS);
	else
		exit (EXIT_FAILURE);
	
}
