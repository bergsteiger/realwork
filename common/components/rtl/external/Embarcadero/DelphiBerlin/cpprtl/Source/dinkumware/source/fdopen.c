/* fdopen function */
#include <stdlib.h>
#include "xstdio.h"

_STD_BEGIN
FILE *(fdopen)(_FD_TYPE fd, const char *mods)
	{	/* open a file, given fd */
	if (fd < 0 || FOPEN_MAX <= fd)
		return (0);	/* invalid fd */

	if (_Files[fd] == 0)
		{	/* setup empty _Files[i] */
		if ((_Files[fd] = (FILE *)malloc(sizeof (FILE))) == 0)
			return (0);	/* can't allocate FILE */
		_Files[fd]->_Mode = _MALFIL;
		_Files[fd]->_Idx = (unsigned char)fd;
		}
	else if (_Files[fd]->_Mode == 0)
		{	/* setup preallocated _Files[fd] */
		_Files[fd]->_Mode = (unsigned short)~_MALFIL;
		}

	if ((_Files[fd]->_Mode & (_MOPENR | _MOPENW)) != 0)
		return (_Files[fd]);	/* FILE already set up */
	else
		return (_Foprep(0, mods, _Files[fd], fd)); /* set up FILE */
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
