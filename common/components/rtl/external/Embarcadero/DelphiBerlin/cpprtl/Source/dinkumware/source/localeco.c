/* localeconv function */
#include <limits.h>
#include <locale.h>
#include "xtls.h"
_STD_BEGIN

		/* static data */
static const char null[] = "";

_TLS_DEFINE_INIT(_IMPLICIT_EXTERN, struct lconv, _Locale) = {
		/* LC_MONETARY */
	(char *)null,			/* currency_symbol */
	(char *)null,			/* int_curr_symbol */
	(char *)null,			/* mon_decimal_point */
	(char *)null,			/* mon_grouping */
	(char *)null,			/* mon_thousands_sep */
	(char *)null,			/* negative_sign */
	(char *)null,			/* positive_sign */

	CHAR_MAX,				/* frac_digits */
	CHAR_MAX,				/* n_cs_precedes */
	CHAR_MAX,				/* n_sep_by_space */
	CHAR_MAX,				/* n_sign_posn */
	CHAR_MAX,				/* p_cs_precedes */
	CHAR_MAX,				/* p_sep_by_space */
	CHAR_MAX,				/* p_sign_posn */

	CHAR_MAX,				/* int_frac_digits */
/* vv added with C99 vv */
	CHAR_MAX,				/* int_n_cs_precedes */
	CHAR_MAX,				/* int_n_sep_by_space */
	CHAR_MAX,				/* int_n_sign_posn */
	CHAR_MAX,				/* int_p_cs_precedes */
	CHAR_MAX,				/* int_p_sep_by_space */
	CHAR_MAX,				/* int_p_sign_posn */
/* ^^ added with C99 ^^ */

		/* LC_NUMERIC */
	".",					/* decimal_point */
	(char *)null,			/* grouping */
	(char *)null,			/* thousands_sep */
	(char *)null,			/* _Frac_grouping */
	(char *)null,			/* _Frac_sep */
	"false",				/* _False */
	"true",					/* _True */

		/* LC_MESSAGES */
	(char *)null,			/* _No */
	(char *)null,			/* _Yes */
	};
_TLS_DEFINE_NO_INIT(_IMPLICIT_EXTERN, struct lconv, _Locale);

 #if !_MULTI_THREAD || _COMPILER_TLS && !_GLOBAL_LOCALE

  #ifdef __cplusplus

  #else /* __cplusplus */
struct lconv *(localeconv)(void)
	{	/* get pointer to current locale */
	return (&_Locale);
	}
  #endif /* __cplusplus */

 #else /* !_MULTI_THREAD || _COMPILER_TLS && !_GLOBAL_LOCALE */
struct lconv *(localeconv)(void)
	{	/* get pointer to current locale */
	return (_TLS_DATA_PTR(_Locale));
	}
 #endif /* !_MULTI_THREAD || _COMPILER_TLS && !_GLOBAL_LOCALE */

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
