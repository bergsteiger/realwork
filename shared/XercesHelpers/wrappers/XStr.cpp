////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/XStr.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::XStr
//
// обёртка для получения строки с конвертацией с использованием установленной для адаптера кодировки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/XercesHelpers/wrappers/XStr.h"
// by <<uses>> dependencies
#include "shared/XercesHelpers/wrappers/XercesHelper.h"

//#UC START# *491D649501AC_CUSTOM_INCLUDES*
#include <boost/lexical_cast.hpp>
//#UC END# *491D649501AC_CUSTOM_INCLUDES*

namespace XercesHelpers {

//#UC START# *491D649501AC*
	XStr::XStr (const char* const to_transcode) {
		XercesHelper::instance ()->transcode (to_transcode, m_unicode_form.inout ());
	}

	XStr::XStr (int value) {
		std::string str = boost::lexical_cast<std::string> (value);
		XercesHelper::instance ()->transcode (str.c_str (), m_unicode_form.inout ());
	}

	XStr::XStr (unsigned int value) {
		std::string str = boost::lexical_cast<std::string> (value);
		XercesHelper::instance ()->transcode (str.c_str (), m_unicode_form.inout ());
	}

	XStr::XStr (ACE_UINT64 value) {
		std::string str = boost::lexical_cast<std::string> (value);
		XercesHelper::instance ()->transcode (str.c_str (), m_unicode_form.inout ());
	}

	XStr::XStr (ACE_INT64 value) {
		std::string str = boost::lexical_cast<std::string> (value);
		XercesHelper::instance ()->transcode (str.c_str (), m_unicode_form.inout ());
	}

	YStr::YStr (const char* const to_transcode) {
		m_unicode_form = XERCES_CPP_NAMESPACE::XMLString::transcode (to_transcode);
	}

	YStr::~YStr () {
		XERCES_CPP_NAMESPACE::XMLString::release (&m_unicode_form);
	}
//#UC END# *491D649501AC*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor


} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

