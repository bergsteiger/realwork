///////////////////////////////////////////////////////////////////////////////
//
// Главный модуль программы Garant change.
//
///////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

#include <cstdio>

#include "garver.h"
#include "stdbase.h"
#include "context.h"
#include "parser.h"

#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectCounter.h"
#include "shared/Core/mng/PoolMemoryManager.h"

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
	Context		mainContext;

	printf(	"Garant base change program\nVersion %s\n", GARANT_VERSION);

	if( mainContext.parse_command_line(argc, argv) ) {
		if( mainContext.parse_rules() ) {
			mainContext.do_changes();
		}
	}
	return 0;
}

