////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/XercesHelpers/wrappers/DOMSettingsErrorHandler.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::DOMSettingsErrorHandler
//
// ���������� ������ ��� ������� xml
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_DOMSETTINGSERRORHANDLER_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_DOMSETTINGSERRORHANDLER_H__

#include "shared/Core/sys/std_inc.h"
#include "xercesc/dom/DOMErrorHandler.hpp"

//#UC START# *491C2EA40004_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMErrorHandler.hpp"
//#UC END# *491C2EA40004_CUSTOM_INCLUDES*

namespace XercesHelpers {

// ���������� ������ ��� ������� xml
class DOMSettingsErrorHandler;
typedef Core::Var<DOMSettingsErrorHandler> DOMSettingsErrorHandler_var;
typedef Core::Var<const DOMSettingsErrorHandler> DOMSettingsErrorHandler_cvar;

class DOMSettingsErrorHandler :
	public XERCES_CPP_NAMESPACE::DOMErrorHandler
	, public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DOMSettingsErrorHandler)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	DOMSettingsErrorHandler ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ���������� ������
	long get_errors () const;

	// ���������� ������ �� ����� ������� xml
	bool handleError (const XERCES_CPP_NAMESPACE::DOMError& domError);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	long m_errors;

//#UC START# *491C2EA40004*
//#UC END# *491C2EA40004*
}; // class DOMSettingsErrorHandler

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_DOMSETTINGSERRORHANDLER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

