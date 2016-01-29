#include "shared/Core/fix/mpcxc.h"

#include "stdbase.h"
#include "basemask.h"
#include "garver.h"

#if (defined(_WIN32) && defined(_CONSOLE))
#include "recode.h"
#define	RECODE(_buf)	(Recoding(cd_win,cd_dos,_buf))
#else
#define	RECODE(_buf)	(_buf)
#endif

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

		verParam.exeId= TID_GSTATUS;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GSTATUS Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	if (argc < 2) {
		printf("GARANT Base status lister v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
		printf("Usage: %s <base>\n", argv[0]);
		return 1;
	}

	char * base_path = argv [1];
	if (base_path[0] == '/' && base_path[1] == '/' && base_path[3] == '/')
	{
		base_path++;
		base_path[0] = base_path[1];
		base_path[1] = ':';
	}

	YBase base(base_path, ACE_OS_O_RDONLY);
	if (!base.IsOk()) {
		printf("Error opening base.\n");
		return 1;
	}
	long mask = base.GetReady();
	if (mask == -1) {
		printf("No mask found in data.\nPossible old tools were used.");
		return 1;
	}
	if (base.IsPacked()) {
		printf("Base is packed");
	} else {
		printf("Base is not packed.\n");
	}
	char bufHSTS[9];
	if (base.keyFile->GetAttr("HSTS", bufHSTS, 8)) {
#ifdef unix
		printf("Syncronization label: %llX.\n", *(u_int64_t*)bufHSTS);
#else
		printf("Syncronization label: %I64X.\n", *(u_int64_t*)bufHSTS);
#endif
	} else {
		printf("No syncronization label.\n");
	}

	short count;
	short sz;
	char *buffer = GetProcessDescription(mask, count, sz);
	char *current = buffer;
	while (count--) {
		printf("Passed: %s\n", RECODE(current));
		current += strlen(current) +1;
	}
	long lNeed = base.CheckReady(TID_GDSHELL_REL);
	if (lNeed) {
		printf("ATTENTION!! Base is not ready for users.\n");
		short sSize, sProcCount;
		char *pNeedPs = GetProcessDescription(lNeed, sProcCount, sSize);
		if (!pNeedPs) {
			printf("Data mask fatal error.\n");
		} else {
			char *pCurrPs = pNeedPs;
			printf("Lack of %d processes.\n", sProcCount);
			while(sProcCount--) {
				printf("To run: '%s'\n", RECODE(pCurrPs));
				pCurrPs += strlen(pCurrPs) + 1;
			}
			free(pNeedPs);
		}
	} else {
		printf("CONGRATULATIONS!! Base is ready for users.\n");
	}
	free(buffer);

	return 0;
}

