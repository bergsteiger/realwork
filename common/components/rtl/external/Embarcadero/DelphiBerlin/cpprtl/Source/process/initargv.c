/*-----------------------------------------------------------------------*
 * filename - initargv.c
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1999, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

/* Sets the function pointers used to manage the creation and deletion
 * of the argv array.
 */

#include <_setargv.h>


/*----------------------------------------------------------------------
 * _init_setargv_handlers - sets the pointers to the argv processing routines
 *
 * This function will be called directly by the startup code for EXEs.
 */
void _init_setargv_handlers(
    int (*setargv_func)(char *, char *, _PFN_ADDARG),
    void (*exitargv_func)(void),
    int (*wsetargv_func)(wchar_t *,wchar_t *, _PFN_ADDARG),
    void (*wexitargv_func)(void)
                           )
{
    _setargv_ptr = setargv_func;
    _exitargv_ptr = exitargv_func;

#ifndef MINIRTL
    _wsetargv_ptr = wsetargv_func;
    _wexitargv_ptr = wexitargv_func;
#endif
}
