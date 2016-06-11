/*------------------------------------------------------------------------
 * filename - patexit.c
 *
 * function(s)
 *        __pCallAtExitProcs - default pointer to routine to call atexit
 *                             procs.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1997, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

/*
    When the user calls atexit to register a function, this pointer will
    be pointed to a routine that will call all the procs.  Then either the
    exit function (for an .EXE) or startupd (for a .DLL) will call through
    this pfn to cause any/all registered atexit procs to be executed.
*/

void (*__pCallAtExitProcs) (void) = 0;