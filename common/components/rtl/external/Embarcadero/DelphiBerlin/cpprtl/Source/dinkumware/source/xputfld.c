/* _Putfld function */
#include <string.h>
#include <wchar.h>
#include "xmath.h"
#include "xstdio.h"

 #if _HAS_FIXED_POINT
 #include "fixed.h"		/* internal fixed-point header */

 #define GET_SFIXED(ty)	\
	(sizeof (ty) <= sizeof (int) ? va_arg(*pap, int) \
	: sizeof(ty) <= sizeof (long) ? va_arg(*pap, long) \
	: va_arg(*pap, _Longlong))
 #define GET_UFIXED(ty)	\
	(sizeof (ty) <= sizeof (unsigned int) ? va_arg(*pap, unsigned int) \
	: sizeof(ty) <= sizeof (unsigned long) ? va_arg(*pap, unsigned long) \
	: va_arg(*pap, _ULonglong))

void _Fixed_put(_Pft *, fxmaskf);

int _Putcvec(_Pft *, va_list *, char, char *);	/* vc */
int _Putfvec(_Pft *, va_list *, char, char *);	/* ve, vf, etc. */
int _Putscvec(_Pft *, va_list *, char, char *);	/* vd, vi */
int _Putshvec(_Pft *, va_list *, char, char *);	/* hvd, vhd, etc. */
int _Putslvec(_Pft *, va_list *, char, char *);	/* lvd, dlv, etc. */
int _Putucvec(_Pft *, va_list *, char, char *);	/* vo, vu, etc. */
int _Putuhvec(_Pft *, va_list *, char, char *);	/* hvo, vho, etc. */
int _Putulvec(_Pft *, va_list *, char, char *);	/* hlo, lho, etc. */
 #endif /* _HAS_FIXED_POINT */

_STD_BEGIN

