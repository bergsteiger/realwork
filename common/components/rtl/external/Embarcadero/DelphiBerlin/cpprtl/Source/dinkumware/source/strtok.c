/* strtok function */
#include <string.h>
#include "xtls.h"
_STD_BEGIN

typedef char *pchar_t;

_TLS_DATA_DEF(static, pchar_t, ssave, "");

char *(strtok)(char *_Restrict s1, const char *_Restrict s2)
	{	/* find next token in s1[] delimited by s2[] */
	char *sbegin, *send;
	pchar_t *pssave = _TLS_DATA_PTR(ssave);

	sbegin = s1 ? s1 : *pssave;
	sbegin += strspn(sbegin, s2);
	if (*sbegin == '\0')
		{	/* end of scan */
		*pssave = "";	/* for safety */
		return (0);
		}
	send = sbegin + strcspn(sbegin, s2);
	if (*send != '\0')
		*send++ = '\0';
	*pssave = send;
	return (sbegin);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
