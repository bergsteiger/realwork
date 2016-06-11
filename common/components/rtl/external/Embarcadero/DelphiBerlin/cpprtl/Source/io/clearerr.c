/*------------------------------------------------------------------------
 * filename - clearerr.c
 *
 * function(s)
 *        clearerr - resets error indication
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <stdio.h>

/*---------------------------------------------------------------------------*

Name            clearerr - resets error indication

Usage           #include <stdio.h>
                void clearerr(FILE *stream);

Prototype in    stdio.h

Description     clearerr sets the stream's error and end-of-file indicators
                to 0.

Return value    nothing

*---------------------------------------------------------------------------*/

void _RTLENTRY _EXPFUNC clearerr (FILE *fp)
{
    fp->flags &= ~(_F_ERR | _F_EOF);
}

