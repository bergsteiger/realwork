////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseInternal/RoseOverridenElement.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseOverridenElement
//
// �������, �������������� ����� ��������������� �� ������� DerivedImpl. �������� �������� ���
// �������� ��������� � ��� ������, ����� ����������� �������������� ����� ��������. ���������
// �������������� ���������, ������������� � �������� UP. ��� ������� �� �������������, �������
// ��������������� �� ���������� �������� ����� �� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOVERRIDENELEMENT_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOVERRIDENELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"

//#UC START# *4C10F3D5007E_CUSTOM_INCLUDES*
//#UC END# *4C10F3D5007E_CUSTOM_INCLUDES*

namespace RoseInternal {

// �������, �������������� ����� ��������������� �� ������� DerivedImpl. �������� �������� ���
// �������� ��������� � ��� ������, ����� ����������� �������������� ����� ��������. ���������
// �������������� ���������, ������������� � �������� UP. ��� ������� �� �������������, �������
// ��������������� �� ���������� �������� ����� �� �������
class RoseOverridenElement :
	virtual public RoseItem
{
	SET_OBJECT_COUNTER (RoseOverridenElement)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseOverridenElement ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������������� ��������
	void init (IRoseElementPtr delegate, const InheritedItem* state);

private:
	// ��������� � ������ ������� �������� �������� � ��������
	virtual void merge_properties (
		IRosePropertyCollectionPtr delegate_props
		, IRosePropertyCollectionPtr& self_props
	) const;

	// ���������� true, ���� ������ �� ��������� ������ ���� �������� ��������, ���� �� �������
	// ����������� ��� �������� - ������������ false
	virtual bool need_forward_property (const std::string& tool_name, const std::string& prop_name) const;

	// ���������� true, ���� �������� ����� ��������� � ��������� ���������
	virtual bool property_need_to_save_in_state (const std::string& tool_name, const std::string& prop_name) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������
	IRoseElementPtr m_delegate;

	// ������� �������������
	bool m_is_abstract;

	// �������, ������� �������������� - �� ��� ����� �������� ���������� � ���������������
	IRoseElementPtr m_overriden_owner;

	// �������� ��������� ��� ����������������� ��������
	InheritedItem_var m_state;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseElementPtr get_delegate () const;

	void set_delegate (IRoseElementPtr delegate);

	bool get_is_abstract () const;

	void set_is_abstract (bool is_abstract);

	IRoseElementPtr get_overriden_owner () const;

	void set_overriden_owner (IRoseElementPtr overriden_owner);

	virtual const InheritedItem* get_state () const;

	virtual void set_state (InheritedItem* state);


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseElement
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name);

	// overloaded method from RoseElement
	virtual IRosePropertyCollectionPtr get_rose_all_properties () const;

	// overloaded method from RoseElement
	virtual IRosePropertyCollectionPtr get_rose_tool_properties (const std::string& tool_name) const;

	// overloaded method from RoseElement
	virtual VARIANT_BOOL override_property (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	);

	// overloaded method from RoseItem
	virtual IRoseItemPtr get_context () const;

	virtual void set_context (IRoseItemPtr context)
		/*throw (RoseItem::WrongContext)*/;

	// overloaded method from RoseItem
	virtual IRoseRichTypePtr get_export_control () const;

	virtual void set_export_control (IRoseRichTypePtr export_control);

	// overloaded method from RoseItem
	// ���������� ���
	virtual void rich_type_name_changed (IRoseRichType* obj, const std::string& old_value);

	// overloaded method from RoseItem
	// ���������� �������� ��������
	virtual void rich_type_value_changed (IRoseRichType* obj, short old_value);

	// overloaded method from RoseItem
	virtual const std::string& get_stereotype () const;

	virtual void set_stereotype (const std::string& stereotype);

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
protected:

	// overloaded method from RoseElement
	// ���������� true, ���� � �������� ���� �������� � �������� ������, ����� false
	virtual bool is_property_exist (const std::string& tool_name, const std::string& prop_name) const;

	// overloaded method from RoseItem
	// ����������� ��������� �������� ��������
	virtual IRoseElementPtr get_real_context () const;


//#UC START# *4C10F3D5007E*
//#UC END# *4C10F3D5007E*
}; // class RoseOverridenElement

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOVERRIDENELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

