// locale0 -- class locale basic member functions
#include <climits>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#include <xlocale>

#if defined(_WIN32)
#include <_locale.h>
#endif

_STD_BEGIN
struct _Fac_deletable
	: public locale::facet
	{	// expose facet destructor
	~_Fac_deletable() _NOEXCEPT
		{	// destroy the locale
		}
	};

struct _Fac_node
	{	// node for lazy facet recording
	_Fac_node(_Fac_node *_Nextarg, _STD locale::facet *_Facptrarg)
		: _Next(_Nextarg), _Facptr(_Facptrarg)
		{	// construct a node with value
		}

	~_Fac_node() _NOEXCEPT
		{	// destroy a facet
		delete _Facptr->_Decref();
		}

	_Fac_node *_Next;
	_STD locale::facet *_Facptr;
	};

static _Fac_node *_Fac_head = 0;
_STD_END

_C_STD_BEGIN
_EXTERN_C
void _CDECL _Fac_tidy()
	{	// destroy lazy facets
	_STD _Lockit lock(_LOCK_LOCALE);	// prevent double deletes (from 5.30)
	while (_STD _Fac_head != 0)
		{	// destroy a lazy facet node
		_STD _Fac_node *nodeptr = _STD _Fac_head;
		_STD _Fac_head = nodeptr->_Next;
		delete nodeptr;
		}
	}

void _CDECL _Deletegloballocale(void *ptr)
	{	// delete a global locale reference
	_STD locale::_Locimp *locptr = *(_STD locale::_Locimp **)ptr;
	if (locptr != 0)
		delete locptr->_Decref();
	}

 #if _HAS_DINKUM_CLIB
void *_CDECL _Getgloballocale();

void _CDECL _Setgloballocale(void *);

 #else /* _HAS_DINKUM_CLIB */
static _STD locale::_Locimp *global_locale = 0;	// pointer to current locale

static void _CDECL tidy_global()
	{	// delete static global locale reference
	_STD _Lockit lock(_LOCK_LOCALE);	// prevent double delete
	_Deletegloballocale(&global_locale);
	}

void *_CDECL _Getgloballocale()
	{	// return pointer to current locale
	return (global_locale);
	}

void _CDECL _Setgloballocale(void *ptr)
	{	// alter pointer to current locale
	static bool registered = false;

	if (!registered)
		{	// register cleanup first time
		registered = true;
		_CSTD _Atexit(&tidy_global);
		}
	global_locale = (_STD locale::_Locimp *)ptr;
	}
 #endif /* _HAS_DINKUM_CLIB */

_END_EXTERN_C
_C_STD_END

_STD_BEGIN
static locale classic_locale(_Noinit);	// "C" locale object, uninitialized
locale::_Locimp *locale::_Locimp::_Clocptr = 0;	// pointer to classic_locale
int locale::id::_Id_cnt = 0;	// unique id counter for facets

locale::id ctype<char>::id(0);
locale::id ctype<wchar_t>::id(0);
locale::id codecvt<wchar_t, char, _Mbstatet>::id(0);

 #if _HAS_CHAR16_T_LANGUAGE_SUPPORT
locale::id codecvt<char16_t, char, _Mbstatet>::id(0);
locale::id codecvt<char32_t, char, _Mbstatet>::id(0);
 #endif /* _HAS_CHAR16_T_LANGUAGE_SUPPORT */

const size_t ctype<char>::table_size =
	1 << CHAR_BIT;	// size of ctype mapping table, typically 256

 #if defined(__BORLANDC__) && !__EDG__	/* compiler test */
static const size_t *table_sizep = &ctype<char>::table_size;	// kludge
 #endif /* defined (__BORLANDC__) && !__EDG__ */

const locale& _CDECL locale::classic()
	{	// get reference to "C" locale
	_Init();
	return (classic_locale);
	}

_CRTIMP2 locale _CDECL locale::empty()
	{	// make empty transparent locale
	_Init();
	return (locale(_Locimp::_New_Locimp(true)));
	}

locale::_Locimp *_CDECL locale::_Init(bool _Do_incref)
	{	// setup global and "C" locales
	locale::_Locimp *ptr = 0;
	_Lockit lock(_LOCK_LOCALE);	// prevent double initialization

	ptr = _Getgloballocale();
	if (ptr == 0)
		{	// create new locales
		_Setgloballocale(ptr = _Locimp::_New_Locimp());
		ptr->_Catmask = all;	// set current locale to "C"
		ptr->_Name = "C";

		_Locimp::_Clocptr = ptr;	// set classic to match
		_Locimp::_Clocptr->_Incref();
		new (&classic_locale) locale(_Locimp::_Clocptr);
		}

	if (_Do_incref)
		ptr->_Incref();
	return (ptr);
	}

_MRTIMP2 locale::_Locimp *_CDECL locale::_Getgloballocale()
	{	// get global locale
	return ((_Locimp *)_CSTD _Getgloballocale());
	}

_MRTIMP2 void _CDECL locale::_Setgloballocale(void *_Loc)
	{	// set global locale
	_CSTD _Setgloballocale(_Loc);
	}

_CRTIMP2 void locale::facet::_Register()
	{	// queue up lazy facet for destruction
	if (_Fac_head == 0)
		_CSTD _Atexit(&_CSTD _Fac_tidy);

	_Fac_head = new _Fac_node(_Fac_head, this);
	}

_CRTIMP2 locale::_Locimp::_Locimp(bool transparent)
	: locale::facet(1), _Facetvec(0), _Facetcount(0),
		_Catmask(none), _Xparent(transparent), _Name("*")
	{	// construct an empty _Locimp
	}

_CRTIMP2 locale::_Locimp::~_Locimp() _NOEXCEPT
	{	// destruct a _Locimp
	_Lockit lock(_LOCK_LOCALE);	// prevent double delete
	for (size_t count = _Facetcount; 0 < count; )
		if (_Facetvec[--count] != 0)
			delete _Facetvec[count]->_Decref();
	_CSTD free(_Facetvec);
	}

_CRTIMP2 _Locinfo::_Locinfo(const char *locname)
//	: _Lock(_LOCK_LOCALE)
	{	// switch to a named locale
	const char *oldlocname = setlocale(LC_ALL, 0);

	_Oldlocname = oldlocname == 0 ? "" : oldlocname;
	if (locname != 0)
		locname = setlocale(LC_ALL, locname);
#if defined(_WIN32)
	_Page =  __locale->isCLocale ? 0 : __locale->codepage;
	_Handle =  __locale->isCLocale ? 0 : __locale->handle;
#endif
	_Newlocname = locname == 0 ? "*" : locname;
	}

_CRTIMP2 _Locinfo::_Locinfo(const string& locstr)
//	: _Lock(_LOCK_LOCALE)
	{	// switch to a named locale
	const char *locname = locstr.c_str();
	const char *oldlocname = setlocale(LC_ALL, 0);

	_Oldlocname = oldlocname == 0 ? "" : oldlocname;
	if (locname != 0)
		locname = setlocale(LC_ALL, locname);
#if defined(_WIN32)
	_Page =  __locale->isCLocale ? 0 : __locale->codepage;
	_Handle =  __locale->isCLocale ? 0 : __locale->handle;
#endif
	_Newlocname = locname == 0 ? "*" : locname;
	}

_CRTIMP2 _Locinfo::~_Locinfo() _NOEXCEPT
	{	// destroy a _Locinfo object, revert locale
	if (!_Oldlocname.empty())
		setlocale(LC_ALL, _Oldlocname.c_str());
	}
_STD_END
 #endif /* _IS_EMBEDDED */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 +codepage*/
