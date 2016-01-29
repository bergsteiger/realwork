////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/AttributeContent.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::AttributeContent
//
// ��������� � ������ ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTECONTENT_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTECONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/UserProperty.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// ��������� � ������ ��������
class AttributeContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const AttributeList& get_keys () const;

	void set_keys (const AttributeList& keys);

	const UserPropertyList& get_user_properties () const;

	void set_user_properties (const UserPropertyList& user_properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ����� ��������
	AttributeList m_keys;

	// ���������������� ��������
	UserPropertyList m_user_properties;


}; //class AttributeContent

std::ostream& operator << (std::ostream& out_stream, const AttributeContent& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
