/*
   VCLLIB.C - This file is the only .obj that goes into making VCLLINK.LIB.
              This .obj is pulled in by a reference in crtlvcl.cpp If
              the user is not linking with the VCL libraries, then the
              external symbol request is satisfied by the one in the
              crtlstub.cpp file.

*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1997, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 31103 $        */


/* These must be listed in REVERSE order of linkage preference          */

/* This list is no longer used as it can't be correct for combinations
   of static/dynamic or differnt frameworks VCL/FMX.  New options in
   the compiler will select the appropriate libraries.
*/

#if 0
#pragma comment (lib, "vcle.lib")    /* VCL Emulation stuff (in C++)    */
#pragma comment (lib, "vcl.lib")     /* Normal VCL stuff                */
#pragma comment (lib, "rtl.lib")     /* Delphi RTL stuff                */
#endif

#include <_defs.h>

/*
   The following symbol errs as undefined if VCLLINK.LIB is linked
   with CW32.LIB, CW32MT.LIB, CW32I.LIB, or CW32MTI.LIB
*/

#define NAME __Must_Link_VCL_Apps_With_The_CP32MT_Or_CP32MTI_RTL

extern char NAME;

void _RTLENTRY __declspec(naked) __CRTL_VCLLIB_Linkage (void)
{
    NAME++;
    __emit__(0xC3); /* asm ret */
}
