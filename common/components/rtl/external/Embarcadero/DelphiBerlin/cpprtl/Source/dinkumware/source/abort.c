/* abort function */
#include <stdlib.h>
#include <signal.h>
_STD_BEGIN

void (abort)(void)
	{	/* terminate abruptly */
	raise(SIGABRT);
	exit(EXIT_FAILURE);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
