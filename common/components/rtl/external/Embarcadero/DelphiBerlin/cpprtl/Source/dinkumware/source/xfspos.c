/* _Fspos function */
#include <errno.h>
#include <yfuns.h>
#include "xstdio.h"
_STD_BEGIN

int _Nnl(FILE *, unsigned char *, unsigned char *);

int _Fspos(FILE *str, const fpos_t *ptr, long loff, int way)
	{	/* position a file */
	if (!(str->_Mode & (_MOPENR | _MOPENW)) || fflush(str))
		return (EOF);

	if (ptr)
		loff += (long)ptr->_Off;	/* fsetpos */
	if (way == SEEK_CUR && str->_Mode & _MREAD)
		loff -=
			_Nnl(str, str->_Rback,
				str ->_Back + sizeof (str->_Back))
			+ _Nnl(str, str->_Next,
				str->_Rsave != 0 ? str->_Rsave : str->_Rend)
			+ _Nnl(str, str->_Next, str->_WRend);
	if (way == SEEK_CUR && loff != 0 || way == SEEK_END
		|| way == SEEK_SET && loff != -1)
		loff = _Lseek(_FD_NO(str), loff, way);

	if (loff == -1)
		return (EOF);
	else
		{	/* success */
		if (str->_Mode & (_MREAD | _MWRITE))
			{	/* empty buffer */
			str->_Next = str->_Buf;
			str->_Rend = str->_Buf, str->_WRend = str->_Buf;
			str->_Wend = str->_Buf, str->_WWend = str->_Buf;
			str->_Rback = str->_Back + sizeof (str->_Back);
			str->_WRback = str->_WBack
				+ sizeof (str->_WBack) / sizeof (wchar_t);
			str->_Rsave = 0;
			}
		if (ptr)
			str->_Wstate = ptr->_Wstate;
		str->_Mode &= ~(_MEOF | _MREAD | _MWRITE);
		return (0);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
