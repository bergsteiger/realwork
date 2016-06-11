/*-----------------------------------------------------------------------*
 * filename - mbisblank.c
 *
 * function(s)
 *        _ismbcblank - Tests a character whether it is a blank or not.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2008, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


#include <ctype.h>
#include <mbctype.h>

/*---------------------------------------------------------------------*

Name            _ismbcblank - Tests a character whether it is a blank
                              or not.

Usage           int _ismbcblank(unsigned int c);

Prototype in    mbstring.h

Description     _ismbcblank tests c whether it is a space or not.

Return value    Returns the value excepting 0 if it is a space,
                and returns 0 if it is not.

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _ismbcblank(unsigned int c)
{
    if (c > 0x00FF)
        return 0;
    else
        return isblank(c);
}
