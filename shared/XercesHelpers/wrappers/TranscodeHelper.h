////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/TranscodeHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::TranscodeHelper
//
// перекодировщик строк
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_TRANSCODEHELPER_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_TRANSCODEHELPER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *491C2F1503A1_CUSTOM_INCLUDES*
#include "xercesc/util/PlatformUtils.hpp"
#include "xercesc/util/TransService.hpp"
//#UC END# *491C2F1503A1_CUSTOM_INCLUDES*

namespace XercesHelpers {

// перекодировщик строк
class TranscodeHelper {
	SET_OBJECT_COUNTER (TranscodeHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit TranscodeHelper (const char* encoding);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// установить кодировку xml
	void change_encoding (const char* encoding);

	// перекодировка строки
	char* transcode (const XMLCh* from) const;

	// перекодировка строки
	XMLCh* transcode (const char* from) const;

	// перекодировка строки
	void transcode (const char* from, XMLCh*& to) const;


//#UC START# *491C2F1503A1*
private:
	friend class XercesHelper;

private:
	TranscodeHelper (const TranscodeHelper&);
	TranscodeHelper& operator = (const TranscodeHelper&);

private:
	mutable Core::Aptr<XERCES_CPP_NAMESPACE::XMLTranscoder> m_trans;
	mutable Core::Mutex m_mutex;
//#UC END# *491C2F1503A1*
}; // class TranscodeHelper

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_TRANSCODEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

