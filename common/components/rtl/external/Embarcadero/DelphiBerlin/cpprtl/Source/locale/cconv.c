/*-----------------------------------------------------------------------*
 * filename - cconv.c
 *
 *    the "C" locale lconv structure.
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34095 $        */

#include <string.h>
#include <ctype.h>
#include <limits.h>
#include <_locale.h>

struct lconv _localeconvention =
{
    ".",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    CHAR_MAX,
    CHAR_MAX,
    CHAR_MAX,
    CHAR_MAX,
    CHAR_MAX,
    CHAR_MAX,
    CHAR_MAX,
    CHAR_MAX
};

struct lconv * _RTLENTRY _EXPFUNC localeconv( void )
{
  return( &_localeconvention );
}

/* FIXME: Workaround for pdata issue */
void *__force = (void *) localeconv;
