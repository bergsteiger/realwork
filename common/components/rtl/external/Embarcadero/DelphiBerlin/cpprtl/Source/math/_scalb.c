/*------------------------------------------------------------------------
 * filename - _scalb.c
 *
 * function(s)
 *
 *   _scalb    Scales argument by a power of 2
 *
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

#pragma inline
#include <errno.h>
#include <math.h>
#include <float.h>

#pragma argsused
#pragma warn -rvl
double _RTLENTRY _EXPFUNC _scalb(double __d, long __exp)
{
    unsigned short ctrl;
    ctrl = _control87 (MCW_EM, MCW_EM);
    asm {
      fild    [__exp]
      fld     [__d]
      fscale
      fstp    [__d]
      ffree   ST(0)
      fincstp
    }
    _control87(ctrl, MCW_EM);

    if (!_finite (__d))
    {
      errno = ERANGE;
      __d = _copysign (HUGE_VAL, __d);
    }
    return __d;
}
