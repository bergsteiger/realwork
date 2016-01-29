////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/XercesHelpers/wrappers/XMLStrUnicode.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::XMLStrUnicode
//
// ������ ��� ��������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_XERCESHELPERS_WRAPPERS_XMLSTRUNICODE_H__
#define __SHARED_XERCESHELPERS_WRAPPERS_XMLSTRUNICODE_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *491C2FD2018D_CUSTOM_INCLUDES*
#include "xercesc/util/XercesDefs.hpp"
//#UC END# *491C2FD2018D_CUSTOM_INCLUDES*

namespace XercesHelpers {

// ������ ��� ��������� ������
class XMLStrUnicode {
	SET_OBJECT_COUNTER (XMLStrUnicode)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	XMLStrUnicode ();

	explicit XMLStrUnicode (const char* data);

public:
	~XMLStrUnicode ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ��������� �������������
	const XMLCh* data () const;

	// ������������� ������ �������
	void init (const char* data);

	// ���������������� �� ������ �������
	bool is_valid () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	XMLCh* m_data;

//#UC START# *491C2FD2018D*
//#UC END# *491C2FD2018D*
}; // class XMLStrUnicode

} // namespace XercesHelpers


#endif //__SHARED_XERCESHELPERS_WRAPPERS_XMLSTRUNICODE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

