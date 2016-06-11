/* **************************************************************************
 *                                                                          *
 * diag.c --- Run-time support for debug facilities.                        *
 *                                                                          *
 * *************************************************************************/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <time.h>
#ifdef	LINUX
#include <unistd.h>	/* for dup */
#endif
#include <assert.h>
#define COMPILING_DIAG
#include "diag.h"

/*
	The initializations below look funny, don't they?  They're there to satisfy
	a limitation in the Delphi object file importer.
*/
#define DIAG_UNINIT ((FILE *)1)
static FILE *_dbfp = DIAG_UNINIT;   /* init to force debug_init call.  */

/*
	The number of times debug_init() since the last debug_shutdown().
	If this value is greater than one, check the logs for a hint.
*/
static int _dbinits;

#define DIAG_INDENTMAX 160
static char _dbindent_string[DIAG_INDENTMAX + 1];
static int _dbindent;

static int _dbenabled;

static const char *_dbclass = 0;

typedef enum { false, true } bool;

/*
 * Function:  glob_match
 *
 * Purpose:	
 *	 See if one string matches another, allowing for globbing
 *	 characters.
 *
 * Returns:	
 *	 'true' if the two strings match, 'false' if not.
 *
 * Notes:
 *   ilink32.*list.info != ilink32.filelist.info because it tries to
 *   match against ilink32.*lelist.info (the first occurance of 'l' on
 *   the line).  The matching strategy needs to continue searching
 *   until the end of the line, more like a state machine would.
 */
static bool glob_match(const char *glob, const char *str)
{
	const char *p = glob, *q = str;
	for	(; *p && *q; p++, q++)
	{
		if	(*p == '*')
		{
			char next = *(p + 1);
			if	(! next)
				return true;
			for	(; *q && *q != next; q++) ;
			if	(! *q)
				return false;
			p++;
		}
		else if	(*p != '?' && *p != *q)
			return false;
	}
	return (! *q && *p == '*' && ! *(p + 1)) || *p == *q;
}


/*
 * Function:  debug_class_enabled
 *
 * Purpose:	
 *	 Test whether a certain debug class has been enabled.  To enable a
 *	 class, set the environment variable DEBUG_CLASS to a series of a
 *	 semi-colon separated globbing patterns that will match to a
 *	 class.
 *
 * Returns:	
 *	 1 if the class is currently enabled, 0 if not.
 */
int debug_class_enabled(const char *dbcls)
{
	static enum { NOT_READ, ENABLED, DISABLED } state = NOT_READ;
	static char *enabled_classes[MAX_CLASSES];
	static int   class_count 			  = 0;
	int	     i;
	char	    *p;
		
	if	(state == NOT_READ)
	{
		char *env_ptr = getenv("DEBUG_CLASS");
		state = env_ptr ? ENABLED : DISABLED;
		if	(env_ptr)
		{
			for	(p = strtok(env_ptr, ";:"); p; p = strtok(NULL, ";:"))
			{
				enabled_classes[class_count] = strdup(p);
				class_count++;
			}
		}
	}
	else if	(state == DISABLED)
		return 0;
		
	for	(i = 0; i < class_count; i++)
	{
		if	(glob_match(enabled_classes[i], dbcls))
		{
			_dbclass = dbcls;
			return 1;
		}
	}
	return 0;
}

static	FILE *	getSTDOUT(void)
{
#ifdef	LINUX
	/* With GNU libc, stdout is a variable with external linkage.  We
	   cannot refer to it in Pascal, because we can't declare external
	   variables.  */
	#undef stdout
	#define stdout do_not_use_stdout_see_function_getSTDOUT

	/* This doesn't work well:
		return fdopen (1, "w");
	   if someone closes the file, we also end up losing the "real"
	   standard output file descriptor as well. */
	int fd = dup(1);
	return fd >= 0 ? fdopen(fd, "w") : fopen("/dev/tty", "w");
#else
	return stdout;
#endif
}

/*
 * Function:  debug_file
 *
 * Purpose:	
 *	 Allow external modules to redirect to the same file
 *   the debugging output stream.
 *
 * Returns:	
 *	 file pointer
 */
FILE *debug_file(void)
{
	return (_dbfp == DIAG_UNINIT) ? NULL : _dbfp;
}

/*
 * Function:  debug_indent_level
 *
 * Returns:	
 *	 indent level
 */
int debug_indent_level(void)
{
	return _dbindent;
}

/*
 * Function:  debug_init
 *
 * Purpose:	
 *	 Initialize the debugging system.  Primarily this means setting
 *   the debugging output stream.
 *
 * Returns:	
 *	 1 if debugging is successfully enabled, 0 if not.
 */
