////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseInternal/RoseItem.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseItem
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEITEM_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEITEM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"

namespace RoseInternal {

class RoseItem :
	virtual public RoseElement
{
	SET_OBJECT_COUNTER (RoseItem)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ���������� � ���, ��� ������� ������ �������� ��������
	class WrongContext : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RoseItem ();

public:
	virtual ~RoseItem ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ���
	virtual void rich_type_name_changed (IRoseRichType* obj, const std::string& old_value);

	// ���������� �������� ��������
	virtual void rich_type_value_changed (IRoseRichType* obj, short old_value);

protected:
	virtual HRESULT dispatch_export_control (WORD flags, DISPPARAMS* params, VARIANT* result);

	// ����������� ��������� �������� ��������
	virtual IRoseElementPtr get_real_context () const;

private:
	// ��������� ��� �������� ��� ������ � ������������ ������� - ������ ����������� UID � �����
	// ��������
	virtual const std::string make_property_name (const std::string& prop_name) const;

	// ���������� true, ��� �������� ������ ���� ������ �������� � �������� ��� ��������� ��������
	virtual bool need_write_to_parent (const std::string& prop_name) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���, ��� ����, ����� ������� �� Ptr � ������ ��������� �� ���������
	IRoseItem* m_context_ptr;

	std::string m_documentation;

	IRoseRichTypePtr m_export_control;

	std::string m_stereotype;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual IRoseItemPtr get_context () const;

	virtual void set_context (IRoseItemPtr context) /*throw WrongContext*/;

	const std::string& get_documentation () const;

	void set_documentation (const std::string& documentation);

	virtual IRoseRichTypePtr get_export_control () const;

	virtual void set_export_control (IRoseRichTypePtr export_control);

	virtual const std::string& get_stereotype () const;

	virtual void set_stereotype (const std::string& stereotype);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
private:

	// implemented method from RoseElement
	// ��� ������������� ��������� ���������� � ��������� � �������� - �������� ���������� �������� �
	// �������� ������ ����������, ���������� � ��������
	virtual void update_parent_properties (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	);
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseElement
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name);

	// overloaded method from RoseElement
	virtual const std::string get_qualified_name ();

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

}; // class RoseItem

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEITEM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

