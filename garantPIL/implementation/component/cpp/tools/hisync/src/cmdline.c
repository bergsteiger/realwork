#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <strings.h>
#include <alloca.h>

#include "osdep.h"
#include "gdbapi.h"
#include "basemask.h"
                  
#include "log.h"

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

int hs_base_count=0;
int hs_delete =0;
char *hs_output_path =0;
char *hs_logfile ="hisync.log";
char **hs_bases, **hs_targets;
char *hs_suffix = 0;

void get_oldname(char *buf, char *fname, int indx);
extern char *GetBasedExtFileName( char *, int);

int parse_cmdline(int argc, char **argv)
{
	int i, c, len;
	char *s;

	while((c=getopt(argc, argv, "sdS:o:l:")) != -1) {
		switch(c) {
			case 'd':
				hs_delete = 1;
				break;
			case 'l':
				hs_logfile = optarg;
				break;
			case 'o':
				hs_output_path = (char *)malloc(strlen(optarg)+2);
				strcpy(hs_output_path, optarg);
				s = strchr(hs_output_path, '\0');
				if(*(s-1) != DIRECTORIES_TERM) {
					*s++ = DIRECTORIES_TERM;
					*s = '\0';
				}
				break;
			case 's':
				hs_logfile = 0;
				break;
			case 'S':
				hs_suffix = optarg;
				break;
			default:
				fprintf(stderr, "Warning: Unrecognized option \"%s\"\n", argv[optind-1]);
				return 0;
				break;
		}
	}
	hs_base_count = argc - optind;
	if (hs_base_count < 2) return 0;
	hs_bases = (char **)malloc((hs_base_count<<1)*sizeof(void *));
	hs_targets = hs_bases + hs_base_count;
	for(i=0; i<hs_base_count; i++) {
		len = strlen(argv[i+optind])+5;
		hs_bases[i] = (char *)malloc(len);
		strcpy(hs_bases[i], argv[i+optind]);
		strcat(hs_bases[i], ".key");
		hs_targets[i] = (char *)malloc(1024);
		if(hs_output_path) {
				s = strrchr(hs_bases[i], DIRECTORIES_TERM);
				if(s)
					s++;
				else
					s = hs_bases[i];
				strcpy(hs_targets[i], hs_output_path);
				strcat(hs_targets[i], s);
		}
		else {
			strcpy(hs_targets[i], argv[i+optind]);
			strcat(hs_targets[i], ".zzz");
		}
	}
	if(hs_logfile) create_log(hs_logfile, 0);
	return 1;
}

void post_renames(pgfile_st *pinpf)
{
	int i, j;
	char *fname;

	if (hs_output_path) return;
	fname = (char *)malloc(1024+1024);
	for(i=0; i<hs_base_count; i++) {
		if (hs_delete){
			j= (pinpf+i)->mode;
			while(j > -1){
				strcpy(fname, hs_bases[i]);
				GetBasedExtFileName( fname, j );
				ace_os_unlink(fname);
				j--;
			}
		}else{
			j= (pinpf+i)->mode;
			while(j > -1){
				strcpy(fname, hs_bases[i]);
				GetBasedExtFileName( fname, j );
				strcpy(fname+1024, fname);
				get_oldname(fname, fname+1024, j);
				ace_os_rename(fname+1024, fname);
				j--;
			}
		}
		while((pinpf+i)->mode > -1){
			strcpy(fname, hs_bases[i]);
			GetBasedExtFileName( fname, (pinpf+i)->mode );
			strcpy(fname+1024, hs_targets[i]);
			GetBasedExtFileName( fname+1024, (pinpf+i)->mode );
			ace_os_rename(fname+1024, fname);
			(pinpf+i)->mode--;
		}
	}
	free(fname);
}

#if defined(__GO32__) || defined(__CYGWIN32__)
#define PATH_SEPARATOR '\\'
#else
#define PATH_SEPARATOR '/'
#endif

void get_oldname(char *buf, char *fname, int indx)
{
	char *s;

	strcpy(buf, fname);
#if defined(__GO32__) || defined(__CYGWIN32__)
	for(s=strchr(buf, PATH_SEPARATOR); s; s=strchr(buf, PATH_SEPARATOR))
		*s++ = '/';
#endif
	s = strrchr(buf, '.');
	if(indx)
		*(s+1)= hs_suffix ? *hs_suffix : 'h';
	else
		strcpy(s+1, hs_suffix ? hs_suffix :
#ifdef MULTI_INDEX_STREAM_FILE
											"hsy.key"
#else
											"hsy"
#endif
												);
}

static void get_filename(char *buf, char *fname)
{
	char *buffer, *s;

#if defined(__GO32__) || defined(__CYGWIN32__)
	buffer = (char *)alloca(512);
	strcpy(buffer, fname);
	for(s=strchr(buffer, PATH_SEPARATOR); s; s=strchr(buffer, PATH_SEPARATOR)) {
		*s = '/';
		s++;
	}
#else
	buffer = fname;
#endif
	s = strrchr(buffer, '/');
	if (!s) s = buffer;
	else s++;
	strcpy(buf, s);
#if defined(__GO32__) || defined(__CYGWIN32__)
	free(buffer);
#endif
}

void usage(void)
{
	printf("Usage : hisync [options] <base1> .. <baseN>\n");
	printf("Options are:\n");
	printf("  -d  replace original files\n");
	printf("  -S <suffix>  use this suffix for original files backup\n");
	printf("  -o <path>  use output directory\n");
	printf("  -l <name>  use this log file name\n");
	printf("  -s  be silent (no logfile at all)\n");
}




