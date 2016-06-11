/*------------------------------------------------------------------------
 * filename - getinfo.c
 *
 * function(s)
 *      _getLocaleNumeric  - return the required info about the locale
 *
 *
 *
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28609 $        */

#include <ntbc.h>
#include <winnls.h>
#include <locale.h>
#include <_locale.h>

const void* _getLocaleNumericInfo(LCTYPE info)
{
    void *val;

   _lock_locale();
    switch (info)
    {
    case LOCALE_SDECIMAL:      val = (__locale->numeric->Decimal); break;
    case LOCALE_STHOUSAND:     val = (__locale->numeric->ThousandSeparator); break;
    case LOCALE_SGROUPING:     val = (__locale->numeric->Grouping); break;
    case LOCALE_SPOSITIVESIGN: val = (__locale->numeric->PositiveSign); break;
    case LOCALE_SNEGATIVESIGN: val = (__locale->numeric->NegativeSign); break;
    default: val = NULL; break;
    }
    _unlock_locale();
    return val;
}
