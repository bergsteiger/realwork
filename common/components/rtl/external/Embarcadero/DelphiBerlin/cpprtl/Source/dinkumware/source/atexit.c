/* atexit function */
#include <stdlib.h>
_STD_BEGIN

		/* external declarations */
extern void (**_Atfuns)(void);
extern size_t _Atcount;
extern size_t _Atcount0;
int _Atrealloc(void);

int (atexit)(void (*func)(void))
	{
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
_STD_END

/*
 * Copyright (c) 1992-2002 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V4.00:126I */
