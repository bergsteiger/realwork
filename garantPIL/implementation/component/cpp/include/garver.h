#ifndef _GARVER_H_
#define _GARVER_H_

#include <stdio.h>

#define GARANT_VERSION "7.12.0"

#define TID_NAMES_LNGG_SIZE 1l
#define RV_SIGNATURE	"GVCF2000"
#define DEFAULT_RV_FILE_NAME "..\\version.rps"
#define DEFAULT_VSTATUS_FORMAT "\x7 Unknown <%s> in Executable module !\n\n"
#define DEFAULT_VERROR_FORMAT "\x7Version control:\n\n\t ERROR: number %d.\n\n"
#define ENGL_NAMES_LIST_SIZE 4l

#define VC_NUMBER_GARANT_DISTR	0l
#define VC_NUMBER_GDK_DISTR		1l
#define VC_ADD_OK 5

#define EXE_MODULE_FORMAT_INFO "\nExecutable module name - [ %s ].\n\n"
#define DISTRIB_FORMAT_INFO "Distribute name - [ %s ]."
#define ENGL_NAMES_LIST_DISTRIB { "IRS_from_\"Garant\"(C)_",GARANT_VERSION,"Developer_Tools_from_\"Garant\"(C)_",GARANT_VERSION }
#define DEFAULT_RV_FILE_MAKE " -z"

#ifdef  __cplusplus
	extern "C" {
#endif
		typedef struct VSPARAM_TAG
		{
			unsigned long exeId;	// exe id
			long lDstrbtd;			// Distrubute index
			FILE *stdOut;			// custom stdout
			char *pDate;			// compiled date
			char *pTime;			// compiled time
			long  lTID_Max;
		} VER_PARAM, *LPVER_PARAM;
		int _imp_GVersion(	int *argc, char *argv[], LPVER_PARAM);

#ifdef  __cplusplus
	}
#endif

#endif
