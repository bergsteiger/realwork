////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseInternal/RoseElement.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseElement
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEELEMENT_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/RoseInternal/RoseObject.h"

namespace RoseInternal {

class RoseElement :
	virtual public RoseObject
{
	SET_OBJECT_COUNTER (RoseElement)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ������� ����� �������, GUID ��� ���� ��������� �������������
	RoseElement ();

	// ������� ������� � ��������� ��� ������� GUID
	explicit RoseElement (const std::string& guid);

public:
	virtual ~RoseElement ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name);

	virtual const std::string get_qualified_name ();

	virtual IRosePropertyCollectionPtr get_rose_all_properties () const;

	virtual IRosePropertyCollectionPtr get_rose_tool_properties (const std::string& tool_name) const;

	virtual VARIANT_BOOL override_property (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	);

protected:
	// ��������� 48-�� ������ ��� ������
	virtual unsigned long long hash48 (const std::string& src) const;

	// ���������� true, ���� � �������� ���� �������� � �������� ������, ����� false
	virtual bool is_property_exist (const std::string& tool_name, const std::string& prop_name) const;

	// �� ���� ��������� ������� � ������� ���������� uid'� - 12 ��������
	virtual const std::string make_rose_uid (unsigned long long hash) const;


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
private:
	// ��� ������������� ��������� ���������� � ��������� � �������� - �������� ���������� �������� �
	// �������� ������ ����������, ���������� � ��������
	virtual void update_parent_properties (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	) = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseApplicationPtr m_application;

	IRoseModelPtr m_model;

	std::string m_name;

	Base::ToolPropertyMap m_overriden_property;

	std::string m_unique_id;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseApplicationPtr get_application () const;

	void set_application (IRoseApplicationPtr application);

	IRoseModelPtr get_model () const;

	void set_model (IRoseModelPtr model);

	virtual const std::string& get_name () const;

	virtual void set_name (const std::string& name);

	virtual const Base::ToolPropertyMap& get_overriden_property () const;

	const std::string& get_unique_id () const;

	void set_unique_id (const std::string& unique_id);


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseObject
	virtual HRESULT dispatch (
		DISPID id
		, REFIID riid
		, LCID lcid
		, WORD flags
		, DISPPARAMS* params
		, VARIANT* result
		, LPEXCEPINFO exp_info
		, PUINT arg_err
	);

	// overloaded method from RoseObject
	virtual const std::string identify_class ();

	// overloaded method from RoseObject
	// ����������
	virtual VARIANT_BOOL is_class (const std::string& class_name);

}; // class RoseElement

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

