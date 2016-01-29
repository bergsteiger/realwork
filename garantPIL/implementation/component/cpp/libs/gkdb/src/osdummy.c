#include "shared/Core/fix/mpcxc.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "osdep.h"

#ifdef __OSDEP_NEED_FILELENGTH

off_t filelength(int hfile)
{
	struct stat st;

	return fstat(hfile, &st) ? 0 : st.st_size;
}

#endif

#ifdef __OSDEP_NEED_GETOPT

int optind = 1;
int opterr = 1;
int optopt = 0;
char *optarg = NULL;
int optreset = 0;

static void _getopt_cleanup(void)
{
	if(optarg) free(optarg);
}

int getopt(int argc, char *argv[], char *optstring)
{
	int option;
	char *opts;

#ifdef WIN32 // GARANT_WIN32
	option= argc;
	while(--option){
		if((opts= strchr(argv[option], '/')) && !memcmp(opts+1,"///",3)){
			strcpy(opts, opts+2);
			strcpy(opts, "\\\\");
		}
	}
	option= argc;
	while(--option){
		if((opts= strchr(argv[option], '/')) && *(opts+1) == '/'){
			opts[0] = opts[2];
			strcpy(opts+1, opts+2);
			opts[1] = ':';
		}
	}
	option= argc;
	while(--option){
		while((opts= strchr(argv[option], '/'))){
			*opts= '\\';
		}
	}
#endif

	if(optreset) {
		optopt = 0;
	}
	if(!optarg) {
		optarg = (char *)malloc(1024);
		atexit(_getopt_cleanup);
	}
	if(optind >= argc || *argv[optind] != '-')
		return -1;
	option = (argv[optind])[1];
	if(option == '-')
		return -1;
	opts = strchr(optstring, option);
	if(!opts) {
		if(opterr)
			fprintf(stderr, "Error: Unknown option '%c'\n", option);
		return '?';
	}
#ifndef IGNORE_YAR_CODE
	if(strlen(argv[optind]) != strlen("-?")){
		if(argv[optind][2] == ':'){
			argv[optind] += 3;
			optind--;
		}else{
			if(opterr)
				fprintf(stderr, "Error: Unknown option '%s'\n", argv[optind]);
			return '?';
		}
	}
#endif
	optind++;
	if(opts[1] == ':') {
		strcpy(optarg, argv[optind]);
		optind++;
	}
	optopt = option;
	return option;
}

#endif

#ifdef __OSDEP_NEED_MKSTEMP

int mkstemp(char *fname)
{
	mktemp(fname);
	return c_io_open(fname, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY);
}

#endif

#ifdef	__OSDEP_DOS_FAR_GK
void	gk_bzero ( void * ptr, long size )
{
	char gk_huge * p = (char gk_huge *) ptr;

	for ( ; size > 0; size-- )
		* p++ = '\0';
}

void	gk_memcpy ( void * to, const void * from, long size )
{
	char gk_huge * p1 = (char gk_huge *) to;
	char gk_huge * p2 = (char gk_huge *) from;

	for ( ; size > 0; size-- )
		* p1++ = * p2++;
}
#endif

