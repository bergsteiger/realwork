#include <stdlib.h>
#include <stdio.h>

#include <string.h>

#ifdef WIN32
	#define __WIN32__
#endif
/*
#if defined(__GO32__) || defined(__WIN32__)
	#include <direct.h>
#endif
*/
#include "osdep.h"
#include "../../../libs/mrglib/src/gdbapi.h"

#include "basemask.h"

#if defined(__GO32__) || defined(__WIN32__)
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

#include "../../../libs/mrglib/src/log.h"
#include "garver.h"

extern char *gs_target_name;
extern char *gs_dest_path;
extern char **gs_source_name;
extern char *gs_job_file;
extern char *gs_result_file;
extern char *gs_garant_root;
extern char *gs_work_dir;
extern char *gs_cwd;
extern char *gs_logfile;
extern int gs_source_count;
extern int gs_options;
extern int b_sawbase;

extern void gm_set_language(int);

void help(void)
{
	printf("Usage:\n");
	printf("  gm [options] [-j <job file>]\n");
	printf("  gm [options] [-o <[{Size in Kbytes}]output base name>] base1 base2 ... baseN\n");
	printf("Where options are:\n");
	printf("\t-s  ignore sync stamps in source bases\n");
	printf("\t-r <result file name>\twrite result code to this file\n");
	printf("\t-b  used by _breeder.exe, caused job file search in ..\\DATA path\n");
	printf("\n");
}

int get_garant_root(char *argv0);

#include <basemask.h>
#include <garver.h>

int parse_cmdline(int argc, char **argv)
{
	int c, len;
	int use_job, i, exit_print;
	char *slash;

	VER_PARAM verParam;

	verParam.exeId= TID_GM;				// defines BASEMASK.H
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	if((c=_imp_GVersion(&argc, argv, &verParam))){
		if(c == VC_ADD_OK){
		}else{
		}
#ifdef _DEBUG
		printf("\n *** GM Debug Version. For test, only... ***\n\n");
#else
		exit(0);
#endif
	}
	if(argc == 1)
		return 0;

	use_job = 1;
	if(!get_garant_root(argv[0])) {
		gs_cwd = "";
		gs_garant_root = "";
	}
	exit_print = sizeof(gs_source_name);
	exit_print = 0;
	while(exit_print == 0 && (c=getopt(argc, argv, "phbsej:r:o:l:")) != -1) {
		switch(c) {
			case 'p':
				//сливаем базу как "порезанную" (не сливаем тексты, SubName, Blobы, Attrs и Attribs)
				b_sawbase = 1;
				break;
			case '?':
			case 'h':
				exit_print = 2;
				break;
			case 'e':
				gm_set_language(1);
				break;
			case 's':
				gs_options &= 0xFFFFFFFE;
				break;
			case 'o':
				gs_target_name = strdup(optarg);
				break;
			case 'r':
				gs_result_file = (char *)malloc(512);
				if(optarg[0] == '-'){
					exit_print = 2;
					break;
				}
				strcpy(gs_result_file, optarg);
				break;
			case 'l':
				gs_logfile = (char *)malloc(512);
				strcpy(gs_logfile, optarg);
				create_log(gs_logfile, 0);
				break;
			case 'j':
				gs_job_file = (char *)malloc(512);
				strcpy(gs_job_file, optarg);
				use_job = 2;
				break;
#if defined(__GO32__) || defined(__WIN32__)
			case 'b': // Assume running from _breeder.exe : track data dir to ../DATA
				if(!gs_work_dir) {
					gs_work_dir = (char *)malloc(512);
					getcwd(gs_work_dir, 512);
				}
#if defined(__GO32__)
				slash = strchr(gs_work_dir, '\\');
				for(; slash; slash=strchr(slash, '\\'))
					*slash = DIRECTORIES_TERM;
#endif
				strcpy(strrchr(gs_work_dir, DIRECTORIES_TERM)+1, "DATA");
				break;
#endif
			default:
				return 0;
		}
	}
	if (exit_print) {
		if (exit_print == 2) help();
		return 0;
	}
	if(gs_target_name == 0 && gs_job_file == 0){
		fprintf(stderr, "\nError: Not find output base name...\n\n");
		help();
		return 0;
	}
	if(use_job == 1) {
		gs_source_count = argc - optind;
		if(gs_source_count == 0)
			return 0;
		if(gs_source_count < 2){
			fprintf(stderr, "\nError: Not find collection sourced base's...\n\n");
			help();
			return 0;
		}
		gs_source_name = (char **)malloc(gs_source_count*sizeof(char *));
		bzero((caddr_t)gs_source_name, gs_source_count*sizeof(char *));
		for(i=0; i<gs_source_count; i++) gs_source_name[i] = strdup(argv[i+optind]);
	}
	else {
		if(gs_result_file) {
			if((slash= strrchr(gs_job_file, DIRECTORIES_TERM)) != 0)
				strcpy(gs_job_file, slash+1);
			len = strlen(gs_work_dir) + 1;
			memmove(gs_result_file+len, gs_result_file, strlen(gs_result_file)+1);
			strcpy(gs_result_file, gs_work_dir);
			*strchr(gs_result_file, '\0') = DIRECTORIES_TERM;
			memmove(gs_job_file+len, gs_job_file, strlen(gs_job_file)+1);
			strcpy(gs_job_file, gs_work_dir);
			*strchr(gs_job_file, '\0') = DIRECTORIES_TERM;
		}
	}
	if (!gs_logfile) {
		len = strlen(gs_work_dir);
		if(len && (gs_logfile = (char *)malloc(len+10)) != 0){
			memcpy(gs_logfile, gs_work_dir, len);
			gs_logfile[len] =DIRECTORIES_TERM;
			memcpy(gs_logfile+len+1, "gm.log", 7);
			create_log(gs_logfile, 0);
			free(gs_logfile);
		}
	}
	return use_job;
}


int get_garant_root(char *argv0)
{
	int set;

	argv0 = strdup(argv0);
	set = 0;
	gs_cwd = (char *)malloc(512);
	getcwd(gs_cwd, 512);
	gs_work_dir = (char *)malloc(512);
	strcpy(gs_work_dir, gs_cwd);
	gs_garant_root = (char *)malloc(512);
#if defined(__WIN32__) || defined(__GO32__)
	if(argv0[1] != ':') // Not the full path
		bzero((caddr_t)gs_garant_root, 512);
	else {
		strcpy(gs_garant_root, argv0);
		*(strrchr(gs_garant_root, DIRECTORIES_TERM)) = '\0';
		*((strrchr(gs_garant_root, DIRECTORIES_TERM))+1) = '\0';
		set = 1;
	}
#else
	bzero((caddr_t)gs_garant_root, 512);
#endif
	free(argv0);
	return set;
}

