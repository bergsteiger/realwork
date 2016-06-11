/*-----------------------------------------------------------------------*
 * filename - xfclose.c
 *
 * function(s)
 *        _xfclose - closes streams
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24802 $        */

#include <stdio.h>
#include <_stdio.h>

/*---------------------------------------------------------------------*

Name        _xfclose - closes streams

Usage       void _xfclose(void)

Description called at exit to close open streams

*---------------------------------------------------------------------*/

void _xfclose( void )
{
    register FILE *fp;
    register unsigned i;

    _lock_all_streams();
    for( i = 0, fp = _streams; i < _nfile; fp++, i++ )
    {
        /* Only close temp files.  Leave the others open so CG has a crack
           at them.  This is so that CG can detect when the user has failed
           to close a file he opened.
        */
        if( (fp->flags & _F_RDWR) && (fp->istemp))
            fclose( fp );
    }
    _unlock_all_streams();
}