int debug_init(void)
{
	char *p;
	time_t now;

	if	(++_dbinits != 1)
	{
		return 1;
	}
		
	if	(_dbfp == DIAG_UNINIT && 
		(p = getenv("DEBUG_OUT")) != NULL)
	{
		_dbfp = fopen(p, "a+");
		if	(! _dbfp)
		{
			_dbfp = getSTDOUT();
			return 0;
		}
		else
		{
			const char *old_class;

			/* Temporarily set _dbclass to NULL so that the following
			 * debug_print won't have have the class prefixed.
			 */
			old_class = _dbclass;
			_dbclass = NULL;

			time(&now);
			debug_print("**** Debug output: %s", ctime(&now));
			_dbclass = old_class;
		}
	}
	else
	{
			_dbfp = getSTDOUT();
	}
	_dbenabled = 1;
	return 1;
}


/*
 * Function:  debug_shutdown
 *
 * Purpose:	
 *	 Shutdown the debugging system.  Primarily this means closing
 *   the debugging output stream.
 *
 * Returns:	
 *	 1 if debugging is successfully disabled, 0 if not.
 */
int debug_shutdown(void)
{
    	if	(--_dbinits != 0)
		return 0;
		
#ifndef	LINUX
	if	(_dbfp != stdout)
#endif
		if      (_dbfp != 0 && _dbfp != DIAG_UNINIT)
			fclose(_dbfp);
	_dbfp = DIAG_UNINIT;
	return 1;
}

/*
 * Function:  debug_indent
 *
 * Purpose:	
 *	 Increase (or decrease) the amount of spaces to insert before 
 *	 printing the formatted output in each call to debug_print.
 *
 * Returns:	
 *	 The current number of speces to insert.
 */

//#include "glue.h"

#ifdef DEBUG_INDENTING_STACK

#define MAX_FNSTACK 200
static struct
{
	int indent;
	char *fnname;
} _dbfnstack[MAX_FNSTACK];
static int _dbfnstacktop = 0;

// Use a stack to make sure we indent/outdent the same amount.

static void enter_function(char *fn, int indent)
{
    if (_dbfnstacktop < MAX_FNSTACK)
    {
	_dbfnstack[_dbfnstacktop].fnname = fn;
	_dbfnstack[_dbfnstacktop].indent = indent;
	_dbfnstacktop++;
    }
}

static void exit_function(char *fn, int indent)
{
    assert(_dbfnstacktop > 0);
    if (_dbfnstacktop < MAX_FNSTACK)
    {
	_dbfnstacktop--;
	assert( _dbfnstack[_dbfnstacktop].indent == -indent);
    }
}
#endif

#ifdef DEBUG_INDENTING_STACK
int debug_indent(char * fn, int n)
#else
int debug_indent(int n)
#endif
{
	int i;

	if (!_dbenabled)
	    return 0;

	_dbindent += n;

#ifdef DEBUG_INDENTING_STACK
	if (n >= 0)
	    enter_function(fn, n);
	else
	    exit_function(fn, n);
#endif
	assert(!getenv("DEBUG_CLASS") ||
	       (_dbindent >= 0 && _dbindent < DIAG_INDENTMAX));
	if (_dbindent < 0)
	    _dbindent = 0;
	else if (_dbindent > DIAG_INDENTMAX)
	    _dbindent = DIAG_INDENTMAX;
	for (i = 0; i < _dbindent; i++)
	    _dbindent_string[i] = ' ';
	_dbindent_string[_dbindent] = 0;
	return _dbindent;
}


/*
 * Function:  debug_enable/debug_disable
 *
 * Purpose:
 *	 Turn printing of debug output on/off.
 */

void debug_enable(void)
{
    _dbenabled = 1;
}

void debug_disable(void)
{
    _dbenabled = 0;
}

/*
 * Function:  debug_is_enabled
 *
 * Purpose:
 *	 Test if debug output is on/off.
 */

int debug_is_enabled(void)
{
    return _dbenabled;
}


/*
 * Function:  debug_print
 *
 * Purpose:	
 *	 Print out a debugging string to the debug stream.
 *
 * Returns:	
 *	 Return value of vfprintf.
 */
int debug_print(const char *format, ...)
{
	va_list	ap;
	int	ret;

	if	(_dbfp == DIAG_UNINIT) debug_init();
	if	(!_dbenabled) return 0;

	va_start (ap, format);

	if	(_dbclass) fprintf(_dbfp, "%s: ", _dbclass);
	fprintf(_dbfp, "%s", _dbindent_string);
	ret = vfprintf (_dbfp, format, ap);
	fflush(_dbfp);
	va_end (ap);
	return ret;
}

int debug_continue(const char *format, ...)
{
	va_list	ap;
	int	ret;

	if	(_dbfp == DIAG_UNINIT) debug_init();
	if	(!_dbenabled) return 0;

	va_start (ap, format);

	ret = vfprintf (_dbfp, format, ap);
	fflush(_dbfp);
	va_end (ap);
	return ret;
}
