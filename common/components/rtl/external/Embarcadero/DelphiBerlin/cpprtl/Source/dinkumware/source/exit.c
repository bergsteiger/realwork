/* exit function */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "yfuns.h"
_STD_BEGIN

		/* MACROS */
#define NATS	80	/* 64 + extra for fclose, xgetloc, locks, etc. */

		/* TYPES */
typedef void (**Ppvoidfn)(void);

		/* STATIC DATA */
static void (*_Atdata[NATS])(void) = {0};
static size_t _Nats = {NATS};

Ppvoidfn _Atfuns = {&_Atdata[0]};
size_t _Atcount = {NATS};
size_t _Atcount0 = {0};

_NO_RETURN(_Exit(int));

int _Atrealloc(void)
	{	/* try to reallocate atexit stack */
	size_t inc = _Nats / 2;	/* increase stack size by 50 per cent */
	Ppvoidfn newfuns = (Ppvoidfn)malloc((_Nats + inc) * sizeof (*newfuns));

	if (newfuns == 0)
		return (0);	/* fail */
	else
		{	/* got new atexit stack space, copy over space */
		memcpy(newfuns, _Atfuns, _Atcount0 * sizeof (*newfuns));
		memcpy(newfuns + _Atcount + inc, _Atfuns + _Atcount,
				(_Nats - _Atcount) * sizeof (*newfuns));
		if (_Atfuns != _Atdata)
			free(_Atfuns);

		_Atfuns = newfuns;
		_Atcount += inc;
		_Nats += inc;
		return (1);	/* succeed */
		}
	}

int (atexit)(void (*func)(void))
	{	/* stack function to call at exit */
	int ans;

	_Locksyslock(_LOCK_MALLOC);
	if (_Atcount <= _Atcount0 && _Atrealloc() == 0)
		ans = -1;	/* both stacks are full */
	else
		{	/* enough room, stack function pointer */
		ans = 0;
		_Atfuns[--_Atcount] = func;		/* normal stack */
		}
	_Unlocksyslock(_LOCK_MALLOC);
	return (ans);
	}

void (exit)(int status)
	{	/* tidy up and exit to system */
	while (_Atcount < _Nats)	/* normal stack */
		(*_Atfuns[_Atcount++])();
	while (0 < _Atcount0)	/* library wrapup stack */
		(*_Atfuns[--_Atcount0])();

	if (_Atfuns != &_Atdata[0])
		free(_Atfuns);
	_Atfuns = &_Atdata[0];	/* just in case _Exit messes around */
	_Nats = NATS;
	_Exit(status);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
