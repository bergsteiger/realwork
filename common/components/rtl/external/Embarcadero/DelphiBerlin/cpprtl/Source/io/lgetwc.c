/*-----------------------------------------------------------------------*
 * filename - lgetwc.c
 *
 * function(s)
 *    _wffill      - fill up the (wide) read-ahead buffer
 *    _lgetwc      - gets (wide) character from stream without locking
 *                  (multi-thread only)
 *    _fgetwc      - gets character from stream with locking
 *                  (single-thread only)
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
#include "lgetc.c"


