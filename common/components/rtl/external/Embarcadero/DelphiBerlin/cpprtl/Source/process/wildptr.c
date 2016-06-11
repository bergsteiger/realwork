/*-----------------------------------------------------------------------*
 * filename - wildptr.c
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1999, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

/* Contains the function pointers used to handle expansion of wild args */

#include <_setargv.h>

/* Init the pointer to the default expansion handler which does no expansion. */

void (_RTLENTRY * _RTLENTRY _targv_expand_ptr)(_TCHAR *_arg, _PFN_ADDARG _pfn_addarg) = _targv_default_expand;
