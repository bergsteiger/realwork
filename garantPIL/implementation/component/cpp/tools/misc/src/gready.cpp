
#include "shared/Core/fix/mpcxc.h"

#include <cstring>
#include <cstdio>
#include <cstdlib>
//#include <unistd.h>
#include "stdbase.h"
#include "basemask.h"
#include "garver.h"
#include <getopt.h>

static char *util_names [] = {
	"TID_NONE", "TID_MF2GARDB", "TID_GCTX", "TID_GL", "TID_GATTRCHK", "TID_GOPT",
	"TID_GREV_1", "TID_GREV_2", "TID_GSPLIT", "TID_HISYNC", "TID_GM", "TID_GU",
	"TID_GDLT", "TID_GKDBCMP", "TID_GKDUMPI", "TID_BASEINFO",
	"TID_GWSHELL_PREV", "TID_GWSHELL_REL", "TID_GDSHELL_PREV", "TID_GDSHELL_REL"
#ifdef	VERSION56
	, "TID_ENUMPARAS"
#endif
};
static int16_t util_ids[] = {
	TID_NONE, TID_MF2GARDB, TID_GCTX, TID_GL, TID_GATTRCHK, TID_GOPT,
	TID_GREV_1, TID_GREV_2, TID_GSPLIT, TID_HISYNC, TID_GM, TID_GU,
	TID_GDLT, TID_GKDBCMP, TID_GKDUMPI, TID_BASEINFO,
	TID_GWSHELL_PREV, TID_GWSHELL_REL, TID_GDSHELL_PREV, TID_GDSHELL_REL
#ifdef	VERSION56
	, TID_ENUMPARAS
#endif
};

#define KNOWN_UTIL_COUNT sizeof(util_ids)/sizeof(int16_t)

static void usage(void);
static void help(void);
static int parse_cmdline(int, char **);

static u_int32_t ready_mask_to_set=0;
static char *base_name = 0;

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

		verParam.exeId= TID_GREADY;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GREADY Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	int mode;
	Base *base;
	int32_t mask;

	printf("GARANT Base ready flags hacking utility v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	if (argc < 2) {
		usage();
		printf("Usage: %s <base>\n", argv[0]);
		return 1;
	}
	if(!(mode = parse_cmdline(argc, argv)))
		return 1;
	
	if (mode == 1)
		base = new YBase(base_name, ACE_OS_O_RDONLY);
	else
		base = new StdBigBase(base_name, ACE_OS_O_RDWR);

	if (!base || !base->IsOk()) {
		printf("Error opening base.\n");
		return 1;
	}
	if (mode == 1) { // Only print completed process info for given base
		mask = base->GetReady();
		if (mask == -1) {
			printf("No mask found in data.\n");
			return 1;
		}
		short count;
		short sz;
		char *buffer = GetProcessDescription(mask, count, sz);
		char *current = buffer;
		while (count--) {
			printf("Passed: %s\n", current);
			current += strlen(current) +1;
		}
		free(buffer);
	}
	else if (mode <= 3) // Set the selected process info
		base->keyFile->PutAttr("Ready", &ready_mask_to_set, 4);
	else if (mode == 4) {
		mask = base->GetReady();
		if (mask == -1) mask = 0;
		mask |= ready_mask_to_set;
		base->keyFile->PutAttr("Ready", &mask, 4);
	}
	delete base;
	return 0;
}

static void usage(void)
{
	printf("Usage:\n");
	printf("\ttgready -h for help\n");
	printf("To get status info:\n\tgready <base name>\n");
	printf("To set selected programs passed flags:\n\tgready -s <base name> <program1> [<program2> ...]\n");
	printf("To set flags indicates ready state for selected program:\n");
	printf("\tgready -S <base name> <program>\n");
	printf("To add flags indicates completion of selected program:\n");
	printf("\tgready -a <base name> <program>\n");
}

static void help(void)
{
	int i;

	usage();
	printf("\nValid program names are:\n");
	for(i=0; i<KNOWN_UTIL_COUNT>>1; i++) {
		printf("\t%s\t\t\t%s\n", util_names[i<<1], util_names[(i<<1)+1]);
	}
	if (KNOWN_UTIL_COUNT & 1) printf("\t%s\n", util_names[KNOWN_UTIL_COUNT-1]);
}

static int16_t utilid_from_name(const char *name);
static u_int32_t get_finish_mask(const char *);
static u_int32_t get_required_mask(const char *);

typedef char *_pchar;

static int parse_cmdline(int argc, char **argv)
{
	int c;
	int mode=0;

	while ((c=getopt(argc, argv, "sSha")) != -1) {
		switch(c) {
			case 'h':
				help();
				return 0;
			case 's':
				mode = 1;
				break;
			case 'S':
				mode = 2;
				break;
			case 'a':
				mode = 3;
				break;
			default:
				printf("Unrecognized option '%s'\n\n", argv[optind - 1]);
				usage();
				return 0;
		}
	}
	if(optind == argc) {
		printf("No base name given.\n\n");
		usage();
		return 0;
	}
	base_name = strdup(argv[optind++]);
	if (mode == 1 || mode == 3) {
		if (optind == argc) {
			printf("No program names to set their flags given.\n\n");
			usage();
			free(base_name);
			return 0;
		}
		for(; optind<argc; optind++) {
			if(utilid_from_name(argv[optind]) == -1) {
				printf("Unrecognized program name \"%s\" - ignored.\n", argv[optind]);
				continue;
			}
			ready_mask_to_set |= get_finish_mask(argv[optind]);
		}
	}
	else if (mode == 2) {
		if(utilid_from_name(argv[optind]) == -1) {
			printf("Unrecognized program name \"%s\" - ignored.\n", argv[optind]);
			return 0;
		}
		ready_mask_to_set = get_required_mask(argv[optind]);
	}
	return mode+1;
}

static int16_t utilid_from_name(const char *name)
{
	int i;
	
	for (i=0; i<KNOWN_UTIL_COUNT && strcmp(name, util_names[i]); i++);
	if(i == KNOWN_UTIL_COUNT) return -1;
	return util_ids[i];
}

static u_int32_t get_finish_mask(const char *name)
{
	int16_t util_id = utilid_from_name(name);
	SDataMask *pmask = GetUtilMasks(util_id);
	return (u_int32_t)(pmask->lAddMask);
}

static u_int32_t get_required_mask(const char *name)
{
	int16_t util_id = utilid_from_name(name);
	SDataMask *pmask = GetUtilMasks(util_id);
	return (u_int32_t)(pmask->lCheckMask);
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}






