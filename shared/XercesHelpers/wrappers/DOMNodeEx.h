////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/XercesHelpers/wrappers/DOMNodeEx.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::DOMNodeEx
//
// ������ ��� ������ � ����� DOM-�, ������������ ������ � �������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ������ ��� ������ � ����� DOM-�, ������������ ������ � �������� ���������
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
	// �������� DOM ����
	XERCES_CPP_NAMESPACE::DOMNode* get () const;

	// �������� ������� � �������� ������
	char* get_attribute (const char* name) const;

	// �������� ������� xml-���� ����
	char* get_attribute (const XMLCh* name) const;

	// �������� ������ �������� �����
	XERCES_CPP_NAMESPACE::DOMNodeList* get_child_nodes () const;

	// �������� DOM �������
	XERCES_CPP_NAMESPACE::DOMElement* get_element () const;

	// �������� ������ ����� � �������� ������
	XERCES_CPP_NAMESPACE::DOMNodeList* get_elements_by_tag_name (const char* tag_name) const;

	// �������� ������ ����� � �������� ������
	XERCES_CPP_NAMESPACE::DOMNodeList* get_elements_by_tag_name (const XMLCh* tag_name) const;

	// �������� ������� xml-���� ����
	int get_int_attribute (const char* name) const;

	// �������� ������� xml-���� ����
	long get_long_attribute (const char* name) const;

	// �������� ������� xml-���� ����
	long get_long_attribute (const XMLCh* name) const;

	// �������� ��� ����
	const XMLCh* get_node_name () const;

	// �������� ���������� ���� - <tag>���������� ����</tag>
	char* get_text () const;

	// �������� ��� DOM �������
	long get_type () const;

	// ���� �� � �������� �������� ����
	bool has_child_nodes () const;

	// �������� �� ������� ���������
	bool is_attribute (const XMLCh* str, const char* attr_name) const;

	// �������� �� ������ ���������
	bool is_element () const;

	// �������� �� ������� �����
	bool is_tag (const XMLCh* str) const;

	// �������� �� ������ ������ �� DOM ������
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

