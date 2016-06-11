/*------------------------------------------------------------------------
 * filename - _ostype.h
 *
 *  Operating environment definitions
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1993, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 23293 $ */

#include <_defs.h>

#define _DOS32   1
#define _WIN32S  2
#define _WINNT   4
#define _WIN95   8

extern unsigned _EXPDATA _ostype;    /* The operating environment. */
