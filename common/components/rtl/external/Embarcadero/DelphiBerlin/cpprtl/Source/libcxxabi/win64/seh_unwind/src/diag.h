/* **************************************************************************
 *                                                                          *
 * diag.c --- Run-time support for debug facilities.                        *
 *                                                                          *
 ***************************************************************************/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/***************************************************************************
 * Comments:
 *	
 *	Here's how the debug environment supported by this file works:
 *
 *	There are roughly four levels of debugging support which
 *	correspond to the four grades of customers.	 #define DEBUG_LEVEL
 *	to be any one of the following (default is DL_LIGHT):
 *	
 *	DL_HEAVY (3)
 *	   This debug level is meant to be used by the developers working
 *	   on the code, and his or her supporting QA engineers.	 To them,
 *	   it matters more that the code is working than that it runs
 *	   quickly.	 Generally this ought to mean a 10-40% reduction in
 *	   speed, but at the gain of substantial checking, such as
 *	   assertions in tight loops, confidence testing of critical data
 *	   structures, etc.
 *	
 *	DL_MEDIUM (2)
 *	   This debug level is meant for point releases and beta testers.
 *	   It generally means a 5-20% reduction in speed.
 *	
 *	DL_LIGHT (1) or DL_NONE (0)
 *	   These two levels are for the final builds.  For GUI
 *	   applications, or long-running applications, DL_NONE is to be
 *	   preferred, but for one-shot tasks (such as compiling, linking,
 *	   etc.), DL_LIGHT is better.
 *	
 *	Facilities:
 *	
 *	assert(expr)
 *	   A plain old assert function call is available in DL_LIGHT and
 *	   above.
 *	
 *	ASSERT(expr)
 *	   The ASSERT macro is meant for more speed critical tests.	 It is
 *	   available in DL_MEDIUM and above.
 *	
 *	CONFIRM(expr)
 *	   The CONFIRM macro is reserved for really resource intensive
 *	   tests.  It is available only in DL_HEAVY.
 *	
 *	DEBUG_CODE(classification, expr)
 *	   The DEBUG macro is available in DL_MEDIUM and above.	 Each
 *	   debug macro is classified, and will only be active if the
 *	   environment variable DEBUG_CLASS includes its classification.
 *	   Each classification is a dot-separated list of
 *	   SYSTEM.SUBSYSTEM.AREA.  For example:
 *	   "ilink32.mapfile.generate", or "bcc32.expr.assign".
 *	
 *	   The DEBUG_CLASS environment variable can include shell globbing
 *	   characters, and multiple classifications can be listed
 *	   separated by semi-colons: "?link*.mapfile.*;bcc32.*" (view
 *	   mapfile debug code for both tlink and ilink, 16-bit and 32-bit,
 *	   and all debug code for bcc32).
 *	
 *	   The simplest form of the DEBUG macro includes a classification
 *	   string and an expression:
 *	
 *		  DEBUG_CODE("ilink32.mapfile.generate", x = 1);
 *		  DEBUG_PRINT("ilink32.mapfile.generate", ("got here"));
 *		
 *	   For many macro invocations of the same class, use the
 *	   DEBUG_CLASS macro in your variable definition section (global
 *	   or local), and the DEBUG_ variant:
 *	
 *		  int foo() {
 *			 DEBUG_CLASS("ilink32.mapfile.generate");
 *			
 *			 DEBUG_PRINT_(("Hey!\n"));
 *			 DEBUG_PRINT_(("hello\n"));
 *			 DEBUG_PRINT_(("world\n"));
 *		  }
 *		
 *	   Another form for multiple expressions is DEBUG_IF and
 *	   DEBUG_IF_:
 *	
 *		  DEBUG_IF("ilink32.mapfile.generate") {
 *			 printf("'ptr' was not set at %s, line %ld", __FILE__,
 *					__LINE__);
 *		  }
 *
 ************************************************************************/

#ifndef DIAG_H
#define DIAG_H

