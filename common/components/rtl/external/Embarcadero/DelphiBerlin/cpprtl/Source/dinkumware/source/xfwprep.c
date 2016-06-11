/* _Fwprep function */
#include <stdlib.h>
#include "xstdio.h"
_STD_BEGIN

int _Fwprep(FILE *str)
	{	/* prepare stream for writing */

 #ifdef _WIN32_WCE
	if (str->_Handle != 0)
		;
	else if (str == &_Stdout
		&& (str->_Handle = _Fopen(_SYSCH("stdout.txt"), str->_Mode, 0)) != 0)
		;
	else if (str == &_Stderr
		&& (str->_Handle = _Fopen(_SYSCH("stderr.txt"), str->_Mode, 0)) != 0)
		;
	else
		return (-1);
 #endif /* _WIN32_WCE */

	if (str->_Next < str->_Wend)
		return (0);
	else if ((str->_Mode & (_MOPENW | _MREAD | _MWIDE)) != _MOPENW)
		{	/* can't write after read */
		str->_Mode |= str->_Mode & _MWIDE
			? _MERR : _MERR | _MBYTE;
		return (-1);
		}
	else if ((str->_Mode & (_MWRITE | _MBYTE)) != (_MWRITE | _MBYTE))
		;	/* haven't been writing */
	else if (str->_Next < str->_Bend)
		;	/* open up rest of existing buffer */
	else if (fflush(str))
		return (-1);	/* failed to flush full buffer */

	if ((str->_Mode & _MNBF) != 0
		|| str->_Buf != &str->_Cbuf)
		;	/* no need to buy a buffer */
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
		str->_WRend = str->_Buf;
		str->_WWend = str->_Buf;
		_Closreg();
		}
	str->_Rend = str->_Buf;
	str->_Wend = str->_Bend;
	str->_Mode |= _MWRITE | _MBYTE;
	return (0);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
