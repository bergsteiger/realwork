// xstart -- C++ early startup/late cleanup code
#include <cstdio>	/* for _HAS_DINKUM_CLIB */
#include <cstdlib>
#include <yvals.h>

 #if _HAS_DINKUM_CLIB		/* compiler test */ \
	&& (defined(__MINGW32__) || defined(__BORLANDC__))
 #include <fenv.h>
 #define SET_FPP
 #endif /* _HAS_DINKUM_CLIB etc. */

 // make sure that the atexit list is destroyed after all user code completes
 #pragma init_seg(compiler)

 _C_STD_BEGIN


		// FINALIZATION CODE
_EXTERN_C
#define NATS	10	/* fclose, xgetloc, locks, facet free, etc. */

		/* static data */
static void (*atfuns[NATS])(void) = {0};
static size_t atcount = {NATS};

void (_Atexit)(void (*pf)(void))
	{	// add to wrapup list
	if (atcount == 0)
		abort();	/* stack full, give up */
	else
		atfuns[--atcount] = pf;
	}
_END_EXTERN_C

struct _Init_atexit
	{	// controller for atexit processing

 #if _HAS_DINKUM_CLIB	/* compiler test */
	_Init_atexit()
		{	// force lock _Atexit registration first
		_Locksyslock(0);
		_Unlocksyslock(0);

 #ifdef SET_FPP
		fesetenv(FE_DFL_ENV);	// correct FPP mode
 #endif /* SET_FPP */

		}
 #endif /* _HAS_DINKUM_CLIB */

	~_Init_atexit()
		{	// process wrapup functions
		while (atcount < NATS)
			(*atfuns[atcount++])();
		}
	};

static _Init_atexit init_atexit;	// initialize atexit stack
_C_STD_END

#include <iostream>	/* must follow init_atexit, do not move to top! */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
