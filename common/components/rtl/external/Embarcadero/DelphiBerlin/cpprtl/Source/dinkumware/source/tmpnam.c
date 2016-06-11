/* tmpnam function */
#include <stdlib.h>
#include <string.h>
#include "xstdio.h"
_STD_BEGIN

 #if L_tmpnam < 13
  #error BAD ASSUMPTION ABOUT L_tmpnam
 #endif /* L_tmpnam < 13 */

 #if _USE_EXISTING_SYSTEM_NAMES
  #define _Getpid	getpid
 #endif /* _USE_EXISTING_SYSTEM_NAMES */

 #if _HAS_POSIX_C_LIB
_EXTERN_C
int _Getpid(void);
_END_EXTERN_C
 #endif /* _HAS_POSIX_C_LIB */

char *(tmpnam)(char *s)
	{	/* create a temporary file name */
	char *p;
	int i;
	unsigned short t;
	static char buf[L_tmpnam] = {0};
	static unsigned short seed = 0;

 #if _HAS_POSIX_C_LIB
	_Locksyslock(_LOCK_MALLOC);
	if (s == 0)
		s = buf;
	seed = seed == 0 ? _Getpid() << 6 : seed + 1;
	strcpy(s, "/tmp/d");
	i = 7;
	p = s + strlen(s) + i;
	*p = '\0';

 #elif _WIN32_C_LIB
	static char root[L_tmpnam] = {0};

	_Locksyslock(_LOCK_MALLOC);
	if (s == 0)
		s = buf;
	if (root[0] != '\0')
		;
	else if ((p = getenv("TEMP")) == 0
		|| L_tmpnam < strlen(p) + 14)
		strcpy(root, "ctm");
	else
		{	/* setup root directory */
		strcpy(root, p);
		strcat(root, "/ctm");
		}
	++seed;
	strcpy(s, root);
	i = 5;
	p = s + strlen(s) + i;
	strcpy(p, ".tmp");

 #else /* dummy version */
	_Locksyslock(_LOCK_MALLOC);
	if (s == 0)
		s = buf;
	++seed;
	strcpy(s, "ctm");
	i = 5;
	p = s + strlen(s) + i;
	strcpy(p, ".tmp");
 #endif /* _LIB version */

	for (t = seed; 0 <= --i; t >>= 3)
		*--p = (char)('0' + (t & 07));
	_Unlocksyslock(_LOCK_MALLOC);
	remove(s);
	return (s);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
