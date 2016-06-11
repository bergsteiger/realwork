/* raise function */
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
_STD_BEGIN

 #if _USE_EXISTING_SYSTEM_NAMES
  #define _Getpid getpid
  #define _Kill kill
 #endif /* _USE_EXISTING_SYSTEM_NAMES */

 #if _HAS_POSIX_C_LIB
_EXTERN_C
int _Getpid(void);
int _Kill(int, int);
_END_EXTERN_C

int (raise)(int sig)
	{	/* raise a signal */
	return (_Kill(_Getpid(), sig));
	}

 #else /* _LIB version */
int (raise)(int sig)
	{	/* raise a signal */
	_Sigfun *const s = signal(sig, SIG_IGN);

	if (s == SIG_ERR)
		return (-1);	/* bad signal */
	else if (s == SIG_IGN)
		;
	else if (s != SIG_DFL)
		{	/* revert and call handler */
		signal(sig, SIG_DFL);
		(*s)(sig);
		}
	else
		{	/* default handling */
		char ac[10], *p;

		switch (sig)
			{	/* print known signals by name */
		case SIGABRT:
			p = "abort";
			break;
		case SIGFPE:
			p = "arithmetic error";
			break;
		case SIGILL:
			p = "invalid executable code";
			break;
		case SIGINT:
			p = "interruption";
			break;
		case SIGSEGV:
			p = "invalid storage access";
			break;
		case SIGTERM:
			p = "termination request";
			break;
		default:
			*(p = &ac[(sizeof ac) - 1]) = '\0';
			do
				*--p = (char)(sig % 10 + '0');
				while ((sig /= 10) != 0);
			fputs("signal #", stderr);
			}
		fputs(p, stderr);
		fputs(" -- terminating\n", stderr);
		exit(EXIT_FAILURE);
		}
	return (0);
	}
 #endif /* _LIB version */

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
