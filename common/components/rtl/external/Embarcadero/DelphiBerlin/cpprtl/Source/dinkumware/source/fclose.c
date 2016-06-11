/* fclose function */
#include <stdlib.h>
#include "xmtx.h"
#include "xstdio.h"
#include "yfuns.h"
_STD_BEGIN

static _Once_t closeallreg_o = _ONCE_T_INIT;

static void closeall(void)
	{	/* close all files at exit */
	size_t i;

	for (i = 0; i < FOPEN_MAX; ++i)
		if (_Files[i] != 0)
			fclose(_Files[i]);
	}

static void closeallreg(void)
	{	/* register closeall with _Atexit */
	_Locksyslock(_LOCK_STREAM);	/* lock cleanup must be registered first! */
	_Atexit(&closeall);
	_Unlocksyslock(_LOCK_STREAM);
	}

void _Closreg(void)
	{	/* make sure closeall is registered */
	_Once(&closeallreg_o, closeallreg);
	}

int (fclose)(FILE *str)
	{	/* close a stream */
	int stat;

	if ((str->_Mode & (_MOPENR | _MOPENW)) == 0
		|| !_FD_VALID(str->_Handle))
		{	/* invalid FILE pointer or open failure */
		_Locksyslock(_LOCK_STREAM);
		_Fofree(str);
		_Unlocksyslock(_LOCK_STREAM);
		stat = EOF;
		}
	else
		{	/* looks like valid open file, drain and close */
		stat = fflush(str);

		_Locksyslock(_LOCK_STREAM);
		if (str->_Mode & _MALBUF)
			free(str->_Buf);
		str->_Buf = 0;

		if (_Fclose(str))
			stat = EOF;

		if (str->_Tmpnam != 0)
			{	/* remove temp file */
			if (remove(str->_Tmpnam))
				stat = EOF;
			free(str->_Tmpnam), str->_Tmpnam = 0;
			}

		_Fofree(str);
		_Unlocksyslock(_LOCK_STREAM);
		}
	return (stat);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
