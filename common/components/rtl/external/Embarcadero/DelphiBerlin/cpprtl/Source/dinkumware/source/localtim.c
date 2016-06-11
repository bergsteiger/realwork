/* localtime function */
#include <stdlib.h>
#include "xmtloc.h"
#include "xtime.h"
_STD_BEGIN

#define MAXTZ	(100 * 13)	/* biggest valid HHMM offset from UTC */

typedef const char *old_t;

_TLS_DATA_DEF(static, old_t, oldzone, 0);
_TLS_DATA_DEF(static, long, tzoff, 0);

time_t _Tzoff(void)
	{	/* determine local time offset */
	old_t *poldzone = _TLS_DATA_PTR(oldzone);
	_Tinfo *ptimes = _TLS_DATA_PTR(_Times);
	long *ptzoff = _TLS_DATA_PTR(tzoff);

	if (*poldzone != ptimes->_Tzone)
		{	/* determine time zone offset (East is +) */
		const char *p, *pe;
		int n;

		if (ptimes->_Tzone[0] == '\0')
			ptimes->_Tzone = _Getzone();
		p = _Gettime(ptimes->_Tzone, 2, &n);
		*ptzoff = strtol(p, (char **)&pe, 10);
		if (pe - p != n
			|| *ptzoff <= -MAXTZ || MAXTZ <= *ptzoff)
			*ptzoff = 0;
		*ptzoff -= (*ptzoff / 100) * 40;	/* HHMM -- changed for C9X */
		*ptzoff = -*ptzoff;	/* also change sense of offset for C9X */
		*poldzone = ptimes->_Tzone;
		}
	return (-*ptzoff * 60);
	}

struct tm *(localtime)(const time_t *tod)
	{	/* convert to local time structure */
	return (_Ttotm(0, *tod + _Tzoff(), -1));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
