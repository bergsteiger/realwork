/* _Fofind function */
#include <stdlib.h>
#include "xstdio.h"
_STD_BEGIN

FILE *_Fofind(void)
	{	/* find an available FILE */
	FILE *str = 0;
	size_t i;

	for (i = 0; i < FOPEN_MAX; ++i)
		if (_Files[i] == 0)
			{	/* setup empty _Files[i] */
			str = (FILE *)malloc(sizeof (FILE));
			if (str == 0)
				break;
			_Files[i] = str;
			str->_Mode = _MALFIL;
			str->_Idx = (unsigned char)i;
			break;
			}
		else if (_Files[i]->_Mode == 0)
			{	/* setup preallocated _Files[i] */
			str = _Files[i];
			str->_Mode = (unsigned short)~_MALFIL;
			break;
			}
	return (str);
	}

void _Fofree(FILE *str)
	{	/* free an unopened/closed FILE */
	if (str->_Mode & _MALFIL)
		{	/* find _Files[i] entry and free */
		size_t i;

		for (i = 0; i < FOPEN_MAX; ++i)
			if (_Files[i] == str)
				{	/* found entry */
				_Files[i] = 0;
				break;
				}
		free(str);
		}
	else
		{	/* tidy a preallocated FILE */
		str->_Mode = 0;
		str->_Handle = _FD_INVALID;
		str->_Buf = &str->_Cbuf;
		str->_Next = &str->_Cbuf;
		str->_Rend = &str->_Cbuf, str->_WRend = &str->_Cbuf;
		str->_Wend = &str->_Cbuf, str->_WWend = &str->_Cbuf;
		str->_Rback = str->_Back + sizeof (str->_Back);
		str->_WRback = str->_WBack
			+ sizeof (str->_WBack) / sizeof (wchar_t);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
