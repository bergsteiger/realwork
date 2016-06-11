/* system function */
#include <stdlib.h>
_STD_BEGIN

 #if _USE_EXISTING_SYSTEM_NAMES
  #define _Execl execl
  #define _Fork  fork
  #define _Wait  wait
 #endif /* _USE_EXISTING_SYSTEM_NAMES */

 #if _HAS_POSIX_C_LIB
_EXTERN_C
int _Execl(const char *, const char *, ...);
int _Fork(void);
int _Wait (int *);
_END_EXTERN_C

int (system)(const char *s)
	{	/* send text to system command line processor */
	if (s)
		{	/* not just a test */
		int pid = _Fork();

		if (pid < 0)
			;	/* fork failed */
		else if (pid == 0)
			{	/* continue here as child */
			_Execl("/bin/sh", "sh", "-c", s, 0);
			exit(EXIT_FAILURE);
			}
		else	/* continue here as parent */
			while (_Wait(0) != pid)
				;	/* wait for child */
		}
	return (-1);
	}

 #elif _DUMMY_C_LIB || defined(_WIN32_WCE)
int (system)(const char *s)
	{	/* send text to system command line processor */
	return (-1);
	}

 #else /* _LIB version */
	/* revert to system library */
 #endif /* _LIB version */

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
