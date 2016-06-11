/* _WFrprep function */
#include <stdlib.h>
#include "xwstdio.h"
#include "yfuns.h"
_STD_BEGIN

int _WFrprep(FILE *str)
	{	/* prepare stream for reading */
	if (str->_Next < str->_WRend)
		return (1);
	else if (str->_Mode & _MEOF)
		return (0);
	else if ((str->_Mode & (_MOPENR | _MWRITE | _MBYTE)) != _MOPENR)
		{	/* can't read after write */
		str->_Mode |= str->_Mode & _MBYTE
			? _MERR : _MERR | _MWIDE;
		return (-1);
		}
	if ((str->_Mode & (_MNBF | _MLBF)) != 0 || str->_Buf != &str->_Cbuf)
		;
	else if ((str->_Buf = (unsigned char *)malloc(BUFSIZ)) == 0)
		{	/* use 1-char _Cbuf */
		str->_Buf = &str->_Cbuf;
		str->_Bend = str->_Buf + 1;
		}
	else
		{	/* use allocated buffer */
		str->_Mode |= _MALBUF;
		str->_Bend = str->_Buf + BUFSIZ;
		str->_Rend = str->_Buf;
		str->_Wend = str->_Buf;
		}
	str->_Next = str->_Buf;
	str->_WRend = str->_Buf;
	str->_WWend = str->_Buf;
	 {	/* try to read into buffer */
	int n = _Fread(str, str->_Buf, str->_Bend - str->_Buf);

	if (n < 0)
		{	/* report error and fail */
		str->_Mode |= _MERR | _MWIDE;
		return (-1);
		}
	else if (n == 0)
		{	/* report end of file */
		str->_Mode =
			(unsigned short)((str->_Mode & ~_MREAD) | _MEOF | _MWIDE);
		return (0);
		}
	else
		{	/* set up data read */
		str->_Mode |= _MREAD | _MWIDE;
		str->_WRend += n;
		return (1);
		}
	 }
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
