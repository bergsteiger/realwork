
#include "prot401.h"

#include <string.h>


#if !defined(WIN32) && !defined(_WIN32) && !defined(__WIN32__) && !defined(__CYGWIN32__)
extern	void GetSelectors	(void);
#endif
extern	char pathBasesOrigin	[256];
unsigned short GetVolumeSerialNumber( unsigned char DriveNum );



void InitProtDefaults (const char* pathBase)
{
	char* dirRoot = strdup(pathBase);
//	unsigned short aaa;

	int i;
	for(i=0; i<2; i++)
	{
		char* pSeparator;
		if(pSeparator = strrchr(dirRoot,'\\'))
			*pSeparator = '\0';
		else
		{
			dirRoot = NULL;
			break;
		}
	}

	if(dirRoot)
	{
		strcpy(pathBasesOrigin,dirRoot);
		strcat(pathBasesOrigin,"\\BASES.ORG");
	}
	else
	{
		memset(pathBasesOrigin,0,sizeof(pathBasesOrigin));
	}


#if !defined(WIN32) && !defined(_WIN32) && !defined(__WIN32__) && !defined(__CYGWIN32__)
	GetSelectors();
#endif

//	aaa = GetVolumeSerialNumber( 0 );
}