#ifdef	__cplusplus
extern "C" {
#endif

#define DL_NONE		 0
#define DL_LIGHT	 1
#define DL_MEDIUM	 2
#define DL_HEAVY	 3

#define MAX_CLASSES	 256

/* Define DEBUG_LEVEL if not already defined  */

#if !defined(DEBUG_LEVEL)
	#if defined(ALPHA_TEST)
		#define DEBUG_LEVEL DL_HEAVY
	#elif defined(BETA_TEST)
		#define DEBUG_LEVEL DL_MEDIUM
	#elif defined(GAMMA_TEST)
		#define DEBUG_LEVEL DL_LIGHT
	#elif defined(RTM)
		#define DEBUG_LEVEL DL_NONE
	#endif
#endif

#ifndef DEBUG_LEVEL
	#define DEBUG_LEVEL DL_LIGHT
#endif

/* Declare prototypes  */

#if DEBUG_LEVEL >= DL_MEDIUM || defined(COMPILING_DIAG)
	#include <stdio.h>

	int debug_is_enabled(void);
	int debug_class_enabled(const char *dbcls);
	void debug_enable(void);
	void debug_disable(void);
	int debug_init(void);
	FILE *debug_file(void);
	int debug_shutdown(void);
#ifdef DEBUG_INDENTING_STACK
	int debug_indent(char *fn, int);
#else
	int debug_indent(int);
#endif
	int debug_indent_level(void);
	int debug_print(const char *format, ...);
	int debug_continue(const char *format, ...);
#endif

/* Define assertion/verification macros  */

#if DEBUG_LEVEL >= DL_LIGHT
	/* empty case */
#else
	#ifdef assert
		#undef assert
	#endif
	#define assert(x)	((void)0)

	#ifdef assert0
		#undef assert0
	#endif
	#define assert0(x)	((void)0)
#endif
#if DEBUG_LEVEL >= DL_LIGHT
	#define VERIFY(x)	assert(x)
#else
	#define VERIFY(x)	((void)0)
#endif

#if DEBUG_LEVEL >= DL_MEDIUM
	#define ASSERT(x)	assert(x)
#else
	#define ASSERT(x)	((void)0)
#endif

#if DEBUG_LEVEL >= DL_HEAVY
	#define CONFIRM(x)	assert(x)
	#define VLD_CODE(x)	x
#else
	#define CONFIRM(x)	((void)0)
	#define VLD_CODE(x)
#endif

/* Define synonyms for assert macros  */

#ifndef DEBUG_VERIFY
	#define DEBUG_VERIFY(x) VERIFY(x)
#endif
#ifndef DEBUG_ASSERT
	#define DEBUG_ASSERT(x) ASSERT(x)
#endif
#ifndef DEBUG_CONFIRM
	#define DEBUG_CONFIRM(x) CONFIRM(x)
#endif

/* Define print and diagnostic macros  */

#if DEBUG_LEVEL >= DL_MEDIUM

	#define DEBUG_CODE_ON	(1)

	#define DEBUG_IF(dbcls)				if (debug_class_enabled(dbcls))
	#define DEBUG_IF_()					if (debug_class_enabled(_debug_class))
	#define DEBUG_CODE(dbcls, expr)		do { if (debug_class_enabled(dbcls)) (expr); } while(0)
	#define DEBUG_CLASS(dbcls)			static char *_debug_class = (dbcls)
	#define DEBUG_CODE_(expr)			do { if (debug_class_enabled(_debug_class)) expr; } while(0)
#ifdef DEBUG_INDENTING_STACK
	#define DEBUG_INDENT(n)				debug_indent(__FUNCTION__, n);
	#define DEBUG_OUTDENT(n)			debug_indent(__FUNCTION__, -(n));
#else
	#define DEBUG_INDENT(n)				debug_indent(n);
	#define DEBUG_OUTDENT(n)			debug_indent(-(n));
#endif
	#define DEBUG_PRINT(dbcls, args)	DEBUG_CODE(dbcls, debug_print args );
	#define DEBUG_CONTINUE(dbcls, args)	DEBUG_CODE(dbcls, debug_continue args );
	#define DEBUG_PRINT_(args)			DEBUG_CODE_(debug_print args );
	#define DEBUG_CONTINUE_(args)		DEBUG_CODE_(debug_continue args );
	#define DEBUG_INIT()				debug_init();
	#define DEBUG_FILE()				(debug_file())
	#define DEBUG_SHUTDOWN()			debug_shutdown();
	#define DEBUG_OUTPUT(arg)			(arg)
	#define DEBUG_ENABLE()				debug_enable();
	#define DEBUG_DISABLE()				debug_disable();
	#define DEBUG_IS_ENABLED()			(debug_is_enabled())

	#define DEBUG_ENABLED 1
		
#else /* DEBUG_LEVEL == DL_MEDIUM */

	#define DEBUG_CODE_ON (0)

	#define DEBUG_IF(class)			if	(0)
	#define DEBUG_IF_()				if	(0)
	#define DEBUG_CODE(dbcls, expr)	
	#define DEBUG_CLASS(dbcls)	
	#define DEBUG_INDENT(n)
	#define DEBUG_OUTDENT(n)
	#define DEBUG_CODE_(expr)
	#define DEBUG_PRINT(dbcls, args)
	#define DEBUG_CONTINUE(dbcls, args)	
	#define DEBUG_PRINT_(args)
	#define DEBUG_CONTINUE_(args)
	#define DEBUG_INIT()
	#define DEBUG_FILE()			NULL
	#define DEBUG_SHUTDOWN()
	#define DEBUG_OUTPUT(arg)
	#define DEBUG_ENABLE()
	#define DEBUG_DISABLE()
	#define DEBUG_IS_ENABLED()			0

#endif /* DEBUG_LEVEL == DL_MEDIUM */

/* Miscelaneous defines  */

#if DEBUG_CODE_ON
	#define DEBUG_BOOL(x) ((x) ? "true" : "false")
	#if defined(RTM)
		/* ensure that no debugging code is enabled
		   when an RTM build is created!  */
		#undef DEBUG_CODE_ON
	#endif
#else
	#define DEBUG_BOOL(x)
#endif

#ifdef	__cplusplus
}
#endif
#endif /* _DEBUG_H */
