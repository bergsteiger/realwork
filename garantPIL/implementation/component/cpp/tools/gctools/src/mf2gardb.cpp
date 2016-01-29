#include "shared/Core/fix/mpcxc.h"
#include <cstdio>

//#include <unistd.h>

#include "osdep.h"
#include "garver.h"
#include "basemask.h"

#include "dbproc.m-to-gkdb.h"
#include "dbproc.mf.h"

#ifdef AS_PROCESS
	#include "MyPipe.h"
#endif

extern int local_mf2_main(
#ifdef WITH_DBL_THREAD
			   LPTHREAD_CNTX pCntxt
#else
			   int argc, char **argv
#endif
			   );
			   
int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_MF2GARDB;		// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** MF2GARDB Debug Version. For test, only... ***\n\n");
	#else
			return -1;
	#endif
		}
	}
#ifdef AS_PROCESS
	LPTHREAD_CNTX p_Writer, p_Reader;
	init_my_pipe(&p_Writer, &p_Reader, ".\\gc_mdl.exe MF2GRDB_MODULE GCINI");

	p_Writer->l_argc= 2;
	p_Writer->l_argv= (char**)malloc(2*sizeof(char*));
	p_Writer->l_argv[0]= strdup(argv[0]);
	p_Writer->l_argv[1]= strdup(argv[1]);

	p_Reader->l_argc= argc;
	p_Reader->l_argv= argv;

	p_Reader->l_argv[1]= (char*)p_Reader;

	local_mf2_main(p_Reader);

	done_my_pipe(p_Writer, p_Reader);
	return 0;
#else
	return local_mf2_main( argc, argv );
#endif
}

