////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/DocumentManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::DocumentManager
//
// чтение и запись дерева xml
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/XercesHelpers/wrappers/DocumentManager.h"
// by <<uses>> dependencies
#include "shared/XercesHelpers/wrappers/XStr.h"
#include "shared/XercesHelpers/wrappers/DOMSettingsErrorHandler.h"

//#UC START# *491C06220031_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMBuilder.hpp"
#include "xercesc/dom/DOMImplementationRegistry.hpp"
#include "xercesc/dom/DOMImplementation.hpp"
#include "xercesc/dom/DOMWriter.hpp"
#include "xercesc/framework/LocalFileFormatTarget.hpp"
#include "xercesc/framework/MemBufInputSource.hpp"
#include "xercesc/framework/MemBufFormatTarget.hpp"
#include "xercesc/framework/Wrapper4InputSource.hpp"
#include "xercesc/framework/XMLErrorCodes.hpp"
#include "xercesc/framework/XMLFormatter.hpp"
#include "xercesc/util/IOException.hpp"
#include "xercesc/util/XMLString.hpp"
#include "xercesc/util/XMLUni.hpp"

#include "shared/XercesHelpers/wrappers/exceptions.h"

bool is_file_exist (const char* file_name) {
	return (ACE_OS::access (file_name, R_OK) != -1);
}

struct DOMBuilderDestructor {
	static void destroy (XERCES_CPP_NAMESPACE::DOMBuilder* p) {
		p->release (); 
	}
};

typedef Core::Box <XERCES_CPP_NAMESPACE::DOMBuilder, DOMBuilderDestructor> XercesDOMBuilder_box;
//#UC END# *491C06220031_CUSTOM_INCLUDES*

