/*-----------------------------------------------------------------------*
 * filename - libmain.c
 *
 * function(s)
 *      _libmain - default shared library user initialization
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2011, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $ */

#include <ntbc.h>

/*---------------------------------------------------------------------*

Name            _libmain - default shared library user initialization

Usage           int _libmain(unsigned longul_reason_being_called)

Prototype in    none

Description     _libmain is called by the startup code when a DLL is
                is initialized, after all other RTL initialization
                is performed.  This is the default version, which
                is linked if the user does not provide one.

Return value    If it is successful, _libmain returns 1; if an error
                occurs, it returns 0.

*---------------------------------------------------------------------*/

#pragma argsused

int _libmain(unsigned long ul_reason_being_called)
{
    return 1;
}

