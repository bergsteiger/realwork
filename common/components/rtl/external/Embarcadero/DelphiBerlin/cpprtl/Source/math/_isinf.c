/*------------------------------------------------------------------------
 * filename - _isinf.c
 *
 * function(s)
 *
 *   _isinf     - double version
 *
 * These functions return non-zero if the value passed in is +-INF, else 0.
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <float.h>
#include <_float.h>

int _RTLENTRY _EXPFUNC _isinf(double _d)
{
    _rtl_double_t *p = (_rtl_double_t *) &_d;

    if (((p->i64.value & 0x7FF0000000000000) == 0x7FF0000000000000) &&
        ((p->i64.value & 0x000FFFFFFFFFFFFF) == 0))
        return 1;

    return 0;
}
