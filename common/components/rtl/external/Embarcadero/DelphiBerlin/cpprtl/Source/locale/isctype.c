/*---------------------------------------------------------------------------
 * filename - isctype.c
 *
 * function(s)
 *    isctype
 *--------------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28609 $        */

#include <ctype.h>
#include <_ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <_locale.h>
#include <tchar.h>
#include <_tchar.h>

extern unsigned short __cdecl _chartype[ 257 ];

static int __fastcall __inline getctypeflags( int c )
{
    int val;

    if ( (unsigned int) c >255 )
        return( 0 );

    _lock_locale();
    if (__locale->isCLocale || (__locale->ctype == NULL))
        val = (_chartype[(short) (c)+1]);
    else
        val = (__locale->ctype->cType[ c+1 ]);
    _unlock_locale();
    return val;
}

int _RTLENTRY _EXPFUNC __isctype( int c, int type )
{
    return getctypeflags(c) & type;
}

int _RTLENTRY _EXPFUNC __isctypeEx( int c, int type, int disallow )
{
    int flags = getctypeflags(c);
    if (!(flags & disallow))
        return flags & type;
    return 0;
}
