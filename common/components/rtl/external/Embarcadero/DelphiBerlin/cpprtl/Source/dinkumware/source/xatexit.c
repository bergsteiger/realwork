/* _Atexit function */
#include <stdlib.h>
_STD_BEGIN

		/* external declarations */
extern void (**_Atfuns)(void);
extern size_t _Atcount;
extern size_t _Atcount0;
int _Atrealloc(void);

_CRTIMP2 void (_Atexit)(void (*func)(void))
	{	/* register function to call at exit */
	if (_Atcount <= _Atcount0 && _Atrealloc() == 0)
		abort();	/* both stacks are full, give up */
	else
		_Atfuns[--_Atcount] = func;	/* library wrapup stack */
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
