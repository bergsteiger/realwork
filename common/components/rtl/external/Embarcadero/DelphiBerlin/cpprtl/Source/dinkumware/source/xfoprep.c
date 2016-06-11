/* _Foprep function */
#include "xstdio.h"
_STD_BEGIN

FILE *_Foprep(const _Sysch_t *name, const _Sysch_t *mods,
	FILE *str, _FD_TYPE fd)
	{	/* open a stream, or at least make str safe for fclose, macros */
	unsigned short alloced;
	unsigned char idx;
	static const FILE init = {0, 0, _FD_INVALID};

	if (str == 0)
		return (0);
	alloced = (unsigned short)(str->_Mode & _MALFIL);
	idx = str->_Idx;
	*str = init;

	str->_Idx = idx;
	str->_Buf = &str->_Cbuf;
	str->_Next = &str->_Cbuf;
	str->_Rend = &str->_Cbuf, str->_WRend = &str->_Cbuf;
	str->_Wend = &str->_Cbuf, str->_WWend = &str->_Cbuf;
	str->_Rback = str->_Back + sizeof (str->_Back);
	str->_WRback = str->_WBack
		+ sizeof (str->_WBack) / sizeof (wchar_t);
	str->_Mode = (unsigned short)(alloced
		| (*mods == 'r' ? _MOPENR
		: *mods == 'w' ? _MCREAT | _MOPENW | _MTRUNC
		: *mods == 'a' ? _MCREAT | _MOPENW | _MOPENA
		: 0));
	if ((str->_Mode & (_MOPENR | _MOPENW)) == 0)
		{	/* bad mods */
		fclose(str);
		return (0);
		}

	while (*++mods == _SYSCH('b') || *mods == _SYSCH('+'))
		if (*mods == _SYSCH('b'))
			if (str->_Mode & _MBIN)
				break;
			else
				str->_Mode |= _MBIN;
		else
			if ((str->_Mode & (_MOPENR | _MOPENW)) == (_MOPENR|_MOPENW))
				break;
			else
				str->_Mode |= _MOPENR | _MOPENW;

	if (name != 0)
		{	/* not an existing file, open by name */
		str->_Handle = _Fopen(name, str->_Mode, mods);
		if (!_FD_VALID(str->_Handle))
			{	/* open failed */
			fclose(str);
			return (0);
			}
		}
	else if (!_FD_VALID(fd))
		{	/* bad fd */
		fclose(str);
		return (0);
		}
	else
		str->_Handle = fd;

	_Closreg();
	return (str);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
