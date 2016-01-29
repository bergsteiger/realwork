#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>
#include <ctime>
//#include <unistd.h>

#include "osdep.h"

#include "stdbase.h"

#ifdef __MSVC__
#include <getopt.h>
#endif

static const char *mypath;

static char attrName[] = "CTime";

static void usage()
{
	printf("Usage is:\n");
	printf("%s [[-W]|[-c label]] <base1> ...\n", mypath );
	printf("Use `-W' to write a new label to the base(s).\n"
		   "Use -c <label> to check <label> in the base(s):\n"
		   "               return 0 on success, 1 on failure.\n"
		   "No option will list labels, or print 0 if none.\n" );
}

int main(int argc, char **argv)
{
	int doWrite = 0;
	extern char *optarg;
	extern int optind;
	int c;
	int rv = 0;
	u_int32_t chk_time = 0;

	mypath = argv[0];

	while ((c = getopt(argc, argv, "Wc:h")) != EOF){
		switch(c) {
			case 'W':
				doWrite = 1;
				break;
			case 'c':
				chk_time = atoi(optarg);
				break;
			default:
				usage();
				return 1;
		}
	}
	argc -= optind;
	argv += optind;

	if( !argc ){
		usage();
		return 1;
	}
	if( doWrite ){
		u_int32_t thetime = time(0);

		for( int i=0; i<argc; i++ ){
			StdBigBase b(argv[i], ACE_OS_O_RDWR);
			if( !b.IsOk() ){
				printf("base %s not ok.\n", argv[i]);
				rv = 1;
				continue;
			}
			b.keyFile->PutAttr(attrName,&thetime,sizeof(thetime));
			b.strFile->PutAttr(attrName,&thetime,sizeof(thetime));
			b.textFile->PutAttr(attrName,&thetime,sizeof(thetime));
		}
	}else{
		u_int32_t kTime, sTime, tTime;

		for( int i=0; i<argc; i++ ){
			kTime = sTime = tTime =0;
			YBase b(argv[i], ACE_OS_O_RDONLY);
			if( !b.IsOk() ){
				printf("base %s not ok.\n", argv[i]);
				rv = 1;
				continue;
			}
			b.keyFile->GetAttr(attrName,&kTime,sizeof(kTime));
			b.strFile->GetAttr(attrName,&sTime,sizeof(sTime));
			b.textFile->GetAttr(attrName,&tTime,sizeof(tTime));
			int eq = (kTime == sTime) && (sTime == tTime);
			if( chk_time ){
				if( !eq || kTime != chk_time )
					rv = 1;
			}else{
				if ( !eq ) kTime = 0;
				rv = 1;
				printf("%s\t%u\n", argv[i], kTime );
			}
		}
	}

	return rv;
}






