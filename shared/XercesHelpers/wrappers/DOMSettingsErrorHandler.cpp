////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/XercesHelpers/wrappers/DOMSettingsErrorHandler.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::DOMSettingsErrorHandler
//
// ���������� ������ ��� ������� xml
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/XercesHelpers/wrappers/DOMSettingsErrorHandler.h"

//#UC START# *491C2EA40004_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMError.hpp"
#include "xercesc/dom/DOMLocator.hpp"
#include "xercesc/util/XMLString.hpp"
//#UC END# *491C2EA40004_CUSTOM_INCLUDES*

namespace XercesHelpers {

//#UC START# *491C2EA40004*
//#UC END# *491C2EA40004*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DOMSettingsErrorHandler::DOMSettingsErrorHandler ()
//#UC START# *491D85D90277_BASE_INIT*
: m_errors (0)
//#UC END# *491D85D90277_BASE_INIT*
{
	//#UC START# *491D85D90277_BODY*
	//#UC END# *491D85D90277_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// �������� ���������� ������
long DOMSettingsErrorHandler::get_errors () const {
	//#UC START# *491D85F6014C*
	return m_errors; 
	//#UC END# *491D85F6014C*
}

// ���������� ������ �� ����� ������� xml
bool DOMSettingsErrorHandler::handleError (const XERCES_CPP_NAMESPACE::DOMError& domError) {
	//#UC START# *491D86170108*
	if (domError.getSeverity() == XERCES_CPP_NAMESPACE::DOMError::DOM_SEVERITY_WARNING) {
		printf ("\nWarning at file ");
	} else if (domError.getSeverity() == XERCES_CPP_NAMESPACE::DOMError::DOM_SEVERITY_ERROR) {
		printf ("\nError at file ");
	} else {
		printf ("\nFatal Error at file ");
	}

	printf (
		"%s line %d char %d\n Message: %s\n"
		, XERCES_CPP_NAMESPACE::XMLString::transcode (domError.getLocation ()->getURI ())
		, domError.getLocation ()->getLineNumber ()
		, domError.getLocation ()->getColumnNumber ()
		, XERCES_CPP_NAMESPACE::XMLString::transcode (domError.getMessage ())
		);

	++m_errors;
	return true;
	//#UC END# *491D86170108*
}

} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

