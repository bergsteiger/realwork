#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#include <string.h>

#ifndef PTRS_IN_META
	#include "profile.h"
#endif

char *gs_target_name;
char *gs_dest_path;
char **gs_source_name;
char *gs_job_file;
char *gs_result_file;
char *gs_work_dir = 0;
char *gs_cwd;
char *gs_garant_root;
char *gs_logfile = 0;
int gs_source_count;
int gs_options=1;
int b_sawbase = 0;

extern	unsigned short errLastError;
char	formatErrorOut[]="\n\n job file format error: 0x%x";

void free_settings(int count)
{
	int i;

	for(i=0; i<count; i++)
		free(gs_source_name[i]);
	free(gs_dest_path);
	free(gs_job_file);
}

int read_settings()
{
	char entry[65];
	int i;
	char *s;

	if(!gs_job_file)
		return 0;
	if(!SetProfile(gs_job_file) || !ReadProfileInt("General", "SourceCount", &gs_source_count)){
		printf(formatErrorOut, errLastError);
		return 0;
	}
	gs_target_name = (char *)malloc(1024);
	if(!ReadProfileString("General", "Destination", gs_target_name, 1023)) {
		printf(formatErrorOut, errLastError);
		free(gs_target_name);
		return 0;
	}
	s = strrchr(gs_target_name, '\0');
	do s--;
	while(isspace((int)(*s)));
	s[1] = '\0';
	if(!strcmp(s-3, ".ndt") || !strcmp(s-3, ".NDT")) *(s-3) = '\0';
	gs_source_name = (char **)malloc(gs_source_count*sizeof(char *));
#ifndef OLD_CODE
	memset((void *)gs_source_name, 0, gs_source_count*sizeof(char *));
#else
	bzero((void *)gs_source_name, gs_source_count*sizeof(char *));
#endif
	for(i=0; i<gs_source_count; i++) {
		if(gs_source_name[i]) free(gs_source_name[i]);
		gs_source_name[i] = (char *)malloc(1024);
		sprintf(entry, "File%d", i+1);
		if(!ReadProfileString("Source", entry, gs_source_name[i], 1023)) {
			printf(formatErrorOut, errLastError);
			free_settings(i);
			return 0;
		}
		s = strrchr(gs_source_name[i], '\0');
		do s--;
		while(isspace((int)(*s)));
		s[1] = '\0';
		if(!strcmp(s-3, ".ndt") || !strcmp(s-3, ".NDT")) *(s-3) = '\0';
	}
	return 1;
}


