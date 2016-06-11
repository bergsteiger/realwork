/* 
   Module to handle interfacing 8087 control with Delphi RTL.  It resides in the RTLDLL 
   and cannot directly reference Delphi symbols (called by crtlvcl.cpp) 
*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2010, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28857 $        */

#include <float.h>

typedef void (__fastcall *Set8087)(unsigned short);
typedef void (__fastcall *Reset8087)(void);

static Set8087 _control87_hook = 0;
static Reset8087 _fpreset_hook = 0;

#if !defined(_WIN64) // FIXME
extern unsigned int _RTLENTRY __control87(unsigned int newcw, unsigned int mask);
extern void _RTLENTRY __fpreset(void);

unsigned int _RTLENTRY _EXPFUNC _control87(unsigned int newcw, unsigned int mask)
{
    // If updating CW (non-zero mask) then call hook if set
    if (mask && _control87_hook )
    {
	unsigned current = __control87(0, 0);
	newcw &= mask;
	current &= ~mask;
	current |= newcw;
	_control87_hook(current);
	return current;
    }
    else
	return __control87(newcw, mask);
}

void _RTLENTRY _EXPFUNC _fpreset(void)
{
    if (_fpreset_hook)
	_fpreset_hook();
    else
	__fpreset();
}
#endif
void _RTLENTRY _EXPFUNC __CRTL_VCL_FPU_Hook(Set8087 set, Reset8087 reset)
{
    _control87_hook = set;
    _fpreset_hook = reset;
}
