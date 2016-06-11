/*-----------------------------------------------------------------------*
 * filename - pureerr.cpp
 * Error routine linked in when pure function called
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1990, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 32029 $        */

/*
   A pointer to this routine is linked into virtual vectors whenever
   a virtual function has been declared pure.  Ideally, the error
   message should be printed without using printf or stream I/O,
   since we would rather not pull in the code for those.  Such a
   result is system-dependent and beyond the scope of this implementation.
*/

#include <_io.h>
#if !defined(MINIRTL_EDG) /* Not suported by EDG */
/* Enable standard stack frame so the debugger guys don't
   get so grouchy when stepping in the debugger.
*/
#pragma option -k
#endif
extern "C" void _RTLENTRY _pure_error_()
{
    _ErrorExit("Pure virtual function called");
}
