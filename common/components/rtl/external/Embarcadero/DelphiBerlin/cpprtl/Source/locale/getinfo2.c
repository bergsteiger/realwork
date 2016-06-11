/*------------------------------------------------------------------------
 * filename - getinfo2.c
 *
 * function(s)
 *      _getLocaleMonetary - return the required info about the locale
 *      _getLocaleMonetaryNegFmt - return the monertary negative format
 *
 *
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28609 $        */

#include <ntbc.h>
#include <winnls.h>
#include <locale.h>
#include <_locale.h>

const void* _getLocaleMonetaryInfo(LCTYPE info)
{
    void *val;

   _lock_locale();
    switch (info)
    {
    case LOCALE_SMONDECIMALSEP:   val = (__locale->monetary->Decimal); break;
    case LOCALE_SMONTHOUSANDSEP:  val = (__locale->monetary->ThousandSeparator); break;
    case LOCALE_SCURRENCY:        val = (__locale->monetary->Symbol); break;
    case LOCALE_SINTLSYMBOL:      val = (__locale->monetary->IntlSymbol); break;
    case LOCALE_SMONGROUPING:     val = (__locale->monetary->Grouping); break;
    case LOCALE_SPOSITIVESIGN:    val = (__locale->monetary->PositiveSign); break;
    case LOCALE_SNEGATIVESIGN:    val = (__locale->monetary->NegativeSign); break;

    case LOCALE_ICURRDIGITS:      val = (void*) (__locale->monetary->Digits); break;
    case LOCALE_IINTLCURRDIGITS:  val = (void*) (__locale->monetary->IntlDigits); break;
    case LOCALE_ICURRENCY:        val = (void*) (__locale->monetary->Mode); break;
    case LOCALE_INEGCURR:         val = (void*) (__locale->monetary->NegMode); break;
    case LOCALE_IPOSSIGNPOSN:     val = (void*) (__locale->monetary->PositiveFormat); break;
    case LOCALE_INEGSIGNPOSN:     val = (void*) (__locale->monetary->NegativeFormat); break;
    case LOCALE_IPOSSYMPRECEDES:  val = (void*) (__locale->monetary->PosSymbolPrec); break;
    case LOCALE_IPOSSEPBYSPACE:   val = (void*) (__locale->monetary->PosSymbolSpace); break;
    case LOCALE_INEGSYMPRECEDES:  val = (void*) (__locale->monetary->NegSymbolPrec); break;
    case LOCALE_INEGSEPBYSPACE:   val = (void*) (__locale->monetary->NegSymbolSpace); break;
    default: val = NULL;
    }
    _unlock_locale();
    return val;
}

const void* _getLocaleMonetaryNegFmt()
{
    void *val;

    _lock_locale();
    val = __locale->monetary->NegativeFormatString;
    _unlock_locale();
    return val;
}
