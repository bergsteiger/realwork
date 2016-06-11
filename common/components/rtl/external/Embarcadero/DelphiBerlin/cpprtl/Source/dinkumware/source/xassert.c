/* _Assert function */
#include <assert.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

 #ifdef _WIN32_WCE
#include "yfuns.h"
#include "wrapwin.h"
_STD_BEGIN

_CRTIMP2 void _Assert(const _Sysch_t *mesg)
	{	/* print assertion message and abort */

 #ifdef _DNK_TEST
	printf("error: Assertion Failed: "); 
	for (; *mesg != 0; ++mesg)
		fputc((char)*mesg, stdout);
	printf("\n");

 #else /* _DNK_TEST */
	_Report(_SYSCH("Assertion Failed"), mesg);
 #endif /* _DNK_TEST */

	fflush(0);
	raise(SIGABRT);
	exit(EXIT_FAILURE);
	}
_STD_END

 #else /* _WIN32_WCE */
_STD_BEGIN

_CRTIMP2 void _Assert(const char *mesg, const char *fun)
	{	/* print assertion message and abort */
	if (fun != 0)
		{	/* put optional function name */
		fputs("In function ", stderr);
		fputs(fun, stderr);
		fputs(" -- ", stderr);
		}
	fputs(mesg, stderr);
	fputs(" -- assertion failed\n", stderr);
	fflush(0);
	raise(SIGABRT);
	exit(EXIT_FAILURE);
	}
_STD_END
 #endif /* _WIN32_WCE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
