#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include "osdep.h"

#include <getopt.h>
#include "dbproc.m-reader.h"
#include "dbproc.mf.h"
#include "argsutils.h"

static void usage(const char *);

void usage(const char *m)
{
	printf("Usage is:\n"
	"%s [options] metafile basename\n"
	"Options:\n"
	"\t-f <no-><program-flow-option>\n"
	"\tProgram-flow-option is:\n"
	"\t\tdebug-op",m );
}
int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	char *my_path = argv[0];
	if (argc < 2)
	{
		usage(my_path);
		return 1;
	}
	int option_char;
	extern char *optarg;
	extern int optind;
	
	while ((option_char = getopt (argc, argv, "hf:")) != EOF){
		switch (option_char){
			case 'h':
				usage(my_path);
				return 0;

/*			case 'f':
				{
					int r;
					if( (r = getYNarg( optarg,"debug-op")) != -1 ){
						debug = r;
					}else{
						usage(my_path);
						return 1;
					}
				}
				break;
*/
			default:
				usage(my_path);
				return 1;
		}
	}
	argc -= optind;
	argv += optind;
	if( argc != 1 ){
		usage(my_path);
		return 1;
	}
	DbProcMetaFile mf( argv[0], 0 );
	DbProcessorMReader mfr(&mf );
	mfr.run();
	return 0;
}


