#ifndef __PLATFORM_H__
	#define __PLATFORM_H__

	#include "osdep.h"

	#ifdef __BORLANDC__
		#include <dos.h>
		#define S_IRWALL S_IREAD | S_IWRITE
		#define bzero(a,b) memset(a, 0, b)
		#define ace_os_ftruncate(a,b) ace_os_ftruncate(a,b)
		#define usleep(s) delay(s)
		int mkstemp(char *fname);
	#elif defined(__MSVC__)

		#define S_IRWALL S_IREAD | S_IWRITE

	#else

		#define S_IRWALL S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH

	#endif
	#include <unistd.h>
	#include <strings.h>

#endif

