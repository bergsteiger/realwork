// limits -- static members for limits explicit specializations
#include <yvals.h>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#include <cwchar>
#include <limits>
_STD_BEGIN

 #undef _STCONS	/* defining instance, but not value definition here */
 #define TEMPLATE	/* first uses are for non-templates */
 #define _STCONS(ty, name, val)	TEMPLATE const ty CLASS::name

 #define CLASS	_Num_base
	_STCONS(float_denorm_style, has_denorm, denorm_absent);
	_STCONS(bool, has_denorm_loss, false);
	_STCONS(bool, has_infinity, false);
	_STCONS(bool, has_quiet_NaN, false);
	_STCONS(bool, has_signaling_NaN, false);
	_STCONS(bool, is_bounded, false);
	_STCONS(bool, is_exact, false);
	_STCONS(bool, is_iec559, false);
	_STCONS(bool, is_integer, false);
	_STCONS(bool, is_modulo, false);
	_STCONS(bool, is_signed, false);
	_STCONS(bool, is_specialized, false);
	_STCONS(bool, tinyness_before, false);
	_STCONS(bool, traps, false);
	_STCONS(float_round_style, round_style, round_toward_zero);
	_STCONS(int, digits, 0);
	_STCONS(int, digits10, 0);
	_STCONS(int, max_exponent, 0);
	_STCONS(int, max_exponent10, 0);
	_STCONS(int, min_exponent, 0);
	_STCONS(int, min_exponent10, 0);
	_STCONS(int, radix, 0);

 #undef CLASS
 #define CLASS	_Num_int_base
	_STCONS(bool, is_bounded, true);
	_STCONS(bool, is_exact, true);
	_STCONS(bool, is_integer, true);
	_STCONS(bool, is_modulo, true);
	_STCONS(bool, is_specialized, true);
	_STCONS(int, radix, 2);

 #undef CLASS
 #define CLASS	_Num_float_base
	_STCONS(float_denorm_style, has_denorm, denorm_present);
	_STCONS(bool, has_denorm_loss, true);
	_STCONS(bool, has_infinity, true);
	_STCONS(bool, has_quiet_NaN, true);
	_STCONS(bool, has_signaling_NaN, true);
	_STCONS(bool, is_bounded, true);
	_STCONS(bool, is_exact, false);
	_STCONS(bool, is_iec559, true);
	_STCONS(bool, is_integer, false);
	_STCONS(bool, is_modulo, false);
	_STCONS(bool, is_signed, true);
	_STCONS(bool, is_specialized, true);
	_STCONS(bool, tinyness_before, true);
	_STCONS(bool, traps, true);
	_STCONS(float_round_style, round_style, round_to_nearest);
	_STCONS(int, radix, FLT_RADIX);

 #undef TEMPLATE
 #define TEMPLATE	_TEMPLATE_STAT	/* remaining uses are for templates */

 #undef CLASS
 #define CLASS	numeric_limits<char>
	_STCONS(bool, is_signed, CHAR_MIN < 0);
	_STCONS(int, digits, CHAR_BIT - (CHAR_MIN < 0 ? 1 : 0));
	_STCONS(int, digits10, (CHAR_BIT - (CHAR_MIN < 0 ? 1 : 0))
		* 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<wchar_t>
	_STCONS(bool, is_signed, WCHAR_MIN < 0);
	_STCONS(int, digits, CHAR_BIT * sizeof (wchar_t)
		- (WCHAR_MIN < 0 ? 1 : 0));
	_STCONS(int, digits10, (CHAR_BIT * sizeof (wchar_t)
		- (WCHAR_MIN < 0 ? 1 : 0)) * 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<_Bool>
	_STCONS(bool, is_modulo, false);
	_STCONS(bool, is_signed, false);
	_STCONS(int, digits, 1);
	_STCONS(int, digits10, 0);

 #undef CLASS
 #define CLASS	numeric_limits<signed char>
	_STCONS(bool, is_signed, true);
	_STCONS(int, digits, CHAR_BIT - 1);
	_STCONS(int, digits10, (CHAR_BIT - 1) * 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<unsigned char>
	_STCONS(bool, is_signed, false);
	_STCONS(int, digits, CHAR_BIT);
	_STCONS(int, digits10, (CHAR_BIT) * 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<short>
	_STCONS(bool, is_signed, true);
	_STCONS(int, digits, CHAR_BIT * sizeof (short) - 1);
	_STCONS(int, digits10, (CHAR_BIT * sizeof (short) - 1)
		* 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<unsigned short>
	_STCONS(bool, is_signed, false);
	_STCONS(int, digits, CHAR_BIT * sizeof (unsigned short));
	_STCONS(int, digits10, (CHAR_BIT * sizeof (unsigned short))
		* 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<int>
	_STCONS(bool, is_signed, true);
	_STCONS(int, digits, CHAR_BIT * sizeof (int) - 1);
	_STCONS(int, digits10, (CHAR_BIT * sizeof (int) - 1)
		* 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<unsigned int>
	_STCONS(bool, is_signed, false);
	_STCONS(int, digits, CHAR_BIT * sizeof (unsigned int));
	_STCONS(int, digits10, (CHAR_BIT * sizeof (unsigned int))
		* 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<long>
	_STCONS(bool, is_signed, true);
	_STCONS(int, digits, CHAR_BIT * sizeof (long) - 1);
	_STCONS(int, digits10, (CHAR_BIT * sizeof (long) - 1)
		* 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<unsigned long>
	_STCONS(bool, is_signed, false);
	_STCONS(int, digits, CHAR_BIT * sizeof (unsigned long));
	_STCONS(int, digits10, (CHAR_BIT * sizeof (unsigned long))
		* 301L / 1000);

 #ifdef _LONGLONG
 #undef CLASS
 #define CLASS	numeric_limits<_LONGLONG>
	_STCONS(bool, is_signed, true);
	_STCONS(int, digits, CHAR_BIT * sizeof (_LONGLONG) - 1);
	_STCONS(int, digits10,
		(CHAR_BIT * sizeof (_LONGLONG) - 1) * 301L / 1000);

 #undef CLASS
 #define CLASS	numeric_limits<_ULONGLONG>
	_STCONS(bool, is_signed, false);
	_STCONS(int, digits, CHAR_BIT * sizeof (_ULONGLONG));
	_STCONS(int, digits10,
		(CHAR_BIT * sizeof (_ULONGLONG)) * 301L / 1000);
 #endif

 #undef CLASS
 #define CLASS	numeric_limits<float>
	_STCONS(int, digits, FLT_MANT_DIG);
	_STCONS(int, digits10, FLT_DIG);
	_STCONS(int, max_exponent, FLT_MAX_EXP);
	_STCONS(int, max_exponent10, FLT_MAX_10_EXP);
	_STCONS(int, min_exponent, FLT_MIN_EXP);
	_STCONS(int, min_exponent10, FLT_MIN_10_EXP);

 #undef CLASS
 #define CLASS	numeric_limits<double>
	_STCONS(int, digits, DBL_MANT_DIG);
	_STCONS(int, digits10, DBL_DIG);
	_STCONS(int, max_exponent, DBL_MAX_EXP);
	_STCONS(int, max_exponent10, DBL_MAX_10_EXP);
	_STCONS(int, min_exponent, DBL_MIN_EXP);
	_STCONS(int, min_exponent10, DBL_MIN_10_EXP);

 #undef CLASS
 #define CLASS	numeric_limits<long double>
	_STCONS(int, digits, LDBL_MANT_DIG);
	_STCONS(int, digits10, LDBL_DIG);
	_STCONS(int, max_exponent, LDBL_MAX_EXP);
	_STCONS(int, max_exponent10, LDBL_MAX_10_EXP);
	_STCONS(int, min_exponent, LDBL_MIN_EXP);
	_STCONS(int, min_exponent10, LDBL_MIN_10_EXP);
_STD_END
 #endif /* _IS_EMBEDDED */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
