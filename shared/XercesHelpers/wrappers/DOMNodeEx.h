////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/DOMNodeEx.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::DOMNodeEx
//
// обёртка для работы с узлом DOM-а, перекодирует данные в заданную кодировку
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_DOMNODEEX_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_DOMNODEEX_H__

#include "shared/Core/sys/std_inc.h"
#include "xercesc/dom/DOMElement.hpp"
#include "xercesc/dom/DOMNode.hpp"
#include "xercesc/dom/DOMNodeList.hpp"

//#UC START# *491C2DF10320_CUSTOM_INCLUDES*
#include "xercesc/util/XercesVersion.hpp"
#include "xercesc/util/XercesDefs.hpp"

namespace XERCES_CPP_NAMESPACE {
	class DOMElement;
	class DOMNode;
	class DOMNodeList;
}
//#UC END# *491C2DF10320_CUSTOM_INCLUDES*

namespace XercesHelpers {

// обёртка для работы с узлом DOM-а, перекодирует данные в заданную кодировку
class DOMNodeEx {
	SET_OBJECT_COUNTER (DOMNodeEx)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit DOMNodeEx (XERCES_CPP_NAMESPACE::DOMNode* node = 0);

	DOMNodeEx (XERCES_CPP_NAMESPACE::DOMElement* parent, const char* tag, bool accept_first_tag = true);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// получить DOM узел
	XERCES_CPP_NAMESPACE::DOMNode* get () const;

	// получить атрибут с заданным именем
	char* get_attribute (const char* name) const;

	// получить атрибут xml-ного тега
	char* get_attribute (const XMLCh* name) const;

	// получить список дочерних узлов
	XERCES_CPP_NAMESPACE::DOMNodeList* get_child_nodes () const;

	// получить DOM элемент
	XERCES_CPP_NAMESPACE::DOMElement* get_element () const;

	// получить список узлов с заданным именем
	XERCES_CPP_NAMESPACE::DOMNodeList* get_elements_by_tag_name (const char* tag_name) const;

	// получить список узлов с заданным именем
	XERCES_CPP_NAMESPACE::DOMNodeList* get_elements_by_tag_name (const XMLCh* tag_name) const;

	// получить атрибут xml-ного тега
	int get_int_attribute (const char* name) const;

	// получить атрибут xml-ного тега
	long get_long_attribute (const char* name) const;

	// получить атрибут xml-ного тега
	long get_long_attribute (const XMLCh* name) const;

	// получить имя узла
	const XMLCh* get_node_name () const;

	// получить содержимое тега - <tag>содержимое тега</tag>
	char* get_text () const;

	// получить тип DOM объекта
	long get_type () const;

	// есть ли у элемента дочерние узлы
	bool has_child_nodes () const;

	// является ли элемент атрибутом
	bool is_attribute (const XMLCh* str, const char* attr_name) const;

	// является ли объект элементом
	bool is_element () const;

	// является ли элемент тегом
	bool is_tag (const XMLCh* str) const;

	// содержит ли обёртка ссылку на DOM объект
	bool is_valid () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	XERCES_CPP_NAMESPACE::DOMNode* m_node;

//#UC START# *491C2DF10320*
private:
	DOMNodeEx (const DOMNodeEx&);
	DOMNodeEx& operator= (const DOMNodeEx&);
//#UC END# *491C2DF10320*
}; // class DOMNodeEx

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_DOMNODEEX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

