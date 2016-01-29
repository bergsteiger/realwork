
#include "shared/Core/fix/mpcxc.h"

#include "stdbase.h"
#include "basemask.h"
#include "garver.h"

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GREV_1;		// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GSETREV Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	if (argc < 2) {
		printf("First time delta helper. Use it ONLY with the first base v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
		printf("Usage: %s <base>\n", argv[0]);
		return 1;
	}
	StdBigBase base(argv[1], ACE_OS_O_RDWR);

	if (!base.IsOk()) {
		printf("Error opening base %s.\n", argv[1]);
		return 1;
	}
	long mask = base.GetReady();
	if (mask == -1) {
		printf("Base %s has format different than used in 4.04 version.\n", argv[1]);
		return 1;
	}
	SDataMask *pmask = GetUtilMasks(TID_GREV_2);
	mask |= pmask->lAddMask;
	base.keyFile->PutAttr("Ready", &mask, 4);
	printf("ok.\n");
	return 0;
}

