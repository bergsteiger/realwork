/*-----------------------------------------------------------------------*
 * filename - wildargs.c -> wildargs.obj
 *
 *
 * Declares the variables that are pointers to the routines that are called
 * when the argv processing system encounters wild cards.  Their target
 * functions then expand the wild cards to make them availible in argv[]
 *
 * These override the internal versions such that you simply link wildargs.obj
 * into your EXE and you get full wild card expansion.
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1999, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */


#include <wildargs.h>

void (_RTLENTRY * _RTLENTRY _EXPDATA _argv_expand_ptr)(char *_arg, _PFN_ADDARG _pfn_addarg) = _expand_wild;
void (_RTLENTRY * _RTLENTRY _EXPDATA _wargv_expand_ptr)(wchar_t *_arg, _PFN_ADDARG _pfn_addarg) = _wexpand_wild;

