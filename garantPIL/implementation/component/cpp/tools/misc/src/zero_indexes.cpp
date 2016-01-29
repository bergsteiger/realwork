#include "shared/Core/fix/mpcxc.h"

#include "stdbase.h"

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
	StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	base->IsOk ();
	for (int arg = 2; arg < argc; arg++) {
		base->FindIndex (argv [arg])->KeyCount = 0;
	}
	delete base;
	return 0;
}
