/*-----------------------------------------------------------------------*
 * filename - exparg.c
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1999, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <_setargv.h>

/*----------------------------------------------------------------------
 * _targv_default_expand - dummy wildcard expansion routine
 */
void _RTLENTRY _EXPFUNC _targv_default_expand(_TCHAR *_arg, _PFN_ADDARG _pfn_addarg)
{
    _pfn_addarg(_arg, 0);        /* add argument without making a copy */
}
