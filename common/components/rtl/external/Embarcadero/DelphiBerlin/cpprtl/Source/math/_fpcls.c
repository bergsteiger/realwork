/*------------------------------------------------------------------------
 * filename - _fpcls.c
 *
 * function(s)
 *
 *   _fpclass  - Returns the type (class) of an IEEE real for doubles
 *   _fpclassl - Returns the type (class) of an IEEE real for long doubles
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34734 $        */

#if !defined(_WIN64)

#pragma inline
#include <float.h>


static int CallFXAM (void)
{
    int ret;

    asm fxam
    ret = (_status87() & 0x4700);  /* Mask off all bits but C0-C3 */
    asm ffree ST(0)                /* free the loaded fp reg.     */
    asm fincstp                    /* then bump the fp stack ptr  */

    ret = ret >> 8;
    ret = (ret & 0x0007) | ((ret & 0x0040) >> 3);
    return ret;
}


static int MapClass (void)
{
    int stat = CallFXAM();

    switch (stat)
    {
    /* CFlgs: C3 C2 C1 C0   (C1 = sign [0:positive, 1:negative]) */

        case 0x00:
        case 0x02:
            return _FPCLASS_UNSUP;

        case 0x01:
        case 0x03:
            /* +- NAN */
            return _FPCLASS_SNAN;  /* mark it as an SNAN for now, check for
                                      QNAN later */

        case 0x04:
            return _FPCLASS_PN;
        case 0x06:
            return _FPCLASS_NN;

        case 0x05:
            return _FPCLASS_PINF;
        case 0x07:
            return _FPCLASS_NINF;

        case 0x08:
            return _FPCLASS_PZ;
        case 0x0A:
            return _FPCLASS_NZ;

        case 0x0C:
            return _FPCLASS_PD;
        case 0x0E:
            return _FPCLASS_ND;

    }
    return 0; /* Unknown type */
}

int _RTLENTRY _EXPFUNC _fpclass(double __d)
{
    int ret;
    unsigned orig_cw = _control87(0, 0);

    _control87 (MCW_EM, MCW_EM);  /* Disable FP exceptions */
    asm fld [__d]
    ret = MapClass ();
    if (ret == _FPCLASS_SNAN)
        ret = _isnan(__d);
    _control87(orig_cw, MCW_EM);  /* Restore control word */
    return ret;
}

int _RTLENTRY _EXPFUNC _fpclassl(long double __ld)
{
    int ret;
    unsigned orig_cw = _control87(0, 0);

    _control87 (MCW_EM, MCW_EM);  /* Disable FP exceptions */
    asm fld [__ld]
    ret = MapClass ();
    if (ret == _FPCLASS_SNAN)
        ret = _isnanl(__ld);
    _control87(orig_cw, MCW_EM);  /* Restore control word */
    return ret;
}

#else

#include <float.h>

_EXPFUNC int _fpclass(double d)
{
    unsigned long long bytes = *(unsigned long long *) &d;
    int sign = bytes & 0x8000000000000000;

    if ((bytes & 0x7FFFFFFFFFFFFFFF) == 0)
	return sign ? _FPCLASS_NZ : _FPCLASS_PZ;

    // if exp has all bits set then either a INF or NAN
    if ((bytes & 0x7FF0000000000000) == 0x7FF0000000000000)
    {
        // if significand is all zero then INF
        if ((bytes & 0x000FFFFFFFFFFFFF) == 0)
	{
	    return sign ? _FPCLASS_NINF : _FPCLASS_PINF;
	}
	else
	{
	    // check high bit of significand for type
	    return (bytes & 0x0008000000000000) ? _FPCLASS_QNAN : _FPCLASS_SNAN;
	}
    }
    // if exp is zero then either zero (checked above) or denormal
    if ((bytes & 0x7FF0000000000000) == 0)
        return sign ? _FPCLASS_ND : _FPCLASS_PD;

    return sign ? _FPCLASS_NN : _FPCLASS_PN;
}

_EXPFUNC int _fpclassl(long double ld)
{
    return _fpclass(ld);
}

#endif
