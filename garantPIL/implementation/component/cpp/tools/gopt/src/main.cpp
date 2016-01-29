#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <fcntl.h>
//#include <unistd.h>
#include <cstdlib>

#include "osdep.h"
#include "gardefs.h"
#include "gopt.h"
#include "garver.h"
#include "basemask.h"
#include "garver.h"

#ifdef __WIN32__
	#ifdef __cplusplus
	extern "C" {
	#endif

	extern int optind;
	extern int opterr;
	extern int optopt;
	extern char *optarg;
	extern int optreset;

	extern int getopt(int argc, char *argv[], char *optstring);

	#ifdef __cplusplus
	}
	#endif
#endif

static void usage(void);

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	int c;

	VER_PARAM verParam;

	verParam.exeId= TID_GOPT;				// defines BASEMASK.H
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	if((c=_imp_GVersion(&argc, argv, &verParam))){
		if(c == VC_ADD_OK){
		}else{
		}
#ifdef _DEBUG
		printf("\n *** GOPT Debug Version. For test, only... ***\n\n");
#else
		exit(0);
#endif
	}
	#if defined(__GO32__) || defined(__CYGWIN32__)
		extern int _fmode;
		_fmode = ACE_OS_O_BINARY;
	#endif

#ifdef MULTI_INDEX_STREAM_FILE
	gopt_options |= GOO_NDT;
#endif
	while((c=getopt(argc, argv, "vnhf:")) != -1) {
		switch(c) {
			case 'n':
#ifndef MULTI_INDEX_STREAM_FILE
				gopt_options |= GOO_NDT;
				break;
#endif
			case 'f':
				{
					c = strlen(optarg);
					indx_file_name= (char *)malloc(c+1);
					memcpy(indx_file_name, optarg, c+1);
					break;
				}
			case 'h':
				usage();
				return 0;
			case '?':
			default:
				printf("Unrecognized option: \"%c\"\n", c);
				usage();
				return 0;
		}
	}
	if(argc-optind < 2) {
		usage();
		return 0;
	}
	return goptmain(argv+optind, argc-optind-1, argv[argc-1]);
}

static void usage(void)
{
#ifdef MULTI_INDEX_STREAM_FILE
	printf("Usage: gopt [-h] base1 [base2 ... baseN] out_path\n");
	printf("  where options are:\n");
	printf("    -h : display this help\n");
#else
	printf("Usage: gopt [-n] [-h] base1 [base2 ... baseN] out_path\n");
	printf("  where options are:\n");
	printf("    -n : optimize NDT file as well\n");
	printf("    -h : display this help\n");
#endif
}




