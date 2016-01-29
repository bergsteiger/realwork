////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/DOMNodeEx.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::DOMNodeEx
//
// обёртка для работы с узлом DOM-а, перекодирует данные в заданную кодировку
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"
// by <<uses>> dependencies
#include "shared/XercesHelpers/wrappers/XStr.h"
#include "shared/XercesHelpers/wrappers/XMLStrUnicode.h"
#include "shared/XercesHelpers/wrappers/XercesHelper.h"

//#UC START# *491C2DF10320_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMElement.hpp"
#include "xercesc/dom/DOMNodeList.hpp"

#include "shared/XercesHelpers/wrappers/defines.h"
#include "shared/XercesHelpers/wrappers/exceptions.h"
//#UC END# *491C2DF10320_CUSTOM_INCLUDES*

namespace XercesHelpers {

//#UC START# *491C2DF10320*
//#UC END# *491C2DF10320*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DOMNodeEx::DOMNodeEx (XERCES_CPP_NAMESPACE::DOMNode* node)
//#UC START# *491D78330354_BASE_INIT*
: m_node (node)
//#UC END# *491D78330354_BASE_INIT*
{
	//#UC START# *491D78330354_BODY*
	//#UC END# *491D78330354_BODY*
}

DOMNodeEx::DOMNodeEx (XERCES_CPP_NAMESPACE::DOMElement* parent, const char* tag, bool accept_first_tag)
//#UC START# *491D78990080_BASE_INIT*
: m_node (0)
//#UC END# *491D78990080_BASE_INIT*
{
	//#UC START# *491D78990080_BODY*
	XMLStrUnicode tagname (tag);
	XERCES_CPP_NAMESPACE::DOMNodeList* list = parent->getElementsByTagName (tagname.data ());

	if (!list->getLength () || (list->getLength () > 1 && !accept_first_tag)) {
		throw InvalidXML ();
	}

	m_node = list->item (0);
	//#UC END# *491D78990080_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить DOM узел
XERCES_CPP_NAMESPACE::DOMNode* DOMNodeEx::get () const {
	//#UC START# *491D804B00B8*
	return m_node; 
	//#UC END# *491D804B00B8*
}

// получить атрибут с заданным именем
char* DOMNodeEx::get_attribute (const char* name) const {
	//#UC START# *491D7A3F017B*
	const XMLCh *attr = this->get_element ()->getAttribute (
		X (name)
	);
	return XercesHelper::instance ()->transcode (attr);
	//#UC END# *491D7A3F017B*
}

// получить атрибут xml-ного тега
char* DOMNodeEx::get_attribute (const XMLCh* name) const {
	//#UC START# *491D7DF603A3*
	const XMLCh* attr = this->get_element ()->getAttribute (name);
	return XercesHelper::instance ()->transcode (attr); 
	//#UC END# *491D7DF603A3*
}

// получить список дочерних узлов
XERCES_CPP_NAMESPACE::DOMNodeList* DOMNodeEx::get_child_nodes () const {
	//#UC START# *491D799600DE*
	return m_node->getChildNodes ();
	//#UC END# *491D799600DE*
}

// получить DOM элемент
XERCES_CPP_NAMESPACE::DOMElement* DOMNodeEx::get_element () const {
	//#UC START# *491D801A00FD*
	return static_cast <XERCES_CPP_NAMESPACE::DOMElement*>(m_node); 
	//#UC END# *491D801A00FD*
}

// получить список узлов с заданным именем
XERCES_CPP_NAMESPACE::DOMNodeList* DOMNodeEx::get_elements_by_tag_name (const char* tag_name) const {
	//#UC START# *491D79C8011F*
	XMLStrUnicode tag (tag_name);
	return this->get_element ()->getElementsByTagName (tag.data ());
	//#UC END# *491D79C8011F*
}

// получить список узлов с заданным именем
XERCES_CPP_NAMESPACE::DOMNodeList* DOMNodeEx::get_elements_by_tag_name (const XMLCh* tag_name) const {
	//#UC START# *491D7A290397*
	return this->get_element ()->getElementsByTagName (tag_name);
	//#UC END# *491D7A290397*
}

// получить атрибут xml-ного тега
int DOMNodeEx::get_int_attribute (const char* name) const {
	//#UC START# *491D7E0E01B6*
	XMLStr attr (this->get_attribute (name));
	return ACE_OS::atoi (attr.in ());
	//#UC END# *491D7E0E01B6*
}

// получить атрибут xml-ного тега
long DOMNodeEx::get_long_attribute (const char* name) const {
	//#UC START# *491D7E2F0047*
	XMLStr attr (this->get_attribute (name));
	return atol (attr.in ());
	//#UC END# *491D7E2F0047*
}

// получить атрибут xml-ного тега
long DOMNodeEx::get_long_attribute (const XMLCh* name) const {
	//#UC START# *491D7E4F0343*
	XMLStr attr (this->get_attribute (name));
	return atol (attr.in ());
	//#UC END# *491D7E4F0343*
}

// получить имя узла
const XMLCh* DOMNodeEx::get_node_name () const {
	//#UC START# *491D808601FA*
	return m_node->getNodeName (); 
	//#UC END# *491D808601FA*
}

// получить содержимое тега - <tag>содержимое тега</tag>
char* DOMNodeEx::get_text () const {
	//#UC START# *491D8034000E*
	const XMLCh* text = m_node->getTextContent ();
	return XercesHelper::instance ()->transcode (text); 
	//#UC END# *491D8034000E*
}

// получить тип DOM объекта
long DOMNodeEx::get_type () const {
	//#UC START# *491D80630357*
	return m_node->getNodeType ();
	//#UC END# *491D80630357*
}

// есть ли у элемента дочерние узлы
bool DOMNodeEx::has_child_nodes () const {
	//#UC START# *491D809E00E9*
	return m_node->hasChildNodes ();
	//#UC END# *491D809E00E9*
}

// является ли элемент атрибутом
bool DOMNodeEx::is_attribute (const XMLCh* str, const char* attr_name) const {
	//#UC START# *491D7EBA00E3*
	const XMLCh* attr = this->get_element()->getAttribute (
		X(attr_name)
	);
	return (!XERCES_CPP_NAMESPACE::XMLString::compareString (str, attr));
	//#UC END# *491D7EBA00E3*
}

// является ли объект элементом
bool DOMNodeEx::is_element () const {
	//#UC START# *491D80B50054*
	return (m_node->getNodeType () == XERCES_CPP_NAMESPACE::DOMNode::ELEMENT_NODE);
	//#UC END# *491D80B50054*
}

// является ли элемент тегом
bool DOMNodeEx::is_tag (const XMLCh* str) const {
	//#UC START# *491D7E7102BA*
	return !XERCES_CPP_NAMESPACE::XMLString::compareString (str, m_node->getNodeName ());
	//#UC END# *491D7E7102BA*
}

// содержит ли обёртка ссылку на DOM объект
bool DOMNodeEx::is_valid () const {
	//#UC START# *491D80C50206*
	return m_node; 
	//#UC END# *491D80C50206*
}

} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

