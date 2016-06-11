/*-----------------------------------------------------------------------*
 * filename - lconv.c
 *
 *    module for ANSI C localeconv() function
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

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <alloc.h>
#include <io.h>
#include <string.h>
#include <_string.h>
#include <fcntl.h>
#include <dos.h>
#include <ctype.h>
#include <sys/stat.h>
#include <limits.h>
#include <dir.h>
#include <_locale.h>

struct lconv * _RTLENTRY _EXPFUNC _llocaleconv(void)
{
    /* lock locale convention global structure */
    _lock_locale();

    if (__locale->numeric)
    {
	_localeconvention.decimal_point =
	    (char *) __locale->numeric->Decimal;

	_localeconvention.thousands_sep =
	    (char *) __locale->numeric->ThousandSeparator;

	_localeconvention.grouping =
	    (char *) __locale->numeric->Grouping;

	_localeconvention.positive_sign =
		(char *) __locale->numeric->PositiveSign;

	_localeconvention.negative_sign =
	    (char *) __locale->numeric->NegativeSign;
    }
    else
    {
	_localeconvention.decimal_point = 0;
	_localeconvention.thousands_sep = 0;
	_localeconvention.grouping = 0;
	_localeconvention.positive_sign = 0;
	_localeconvention.negative_sign = 0;
    }

    if (__locale->monetary)
    {
	_localeconvention.int_curr_symbol =
	    (char *) __locale->monetary->IntlSymbol;

	_localeconvention.currency_symbol =
	    (char *) __locale->monetary->Symbol;

	_localeconvention.mon_decimal_point =
	    (char *) __locale->monetary->Decimal;

	_localeconvention.mon_thousands_sep =
	    (char *) __locale->monetary->ThousandSeparator;

	_localeconvention.mon_grouping =
	    (char *) __locale->monetary->Grouping;

	_localeconvention.int_frac_digits =
	    __locale->monetary->IntlDigits;

	_localeconvention.frac_digits =
	    __locale->monetary->Digits;

	_localeconvention.p_cs_precedes =
	    __locale->monetary->PosSymbolPrec;

	_localeconvention.p_sep_by_space =
	    __locale->monetary->PosSymbolSpace;

	_localeconvention.n_cs_precedes =
	    __locale->monetary->NegSymbolPrec;

	_localeconvention.n_sep_by_space =
	    __locale->monetary->NegSymbolSpace;

	_localeconvention.p_sign_posn =
	    __locale->monetary->PositiveFormat;

	_localeconvention.n_sign_posn =
	    __locale->monetary->NegativeFormat;
    }
    else
    {
	_localeconvention.int_curr_symbol = 0;
	_localeconvention.currency_symbol = 0;
	_localeconvention.mon_decimal_point = 0;
	_localeconvention.mon_thousands_sep = 0;
	_localeconvention.mon_grouping = 0;
	_localeconvention.int_frac_digits = 0;
	_localeconvention.frac_digits = 0;
	_localeconvention.p_cs_precedes = 0;
	_localeconvention.p_sep_by_space = 0;
	_localeconvention.n_cs_precedes = 0;
	_localeconvention.n_sep_by_space = 0;
	_localeconvention.p_sign_posn = 0;
	_localeconvention.n_sign_posn = 0;
    }

    /* unlock before leaving */
    _unlock_locale();

    return &_localeconvention;
}
