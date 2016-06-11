/* _WFwprep function */
#include <stdlib.h>
#include "xwstdio.h"
_STD_BEGIN

int _WFwprep(FILE *str)
	{	/* prepare wide stream for writing */
	if (str->_Next < str->_WWend)
		return (0);
	else if ((str->_Mode & (_MOPENW | _MREAD | _MBYTE)) != _MOPENW)
		{	/* can't write after read */
		str->_Mode |= str->_Mode & _MBYTE
			? _MERR : _MERR | _MWIDE;
		return (-1);
		}
	else if ((str->_Mode & (_MWRITE | _MWIDE)) != (_MWRITE | _MWIDE))
		;	/* haven't been writing */
	else if (str->_Next < str->_Bend)
		;	/* open up rest of existing buffer */
	else if (fflush(str))
		return (-1);	/* failed to flush full buffer */
	if ((str->_Mode & (_MNBF | _MLBF)) != 0
		|| str->_Buf != &str->_Cbuf)
		;
	else if ((str->_Buf = (unsigned char *)malloc(BUFSIZ)) == 0)
		{	/* use 1-char _Cbuf */
		str->_Buf = &str->_Cbuf;
		str->_Next = str->_Buf;
		str->_Bend = str->_Buf + 1;
		_Closreg();
		}
	else
		{	/* use allocated buffer */
		str->_Mode |= _MALBUF;
		str->_Next = str->_Buf;
		str->_Bend = str->_Buf + BUFSIZ;
		str->_Rend = str->_Buf;
		str->_Wend = str->_Buf;
		_Closreg();
		}
	str->_WRend = str->_Buf;
	str->_WWend = str->_Bend;
	str->_Mode |= _MWRITE | _MWIDE;
	return (0);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
