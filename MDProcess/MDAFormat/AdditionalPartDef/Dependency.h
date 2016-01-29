////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/Dependency.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Dependency
//
// �������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_DEPENDENCY_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_DEPENDENCY_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// �������� �����
class Dependency {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Dependency ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const std::string& get_stereotype () const;

	void set_stereotype (const std::string& stereotype);

	const std::string& get_target_full_name () const;

	void set_target_full_name (const std::string& target_full_name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ���� ��������
	std::string m_guid;

	// ������ �������
	PropertyList m_properties;

	// ��������� �����
	std::string m_stereotype;

	// ��� ���� �����
	std::string m_target_full_name;


}; //class Dependency

std::ostream& operator << (std::ostream& out_stream, const Dependency& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_DEPENDENCY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
