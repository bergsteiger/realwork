// locale -- class locale member functions
#include <cstdlib>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#include <istream>
#include <xlocale>

#if defined(_WIN32)
#include <_locale.h>
#endif

 #ifndef _CAT_TO_LC
  #define _CAT_TO_LC(cat)	(cat)
 #endif /* _CAT_TO_LC */

_C_STD_BEGIN
_EXTERN_C
void *_CDECL _Getgloballocale();

void _CDECL _Setgloballocale(void *);
_END_EXTERN_C
_C_STD_END

_STD_BEGIN
typedef char_traits<char> _Traits;
typedef istreambuf_iterator<char, _Traits> _Initer;
typedef ostreambuf_iterator<char, _Traits> _Outiter;

locale _CDECL locale::global(const locale& loc)
	{	// change global locale
	locale _Oldglobal;
	_Lockit lock(_LOCK_LOCALE);
	locale::_Locimp *_Ptr = _Getgloballocale();

	if (_Ptr != loc._Ptr)
		{	// set new global locale
		delete _Ptr->_Decref();
		_Setgloballocale(_Ptr = loc._Ptr);
		_Ptr->_Incref();
		category _Cmask = _Ptr->_Catmask & all;
		if (_Cmask == all)
			setlocale(LC_ALL, _Ptr->_Name.c_str());
		else
			for (int catindex = 0; catindex <= _X_MAX; ++catindex)
				if ((_CATMASK(catindex) & _Cmask) != 0)
					setlocale(_CAT_TO_LC(catindex), _Ptr->_Name.c_str());
		}
	return (_Oldglobal);
	}

	// facets associated with C categories
#define ADDFAC(Facet, cat, ptrimp, ptrloc) \
	if ((_CATMASK(Facet::_Getcat()) & cat) == 0) \
		; \
	else if (ptrloc == 0) \
		ptrimp->_Addfac(new Facet(lobj), Facet::id); \
	else \
		ptrimp->_Addfac((locale::facet *)&_USE(*ptrloc, Facet), Facet::id);

typedef ctype<char> _T1;
typedef num_get<char, _Initer> _T2;
typedef num_put<char, _Outiter> _T3;
typedef numpunct<char> _T4;
// others moved to wlocale and xlocale to ease subsetting
typedef codecvt<char, char, _Mbstatet> _Tc1;

locale::_Locimp *_CDECL locale::_Locimp::_Makeloc(const _Locinfo& lobj,
	locale::category cat, _Locimp *ptrimp, const locale *ptrloc)
	{	// setup a new locale
	ADDFAC(_T1, cat, ptrimp, ptrloc);
	ADDFAC(_T2, cat, ptrimp, ptrloc);
	ADDFAC(_T3, cat, ptrimp, ptrloc);
	ADDFAC(_T4, cat, ptrimp, ptrloc);
	//...
	ADDFAC(_Tc1, cat, ptrimp, ptrloc);

	_Locimp::_Makexloc(lobj, cat, ptrimp, ptrloc);
	_Locimp::_Makewloc(lobj, cat, ptrimp, ptrloc);
	return (ptrimp);
	}

locale::_Locimp::_Locimp(const locale::_Locimp& imp)
	: locale::facet(1), _Facetvec(0), _Facetcount(imp._Facetcount),
		_Catmask(imp._Catmask), _Xparent(imp._Xparent),
		_Name(imp._Name.c_str())
	{	// construct a _Locimp from a copy
	if (&imp == _Clocptr)
		_Makeloc(_Locinfo(), locale::all, this, 0);
	else
		{	// lock to keep facets from disappearing
		_Lockit lock(_LOCK_LOCALE);
		if (0 < _Facetcount)
			{	// copy over nonempty facet vector
			if ((_Facetvec = (locale::facet **)_CSTD malloc(
				_Facetcount * sizeof (locale::facet *))) == 0)
				_Xbad_alloc();	// report no memory
			for (size_t count = _Facetcount; 0 < count; )
				{	// copy over facet pointers
				locale::facet *ptrfac = imp._Facetvec[--count];
				if ((_Facetvec[count] = ptrfac) != 0)
					ptrfac->_Incref();
				}
			}
		}
	}

void locale::_Locimp::_Addfac(locale::facet *ptrfac, size_t id)
	{	// add a facet to a locale
	_Lockit lock(_LOCK_LOCALE);
	const size_t MINCAT = 40;	// minimum number of facets in a locale

	if (_Facetcount <= id)
		{	// make facet vector larger
		size_t count = id + 1;
		if (count < MINCAT)
			count = MINCAT;
		locale::facet **ptrnewvec = (locale::facet **)realloc(_Facetvec,
			count * sizeof (locale::facet **));
		if (ptrnewvec == 0)
				_Xbad_alloc();	// report no memory

		_Facetvec = ptrnewvec;
		for (; _Facetcount < count; ++_Facetcount)
			_Facetvec[_Facetcount] = 0;
		}

	ptrfac->_Incref();
	if (_Facetvec[id] != 0)
		delete _Facetvec[id]->_Decref();
	_Facetvec[id] = ptrfac;
	}

_CRTIMP2 _Locinfo::_Locinfo(int cat, const char *locname)
//	: _Lock(_LOCK_LOCALE)
	{	// capture a named locale
	const char *oldlocname = setlocale(LC_ALL, 0);

	_Oldlocname = oldlocname == 0 ? "" : oldlocname;
	_Addcats(cat, locname);
	}

_CRTIMP2 _Locinfo& _Locinfo::_Addcats(int cat, const char *locname)
	{	// merge in another named locale
	if (locname == 0)
		_Xruntime_error("bad locale name");
	else if (cat == 0)
		;	// leave unchanged
	else if (locname[0] == '*' && locname[1] == '\0')
		_Newlocname = "*";	// set to bad locale name
	else if (cat == _M_ALL)
		{	// switch to complete new locale
		char *oldlocname = setlocale(LC_ALL, 0);	// save old
		char *newname = setlocale(LC_ALL, locname);	// set new
#if defined(_WIN32)
                _Page =  __locale->isCLocale ? 0 : __locale->codepage;
                _Handle =  __locale->isCLocale ? 0 : __locale->handle;
#endif
		setlocale(LC_ALL, oldlocname);	// revert old
		_Newlocname = newname == 0 ? "*" : newname;
		}
	else if (strcmp(_Newlocname.c_str(), "*") != 0)
		{	// alter selected categories
		char *oldlocname = setlocale(LC_ALL, 0);	// save old
		char *newname = 0;
		setlocale(LC_ALL, _Newlocname.c_str());	// copy current
		for (int catindex = 0; catindex <= _X_MAX; ++catindex)
			if ((_CATMASK(catindex) & cat) != 0)
				newname = setlocale(_CAT_TO_LC(catindex), locname);
		setlocale(LC_ALL, oldlocname);	// revert old
		_Newlocname = newname == 0 ? "*" : newname;
		}
	return (*this);
	}
_STD_END
 #endif /* _IS_EMBEDDED */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 +codepage*/
