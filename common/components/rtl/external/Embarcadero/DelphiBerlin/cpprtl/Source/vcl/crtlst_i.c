/*-----------------------------------------------------------------------*
 * filename - crtlst_i.c: stubed out version of the Init function
 *
 * function(s)
 *
 *   __CRTL_VCL_Init
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <_defs.h>

/*
 * The following functions are stubbed out to do nothing.
 * The real ones are in CRTLVCL.CPP.
 */

void _RTLENTRY __declspec(naked) __CRTL_VCL_Init (void)
{
    __emit__(0xC3); /* asm ret */
}
