/*------------------------------------------------------------------------
 * filename - um.h - helper file for um.c
 *
 * function(s)
 *
 *   _rtl_unmangle
 *   _rtl_setUnmangleMode
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1988, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 23325 $        */

#ifndef __UM_H
#define __UM_H

#include <windows.h>                      /* prototype for wsprintf */
#define sprintf wsprintf                  /* so that the RTL's vprinter */
                                          /*   doesn't come in */

#include <unmangle.h>

#define unmangle        _rtl_unmangle        /* the RTL version */
#define setUnmangleMode _rtl_setUnmangleMode /* the RTL version */
#define MAXBUFFLEN      _UM_MAXBUFFLEN
#define umKind          _umKind
#define UMAPI           _UMAPI

#endif /* __UM_H */
