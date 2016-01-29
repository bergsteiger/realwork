////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/Package.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Package
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_PACKAGE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_PACKAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/UserProperty.h"
#include "MDProcess/MDAFormat/ModelPartDef/Dependency.h"
#include "MDProcess/MDAFormat/ModelPartDef/Class.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// ���� ��� ������������
class Package {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Package ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_stereotype () const;

	void set_stereotype (const std::string& stereotype);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	bool get_native () const;

	void set_native (bool native);

	bool get_global () const;

	void set_global (bool global);

	const VisibilityType& get_visibility () const;

	void set_visibility (const VisibilityType& visibility);

	const PackageList& get_nested_packages () const;

	void set_nested_packages (const PackageList& nested_packages);

	const UserPropertyList& get_user_properties () const;

	void set_user_properties (const UserPropertyList& user_properties);

	const DependencyList& get_dependencies () const;

	void set_dependencies (const DependencyList& dependencies);

	const ClassList& get_classes () const;

	void set_classes (const ClassList& classes);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_stereotype;

	std::string m_name;

	bool m_native;

	// ������������
	bool m_global;

	// ���������
	VisibilityType m_visibility;

	// ��������� ������
	PackageList m_nested_packages;

	// ��������������� ��������
	UserPropertyList m_user_properties;

	// ����� � ������� ��������
	DependencyList m_dependencies;

	// ������ �������� �������
	ClassList m_classes;


}; //class Package

std::ostream& operator << (std::ostream& out_stream, const Package& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_PACKAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
