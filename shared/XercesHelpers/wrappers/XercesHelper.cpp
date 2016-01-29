////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/XercesHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::XercesHelper
//
// получение узлов и их атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/XercesHelpers/wrappers/XercesHelper.h"
// by <<uses>> dependencies
#include "shared/XercesHelpers/wrappers/XStr.h"

//#UC START# *491C2F420352_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMDocument.hpp"
#include "xercesc/dom/DOMElement.hpp"
#include "xercesc/dom/DOMText.hpp"
//#UC END# *491C2F420352_CUSTOM_INCLUDES*

namespace XercesHelpers {

//#UC START# *491C2F420352*
char* XercesHelper::transcode (const XMLCh* from) const {
	GUARD (m_mutex);
	return m_transcode_helper->transcode (from);
}

void XercesHelper::transcode (const char* from, XMLCh*& to) const {
	GUARD (m_mutex);
	return m_transcode_helper->transcode (from, to);
}
//#UC END# *491C2F420352*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

XercesHelper::XercesHelper ()
//#UC START# *491D8DEB0183_BASE_INIT*
//#UC END# *491D8DEB0183_BASE_INIT*
{
	//#UC START# *491D8DEB0183_BODY*
	XERCES_CPP_NAMESPACE::XMLPlatformUtils::Initialize ();
	m_transcode_helper = new TranscodeHelper ("windows-1251");
	//#UC END# *491D8DEB0183_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить текстовый DOM узел к указанному DOM объекту
XERCES_CPP_NAMESPACE::DOMNode* XercesHelper::add_text_node (
	XERCES_CPP_NAMESPACE::DOMDocument* doc
	, XERCES_CPP_NAMESPACE::DOMNode* node
	, const char* text
) {
	//#UC START# *491D905B03E0*
	GUARD (m_mutex);
	XERCES_CPP_NAMESPACE::DOMText* text_node = doc->createTextNode (X(text));
	return node->appendChild (text_node);
	//#UC END# *491D905B03E0*
}

// изменить кодировку
void XercesHelper::change_encoding (const char* locale) {
	//#UC START# *491D8E0F02CD*
	GUARD (m_mutex);
	m_transcode_helper = new TranscodeHelper ("windows-1251");
	m_transcode_helper->change_encoding (locale);
	//#UC END# *491D8E0F02CD*
}

// создать DOM элемент
XERCES_CPP_NAMESPACE::DOMElement* XercesHelper::create_element (
	XERCES_CPP_NAMESPACE::DOMDocument* doc
	, const char* name
) {
	//#UC START# *491D90010125*
	GUARD (m_mutex);
	return doc->createElement (X(name));
	//#UC END# *491D90010125*
}

// создать текстовый DOM узел
XERCES_CPP_NAMESPACE::DOMText* XercesHelper::create_text_node (
	XERCES_CPP_NAMESPACE::DOMDocument* doc
	, const char* text
) {
	//#UC START# *491D90350197*
	GUARD (m_mutex);
	return doc->createTextNode (X(text));
	//#UC END# *491D90350197*
}

// получить атрибут
char* XercesHelper::get_attribute (XERCES_CPP_NAMESPACE::DOMElement* element, const char* name) {
	//#UC START# *491D8F5700A3*
	GUARD (m_mutex);
	const XMLCh *attr = element->getAttribute (X(name));
	return m_transcode_helper->transcode (attr); 
	//#UC END# *491D8F5700A3*
}

// получить перекодированную строку
XMLCh* XercesHelper::get_string (const char* to_transcode) const {
	//#UC START# *491D8E5E00FA*
	GUARD (m_mutex);
	return m_transcode_helper->transcode (to_transcode); 
	//#UC END# *491D8E5E00FA*
}

// получить перекодированную строку
char* XercesHelper::get_string (const XMLCh* to_transcode) const {
	//#UC START# *491D8EE8012D*
	GUARD (m_mutex);
	return m_transcode_helper->transcode (to_transcode); 
	//#UC END# *491D8EE8012D*
}

// установить атрибут
void XercesHelper::set_attribute (XERCES_CPP_NAMESPACE::DOMElement* element, const char* name, const char* value) {
	//#UC START# *491D8FBA02F8*
	GUARD (m_mutex);
	element->setAttribute (X(name), X(value));
	//#UC END# *491D8FBA02F8*
}

// установить атрибут
void XercesHelper::set_attribute (XERCES_CPP_NAMESPACE::DOMElement* element, const char* name, int value) {
	//#UC START# *491D8FE80330*
	GUARD (m_mutex);
	element->setAttribute (X(name), X(value));
	//#UC END# *491D8FE80330*
}

} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

