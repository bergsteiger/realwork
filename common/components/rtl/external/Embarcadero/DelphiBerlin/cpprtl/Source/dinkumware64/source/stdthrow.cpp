// stdthrow -- terminate on thrown exception REPLACEABLE
#include <cstdio>
#include <cstdlib>
#include <exception>
_STD_BEGIN
_CRTIMP2 void _CDECL _Debug_message(const char *mesg,
	const char *fname, unsigned int line)
	{	// report error and die
	_CSTD fflush(0);
	_CSTD fputs("error: ", stderr);
	_CSTD fputs(mesg, stderr);
	if (fname != 0)
		{	// display file name
		_CSTD fputs(": ", stderr);
		_CSTD fputs(fname, stderr);
		if (0 < line)
			{	// display line
			char buf[16];
			char *p = buf + sizeof (buf);

			for (*--p = '\0'; 0 < line && buf < --p; line /= 10)
				*p = (char)('0' + line % 10);
			_CSTD fputs(": line ", stderr);
			_CSTD fputs(p, stderr);
			}
		}
	_CSTD fputs("\n", stderr);
	_CSTD abort();
	}
_STD_END

_X_STD_BEGIN
_CRTIMP2P void _PCDECL _Throw(const exception& ex)
	{	// report throw exception and die
	_STD _Debug_message("exception", ex.what(), 0);
	}
_X_STD_END

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
