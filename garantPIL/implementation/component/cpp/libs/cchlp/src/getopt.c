#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>

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
	if(option == '-') return -1;
	optind++;
	opts = strchr(optstring, option);
	if(!opts) {
		if(opterr)
			fprintf(stderr, "Unknown option '%c'\n", option);
		return '?';
	}
	if(opts[1] == ':') {
		strcpy(optarg, argv[optind]);
		optind++;
	}
	optopt = option;
	return option;
}

