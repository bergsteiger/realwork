/*-----------------------------------------------------------------------*
 * filename - crtlst_l.c: stubed out version of VCL.LIB linkage function
 *
 * function(s)
 *
 *   __CRTL_VCLLIB_Linkage
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

void _RTLENTRY __declspec(naked) __CRTL_VCLLIB_Linkage (void)
{
    __emit__(0xC3); /* asm ret */
}
