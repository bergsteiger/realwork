/*-----------------------------------------------------------------------*
 * filename - make_arglist.c
 *
 * function(s)
 *        _make_arglist  - convert variable arguments to arg list
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision:$ */

#include <stdlib.h>
#include <stdarg.h>
#include <_tchar.h>
#include <_process.h>
#include <list>

extern "C"
{

_TCHAR ** _tmake_arglist(const _TCHAR *first, va_list ap, int extra)
{
    _TCHAR **buf;
    _TCHAR *p;
    int count;
    std::list<_TCHAR *> arglist;

    if (first)
        arglist.push_back(const_cast<_TCHAR *>(first));
    do
    {
	p = va_arg(ap, _TCHAR *);
        arglist.push_back(p);
    } while(p);

    if ((buf = (_TCHAR **) malloc((arglist.size() + extra) * sizeof(_TCHAR *))) == NULL)
        return NULL;

    count = 0;
    for (_TCHAR *p : arglist)
        buf[count++] = p;

    while (extra--)
    {
        buf[count++] = va_arg(ap, _TCHAR *);
    }

    return buf;
}

} // extern "C"