int _Putfld(_Pft *px, va_list *pap, char code, char *ac)
	{	/* convert a field for _Printf */
	switch (code)
		{	/* switch on conversion specifier */
	case 'c':	/* convert a single character */

 #if _HAS_FIXED_POINT
		if (px->qual == 'v')
			return (_Putcvec(px, pap, code, ac));
 #endif /* _HAS_FIXED_POINT */

		if (px->qual != 'l')
			{	/* put a char */
			char ch = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				ch = (char)va_arg(*pap, int);
			ac[px->n0++] = ch;
			}
		else
			{	/* convert as wide string */
			wchar_t wc[2];
			wint_t wi = 0;	/* initialized to quiet diagnostics */

		for (; 0 <= px->argno; --px->argno)

 #if WCHAR_MAX <= INT_MAX
			wi = (wint_t)va_arg(*pap, int);

 #else /* WCHAR_MAX <= INT_MAX */
			wi = va_arg(*pap, wint_t);
 #endif /* WCHAR_MAX <= INT_MAX */

			wc[0] = wi, wc[1] = L'\0';
			px->prec = -1;
			if (_Putstr(px, (const wchar_t *)wc) < 0)
				return (EOF);
			}
		break;

	case 'd': case 'i':	/* convert a signed decimal */

 #if _HAS_FIXED_POINT
		if (px->qual == 'v')
			return (_Putscvec(px, pap, code, ac));	/* v */
		else if (px->qual == 'w')
			return (_Putshvec(px, pap, code, ac));	/* hv or vh */
		else if (px->qual == 'W')
			return (_Putslvec(px, pap, code, ac));	/* hl or lh */
 #endif /* _HAS_FIXED_POINT */

		for (; 0 <= px->argno; --px->argno)
			px->v.li = px->qual == 'l' ? va_arg(*pap, long)
				: px->qual == 'q' ? va_arg(*pap, _Longlong)
				: px->qual == 'j' ? va_arg(*pap, intmax_t)
				: va_arg(*pap, int);
		if (px->qual == 'h')
			px->v.li = (short)px->v.li;
		else if (px->qual == 'b')
			px->v.li = (signed char)px->v.li;
		else if (px->qual == 't' || px->qual == 'z')
			px->v.li = (ptrdiff_t)px->v.li;
		if (px->v.li < 0)	/* negate safely in _Litob */
			ac[px->n0++] = '-';
		else if (px->flags & _FPL)
			ac[px->n0++] = '+';
		else if (px->flags & _FSP)
			ac[px->n0++] = ' ';
		px->s = &ac[px->n0];
		_Litob(px, code);
		break;

	case 'o': case 'u':
	case 'x': case 'X':	/* convert unsigned */

 #if _HAS_FIXED_POINT
		if (px->qual == 'v')
			return (_Putucvec(px, pap, code, ac));	/* v */
		else if (px->qual == 'w')
			return (_Putuhvec(px, pap, code, ac));	/* hv or vh */
		else if (px->qual == 'W')
			return (_Putulvec(px, pap, code, ac));	/* hl or lh */
 #endif /* _HAS_FIXED_POINT */

		for (; 0 <= px->argno; --px->argno)
			px->v.li = px->qual == 'l' ? va_arg(*pap, unsigned long)
				: px->qual == 'q' ? va_arg(*pap, _ULonglong)
				: px->qual == 'j' ? va_arg(*pap, uintmax_t)
				: va_arg(*pap, unsigned int);
		if (px->qual == 'h')
			px->v.li = (unsigned short)px->v.li;
		else if (px->qual == 'b')
			px->v.li = (unsigned char)px->v.li;
		else if (px->qual == 't' || px->qual == 'z')
			px->v.li = (size_t)px->v.li;
		if (px->flags & _FNO && px->v.li != 0
			&& (code == 'x' || code == 'X'))
			ac[px->n0++] = '0', ac[px->n0++] = code;
		px->s = &ac[px->n0];
		_Litob(px, code);
		break;

	case 'e': case 'E':	/* convert floating */
	case 'g': case 'G':
	case 'f': case 'F':
	case 'a': case 'A':

 #if _HAS_FIXED_POINT
		if (px->qual == 'v')
			return (_Putfvec(px, pap, code, ac));
 #endif /* _HAS_FIXED_POINT */

		for (; 0 <= px->argno; --px->argno)
			px->v.ld = px->qual == 'L'
				? va_arg(*pap, long double) : va_arg(*pap, double);
		if (LSIGN(px->v.ld))
			ac[px->n0++] = '-';
		else if (px->flags & _FPL)
			ac[px->n0++] = '+';
		else if (px->flags & _FSP)
			ac[px->n0++] = ' ';
		px->s = &ac[px->n0];
		_Ldtob(px, code);
		break;

 #if _HAS_FIXED_POINT
	case 'k':	/* convert fixed signed accumulator */
		if (px->qual == 'l')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_SFIXED(_Fixed_lk);
		else if (px->qual == 'h')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_SFIXED(_Fixed_hk);
		else
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_SFIXED(_Fixed_k);

		px->s = &ac[px->n0];
		_Fixed_put(px, FX_ACCUM);
		break;

	case 'K':	/* convert fixed unsigned accumulator */
		if (px->qual == 'l')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_UFIXED(_Fixed_ulk);
		else if (px->qual == 'h')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_UFIXED(_Fixed_uhk);
		else
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_UFIXED(_Fixed_uk);

		px->s = &ac[px->n0];
		_Fixed_put(px, FX_ACCUM | FX_UNSIGNED);
		break;

	case 'r':	/* convert fixed signed fraction */
		if (px->qual == 'l')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_SFIXED(_Fixed_lr);
		else if (px->qual == 'h')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_SFIXED(_Fixed_hr);
		else
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_SFIXED(_Fixed_r);

		px->s = &ac[px->n0];
		_Fixed_put(px, 0);
		break;

	case 'R':	/* convert fixed unsigned fraction */
		if (px->qual == 'l')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_UFIXED(_Fixed_ulr);
		else if (px->qual == 'h')
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_UFIXED(_Fixed_uhr);
		else
			for (; 0 <= px->argno; --px->argno)
				px->v.li = GET_UFIXED(_Fixed_ur);

		px->s = &ac[px->n0];
		_Fixed_put(px, FX_UNSIGNED);
		break;
 #endif /* _HAS_FIXED_POINT */

	case 'n':	/* return output count */
		switch (px->qual)
			{	/* store in specified integer type */
		case 'b':
			 {	/* store into signed char */
			signed char *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, signed char *);
			*p = px->nchar;
			 }
			break;

		case 'q':
			 {	/* store into signed long long */
			_Longlong *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, _Longlong *);
			*p = px->nchar;
			 }
			break;

		case 'j':
			 {	/* store into intmax_t */
			intmax_t *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, intmax_t *);
			*p = px->nchar;
			 }
			break;

		case 't':
			 {	/* store into ptrdiff_t */
			ptrdiff_t *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, ptrdiff_t *);
			*p = px->nchar;
			 }
			break;

		case 'z':
			 {	/* store into size_t */
			size_t *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, size_t *);
			*p = px->nchar;
			 }
			break;

		case 'h':
			 {	/* store into signed short */
			short *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, short *);
			*p = px->nchar;
			 }
			break;

		case 'l':
			 {	/* store into signed long */
			long *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, long *);
			*p = px->nchar;
			 }
			break;

		default:
			 {	/* store into signed int */
			int *p = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				p = va_arg(*pap, int *);
			*p = px->nchar;
			 }
			}
		break;

	case 'p':
		 {	/* convert a pointer, hex long version */
		static const size_t vpsize = sizeof (void *);	/* quiet diagnostic */
		void *pv = 0;	/* initialized to quiet diagnostics */

		for (; 0 <= px->argno; --px->argno)
			pv = va_arg(*pap, void *);
		px->v.li = (_Longlong)((char *)pv - (char *)0);
		if (vpsize == sizeof (unsigned long))
			px->v.li &= ULONG_MAX;
		px->s = &ac[px->n0];
		_Litob(px, 'x');
		 }
		break;

	case 'S':	/* convert a wide string -- nonstandard */
		px->qual = 'l';	/* fall through */

	case 's':	/* convert a string */
		if (px->qual != 'l')
			{	/* put narrow string */
			char *s1;

			for (; 0 <= px->argno; --px->argno)
				px->s = va_arg(*pap, char *);
			px->n1 = px->prec < 0 ? strlen(px->s)
				: (s1 = (char *)memchr((void *)px->s, '\0',
					px->prec)) != 0 ? s1 - px->s : px->prec;
			}
		else
			{	/* put wide string */
			wchar_t *ws1 = 0;	/* initialized to quiet diagnostics */

			for (; 0 <= px->argno; --px->argno)
				ws1 = va_arg(*pap, wchar_t *);
			if (_Putstr(px, ws1) < 0)
				return (EOF);
			}
		break;

	case '%':	/* put a '%' */
		ac[px->n0++] = '%';
		break;

	default:	/* undefined specifier, print it out */
		ac[px->n0++] = '%';
		if (code != '\0')
			ac[px->n0++] = code;
		}
	return (0);
			}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
