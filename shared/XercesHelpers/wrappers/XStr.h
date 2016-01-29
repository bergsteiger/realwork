////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/XStr.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::XStr
//
// обёртка для получения строки с конвертацией с использованием установленной для адаптера кодировки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_XSTR_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_XSTR_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *491D649501AC_CUSTOM_INCLUDES*
#include "xercesc/util/XercesDefs.hpp"

namespace XercesHelpers {

class TranscodeHelper;
class XStr;

// обёртка для получения строки с конвертацией с использованием текущей кодировки
// осталась для DocumentManager-а
class YStr {
	friend class DocumentManager;
private :
	YStr (const char* const to_transcode);
	~YStr ();

	inline const XMLCh* get_unicode_form () const {
		return m_unicode_form;
	}
private :
	// This is the Unicode XMLCh format of the string.
	XMLCh* m_unicode_form; // This is the Unicode XMLCh format of the string.
};

#define X(value) XStr (value).get_unicode_form ()
#define Y(value) YStr (value).get_unicode_form ()

}
//#UC END# *491D649501AC_CUSTOM_INCLUDES*

namespace XercesHelpers {

// обёртка для получения строки с конвертацией с использованием установленной для адаптера кодировки
class XStr {
	SET_OBJECT_COUNTER (XStr)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

//#UC START# *491D649501AC*
friend class DOMNodeEx;
	friend class XercesHelper;
private :
	XStr (const char* const to_transcode);
	XStr (int value);
	XStr (unsigned int value);
	XStr (ACE_INT64 value);
	XStr (ACE_UINT64 value);

	inline const XMLCh* get_unicode_form () const {
		return m_unicode_form.ptr ();
	}
private :
	// This is the Unicode XMLCh format of the string.
	Core::Aptr<XMLCh, Core::ArrayDeleteDestructor<XMLCh> > m_unicode_form;
//#UC END# *491D649501AC*
}; // class XStr

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_XSTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

