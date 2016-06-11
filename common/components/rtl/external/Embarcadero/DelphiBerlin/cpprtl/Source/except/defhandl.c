/*-----------------------------------------------------------------------*
 * filename - defhandl.c
 *
 * function(s)
 *    __DefHandler - default RTL Exception handler.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#define INCL_USER
#include <ntbc.h>

/*---------------------------------------------------------------------*

Name            __DefHandler - default Exception handler

Usage           ULONG __EHCC __DefHandler(
                             PEXCEPTIONREPORTRECORD p,
                             PEXCEPTIONREGISTRATIONRECORD q,
                             PCONTEXTRECORD r,
                             PVOID s);

Description     This function is called indirectly by the RTL's internal
                exception handler if signal() is not used.  Its parameters
                are the normal exception handling parameters.
                The function performs no action except to return a code
                indicating that the exception was not handled.

Return value    The function returns XCPT_CONTINUE_SEARCH.

*---------------------------------------------------------------------*/
#pragma argsused
ULONG __EHCC __DefHandler(PEXCEPTIONREPORTRECORD p,
                          PEXCEPTIONREGISTRATIONRECORD q,
                          PCONTEXTRECORD r,
                          PVOID s)
{
    return (XCPT_CONTINUE_SEARCH);
}
