/*-----------------------------------------------------------------------*
 * filename - wstartup.c
 *
 * function(s)
 *      _init_exit_proc - return address of next _INIT_ proc
 *      _wstartup       - wide-character startup initialization for EXEs
 *      _cleanup        - call _EXIT_ routines
 *      _terminate      - terminate the program
 *      _lock_exit      - lock the atexit lock
 *      _unlock_exit    - unlock the atexit lock
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#define _UNICODE
#include "startup.c"



