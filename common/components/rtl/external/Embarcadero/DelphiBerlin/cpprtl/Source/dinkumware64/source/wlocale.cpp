// wlocale -- class locale wide member functions
#include <istream>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#include <locale>
_STD_BEGIN
typedef char_traits<wchar_t> _Wtraits;
typedef istreambuf_iterator<wchar_t, _Wtraits> _Winiter;
typedef ostreambuf_iterator<wchar_t, _Wtraits> _Woutiter;

	// facets associated with C categories
#define ADDFAC(Facet, cat, ptrimp, ptrloc) \
	if ((_CATMASK(Facet::_Getcat()) & cat) == 0) \
		; \
	else if (ptrloc == 0) \
		ptrimp->_Addfac(new Facet(lobj), Facet::id); \
	else \
		ptrimp->_Addfac((locale::facet *)&_USE(*ptrloc, Facet), Facet::id);

// moved from locale to ease subsetting
typedef ctype<wchar_t> _Tw1;
typedef num_get<wchar_t, _Winiter> _Tw2;
typedef num_put<wchar_t, _Woutiter> _Tw3;
typedef numpunct<wchar_t> _Tw4;
typedef collate<wchar_t> _Tw5;
typedef messages<wchar_t> _Tw6;
typedef money_get<wchar_t, _Winiter> _Tw7;
typedef money_put<wchar_t, _Woutiter> _Tw9;
typedef moneypunct<wchar_t, false> _Tw11;
typedef moneypunct<wchar_t, true> _Tw12;
typedef time_get<wchar_t, _Winiter> _Tw13;
typedef time_put<wchar_t, _Woutiter> _Tw14;
//....
typedef codecvt<wchar_t, char, _Mbstatet> _Twc1;

 #if _HAS_CPP0X
typedef codecvt<char16_t, char, _Mbstatet> _Twc2;
typedef codecvt<char32_t, char, _Mbstatet> _Twc3;
 #endif /* _HAS_CPP0X */

 #if 0 < _MSC_VER	// preserve for EDG atop VC++
locale::id time_put<wchar_t, _Woutiter>::id(0);

 #else /* 0 < _MSC_VER */
template<> locale::id time_put<wchar_t, _Woutiter>::id(0);
 #endif /* 0 < _MSC_VER */

 #if __INTEL_COMPILER	/* compiler test */
const bool moneypunct<wchar_t, false>::intl = false;
const bool moneypunct<wchar_t, true>::intl = true;
 #endif /* __INTEL_COMPILER */

void _CDECL locale::_Locimp::_Makewloc(const _Locinfo& lobj,
	locale::category cat, _Locimp *ptrimp, const locale *ptrloc)
	{	// setup wide part of a new locale
	ADDFAC(_Tw1, cat, ptrimp, ptrloc);
	ADDFAC(_Tw2, cat, ptrimp, ptrloc);
	ADDFAC(_Tw3, cat, ptrimp, ptrloc);
	ADDFAC(_Tw4, cat, ptrimp, ptrloc);
	ADDFAC(_Tw5, cat, ptrimp, ptrloc);
	ADDFAC(_Tw6, cat, ptrimp, ptrloc);
	ADDFAC(_Tw7, cat, ptrimp, ptrloc);
	ADDFAC(_Tw9, cat, ptrimp, ptrloc);
	ADDFAC(_Tw11, cat, ptrimp, ptrloc);
	ADDFAC(_Tw12, cat, ptrimp, ptrloc);
	ADDFAC(_Tw13, cat, ptrimp, ptrloc);
	ADDFAC(_Tw14, cat, ptrimp, ptrloc);
	//...
	ADDFAC(_Twc1, cat, ptrimp, ptrloc);

 #if _HAS_CPP0X
	ADDFAC(_Twc2, cat, ptrimp, ptrloc);
	ADDFAC(_Twc3, cat, ptrimp, ptrloc);
 #endif /* _HAS_CPP0X */
	}
_STD_END
 #endif /* _IS_EMBEDDED */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
