/* getenv function -- in-memory version */
#include <stdlib.h>
#include <string.h>
#include "yfuns.h"
_STD_BEGIN

char *(getenv)(const char *name)
	{	/* search environment list for named entry */
 #ifndef _WIN32_WCE
	const char *s;
	size_t n = strlen(name);

	for (s = _Envp; *s; s += strlen(s) + 1)
		{	/* look for name match */
		if (!strncmp(s, name, n) && s[n] == '=')
			return ((char *)&s[n + 1]);
		}
 #endif /* _WIN32_WCE */

	return (0);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
