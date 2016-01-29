#include "shared/Core/fix/mpcxc.h"
#include <cstdio>

#include "garver.h"
#include "stdbase.h"

#define		EXIT(_msg,_obj,_ret)	{printf(_msg); delete _obj; return _ret;}

int main ( int argc, char **argv )
{
	long		old_number;
	long		new_number;

	if ((argc < 4) || ((old_number=atol(argv[2])) == 0) || ((new_number=atol(argv[3])) == 0))
	{
		printf("\n");
		printf("GARANT Document change utility v%s (%s %s)\n",GARANT_VERSION, __DATE__, __TIME__);
		printf("Usage: %s <base_name> <old_number> <new_number>\n",argv[0]);
		printf("\n");
		printf("WARNING: Old data will be lost\n");
		printf("\n");

		return 1;
	}

	Base		*base = new StdBigBase(argv[1],ACE_OS_O_RDWR); assert(base);

	if (!base->IsOk() || base->IsPacked()) EXIT("Can't open base or base maybe packed",base,1);
	if (!base->DelText(new_number)) EXIT("Can't delete old data",base,1);

	base->RenameDoc(old_number,new_number);

	EXIT("0",base,0);
}