namespace XercesHelpers {

//#UC START# *491C06220031*
void DocumentManager::DOMDocumentDestructor::destroy (XERCES_CPP_NAMESPACE::DOMDocument* p) {
	p->release (); 
}
//#UC END# *491C06220031*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentManager::DocumentManager (const char* name, const char* root_tag)
//#UC START# *491D6CC103D9_BASE_INIT*
//#UC END# *491D6CC103D9_BASE_INIT*
{
	//#UC START# *491D6CC103D9_BODY*
	m_implementation = XERCES_CPP_NAMESPACE::DOMImplementationRegistry::getDOMImplementation (Y("Core"));
	if (name) {
		m_document = m_implementation->createDocument (0, root_tag ? Y(root_tag) : Y(name), 0);
		m_qualified_name = name;
	}
	//#UC END# *491D6CC103D9_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить документ из заданного файла
XERCES_CPP_NAMESPACE::DOMDocument* DocumentManager::get_doc (const char* path) {
	//#UC START# *491D6D14022F*
	XERCES_CPP_NAMESPACE::DOMDocument* doc = 0;
	if (path) {
		if (!is_file_exist (path)) {
			throw std::logic_error (std::string ("file '") + path + std::string ("' not exist"));
		}

		DOMSettingsErrorHandler errorHandler;

		XercesDOMBuilder_box parser;
		parser = m_implementation->createDOMBuilder (XERCES_CPP_NAMESPACE::DOMImplementationLS::MODE_SYNCHRONOUS, 0);
		parser->setFeature (XERCES_CPP_NAMESPACE::XMLUni::fgXercesUserAdoptsDOMDocument, true);
		parser->setErrorHandler (&errorHandler);

		try {
			m_document = parser->parseURI (path);
		} catch (XERCES_CPP_NAMESPACE::XMLErrs::Codes& code) {
			if (XERCES_CPP_NAMESPACE::XMLErrs::isError (code) || XERCES_CPP_NAMESPACE::XMLErrs::isFatal (code)) {
				throw std::logic_error ("Xerces 'parseURI' method fails");
			}
		}

		if (errorHandler.get_errors ()) {
			throw std::logic_error ("DOMSettingsErrorHandler catch some errors");
		}

		return m_document.ptr ();
	} else {
		return m_document.ptr ();
	}

	GDS_ASSERT (false && "not reached");
	return 0;
	//#UC END# *491D6D14022F*
}

// получить документ из заданного буфера
XERCES_CPP_NAMESPACE::DOMDocument* DocumentManager::get_doc (const char* xml_buffer, size_t xml_buffer_size) {
	//#UC START# *491D6DCA0128*
	XERCES_CPP_NAMESPACE::DOMDocument* doc = 0;
	if (xml_buffer && xml_buffer_size) {
		DOMSettingsErrorHandler errorHandler;

		XercesDOMBuilder_box parser;
		parser = m_implementation->createDOMBuilder (XERCES_CPP_NAMESPACE::DOMImplementationLS::MODE_SYNCHRONOUS, 0);
		parser->setFeature (XERCES_CPP_NAMESPACE::XMLUni::fgXercesUserAdoptsDOMDocument, true);
		parser->setErrorHandler (&errorHandler);

		Core::Aptr <XERCES_CPP_NAMESPACE::MemBufInputSource> input_source (
			new XERCES_CPP_NAMESPACE::MemBufInputSource (
			(const XMLByte *) xml_buffer
			, static_cast <unsigned int> (xml_buffer_size)
			, "buffered_xml"
			, false
			)
		);
		Core::Aptr <XERCES_CPP_NAMESPACE::Wrapper4InputSource> wrapper (new XERCES_CPP_NAMESPACE::Wrapper4InputSource (input_source.ptr (), false));
		try {
			m_document = parser->parse (*(wrapper.ptr ()));
		} catch (XERCES_CPP_NAMESPACE::XMLErrs::Codes& code) {
			if (XERCES_CPP_NAMESPACE::XMLErrs::isError (code) || XERCES_CPP_NAMESPACE::XMLErrs::isFatal (code)) {
				throw std::logic_error ("Xerces 'parse' method fails");
			}
		}

		if (errorHandler.get_errors ()) {
			throw std::logic_error ("DOMSettingsErrorHandler catch some errors");
		}

		return m_document.ptr ();
	} else {
		return m_document.ptr ();
	}

	GDS_ASSERT (false && "not reached");
	return 0;
	//#UC END# *491D6DCA0128*
}

// записать xml в заданный файл
void DocumentManager::write (const char* path, bool generate_file, bool is_ascii) const {
	//#UC START# *491D6E6E0121*
	if (m_document.ptr ()) {
		std::string file_path = path;

		if (generate_file) {
			file_path += std::string ("\\") + m_qualified_name + ".xml";
		} 

		try {
			Core::Aptr <XERCES_CPP_NAMESPACE::XMLFormatTarget> form_target (
				new XERCES_CPP_NAMESPACE::LocalFileFormatTarget (file_path.c_str ())
				);
			XERCES_CPP_NAMESPACE::DOMImplementationLS* save_impl;
			save_impl = static_cast <XERCES_CPP_NAMESPACE::DOMImplementationLS*>(m_implementation);

			Core::Aptr <XERCES_CPP_NAMESPACE::DOMWriter> serializer (save_impl->createDOMWriter ()); // GARANT_PRIVATE
			serializer->setEncoding (
				is_ascii ? XERCES_CPP_NAMESPACE::XMLUni::fgUSASCIIEncodingString : XERCES_CPP_NAMESPACE::XMLUni::fgUTF8EncodingString
				);
			serializer->setFeature (XERCES_CPP_NAMESPACE::XMLUni::fgDOMWRTFormatPrettyPrint, true);
			serializer->writeNode (form_target.ptr (), *(m_document.ptr ()));
		} catch (XERCES_CPP_NAMESPACE::IOException&) {
			throw XercesIOError ();
		}
	}
	//#UC END# *491D6E6E0121*
}

// записать документ в буфер
unsigned long DocumentManager::write_to_buffer (XMLStr& buffer, bool is_ascii) const {
	//#UC START# *491D6F4E0135*
	Core::Aptr <XERCES_CPP_NAMESPACE::MemBufFormatTarget> memory_buffer (
		new XERCES_CPP_NAMESPACE::MemBufFormatTarget ()
		);

	if (m_document.ptr ()) {
		XERCES_CPP_NAMESPACE::DOMImplementationLS* save_impl;
		save_impl = static_cast <XERCES_CPP_NAMESPACE::DOMImplementationLS*>(m_implementation);

		Core::Aptr <XERCES_CPP_NAMESPACE::DOMWriter> serializer (save_impl->createDOMWriter ());
		serializer->setEncoding (
			is_ascii ? XERCES_CPP_NAMESPACE::XMLUni::fgUSASCIIEncodingString : XERCES_CPP_NAMESPACE::XMLUni::fgUTF8EncodingString
			);
		serializer->setFeature (XERCES_CPP_NAMESPACE::XMLUni::fgDOMWRTFormatPrettyPrint, true);
		serializer->writeNode (memory_buffer.ptr (), *(m_document.ptr ()));
	}
	if (memory_buffer->getLen ()) {
		char* replica = XERCES_CPP_NAMESPACE::XMLString::replicate (reinterpret_cast<const char *> (memory_buffer->getRawBuffer ()));
		buffer = replica;
	}

	return memory_buffer->getLen ();
	//#UC END# *491D6F4E0135*
}

} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

