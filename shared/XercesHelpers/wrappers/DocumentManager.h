////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/DocumentManager.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::DocumentManager
//
// чтение и запись дерева xml
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_DOCUMENTMANAGER_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_DOCUMENTMANAGER_H__

#include "shared/Core/sys/std_inc.h"
#include "xercesc/dom/DOMDocument.hpp"
#include "xercesc/dom/DOMImplementation.hpp"

//#UC START# *491C06220031_CUSTOM_INCLUDES*
#include "xercesc/util/XercesVersion.hpp"
#include "xercesc/dom/DOMDocument.hpp" // for Core::Box

#include "shared/XercesHelpers/wrappers/defines.h"

namespace XERCES_CPP_NAMESPACE {
	class DOMDocument;
	class DOMImplementation;
	class MemBufFormatTarget;
}
//#UC END# *491C06220031_CUSTOM_INCLUDES*

namespace XercesHelpers {

// чтение и запись дерева xml
class DocumentManager {
	SET_OBJECT_COUNTER (DocumentManager)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit DocumentManager (const char* name = 0, const char* root_tag = 0);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// получить документ из заданного файла
	XERCES_CPP_NAMESPACE::DOMDocument* get_doc (const char* path = 0);

	// получить документ из заданного буфера
	XERCES_CPP_NAMESPACE::DOMDocument* get_doc (const char* xml_buffer, size_t xml_buffer_size);

	// записать xml в заданный файл
	void write (const char* path, bool generate_file = true, bool is_ascii = false) const;

	// записать документ в буфер
	unsigned long write_to_buffer (XMLStr& buffer, bool is_ascii = false) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	XERCES_CPP_NAMESPACE::DOMImplementation* m_implementation;

	std::string m_qualified_name;

//#UC START# *491C06220031*
	struct DOMDocumentDestructor {
		static void destroy (XERCES_CPP_NAMESPACE::DOMDocument* p);
	};
	Core::Box <XERCES_CPP_NAMESPACE::DOMDocument, DOMDocumentDestructor> m_document;
//#UC END# *491C06220031*
}; // class DocumentManager

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_DOCUMENTMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

