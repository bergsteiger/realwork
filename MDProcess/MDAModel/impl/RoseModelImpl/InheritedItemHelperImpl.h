////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemHelperImpl
// ��������� ���������� ������ �������� ��� ��������� InheritedItemHelper
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "boost/property_tree/ptree.hpp"

namespace RoseModelImpl {

class InheritedItemHelperImpl; // self forward Var
typedef ::Core::Var<InheritedItemHelperImpl> InheritedItemHelperImpl_var;
typedef ::Core::Var<const InheritedItemHelperImpl> InheritedItemHelperImpl_cvar;

class InheritedItemHelperImpl_factory;

class InheritedItemHelperImpl:
	virtual public InheritedItemHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (InheritedItemHelperImpl)
	friend class InheritedItemHelperImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InheritedItemHelperImpl ();

	virtual ~InheritedItemHelperImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ����������� ������� � ������ �������
	virtual boost::property_tree::ptree* serialize_item (const InheritedItem* item) const;


//////////////////////////////////////////////////////////////////////////////////////////
// template methods implementation

private:
	// ���������� ������� ����������
	template <class T>
	bool save_impl (IRoseElementPtr elem, const std::string& prop_name, const T& inherted_items) const;

	// ���������� ������ stored_value
	template <class T>
	const std::string stored_value_impl (const T& inherited_items) const;

	// ���������� ������� ����������
	template <class T>
	bool save_impl (Base::Dumper* elem, const std::string& prop_name, const T& inherted_items) const;



private:
	// ���������� ������ ��������� ������ ���������������� ��������� ��������� ���� �� ������
	// ����������� ����� ������
	template <class InheritedTypeFactory, class Result>
	Result* get_stored_inherited_items_impl (IRoseElementPtr elem, const std::string& prop_name) const;

	// ���������� ������ ��������� ������ ���������������� ��������� ��������� ���� �� ������
	// ����������� ����� ������
	template <class InheritedTypeFactory, class Result>
	Result* get_stored_inherited_items_impl (const std::string& prop_value) const;



//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from InheritedItemHelper
	// ���������� ������ ����������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	virtual ImplementedItemSet* get_stored_implemented (IRoseElementPtr elem) const;

	// implemented method from InheritedItemHelper
	// ���������� ������ ����������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	// elem ������ ���� ����������� RoseAbstractDumper (��� ������������ ��� Dumper, ����� �� ��������
	// �� ������ RoseDumpers)
	virtual ImplementedItemSet* get_stored_implemented (const Base::Dumper* elem) const;

	// implemented method from InheritedItemHelper
	// ���������� ������ ���������������� ��������� ����������� � ��������� �� ����� prop_name
	virtual InheritedItemSet* get_stored_inherited_items (IRoseElementPtr elem, const std::string& prop_name) const;

	// implemented method from InheritedItemHelper
	// ���������� ������ ���������������� ��������� ����������� � ��������� �� ����� prop_name
	// 
	// elem ������ ���� ����������� RoseAbstractDumper (��� ������������ ��� Dumper, ����� �� ��������
	// �� ������ RoseDumpers)
	virtual InheritedItemSet* get_stored_inherited_items (const Base::Dumper* elem, const std::string& prop_name) const;

	// implemented method from InheritedItemHelper
	// ���������� ������ ���������������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	virtual OverloadedItemSet* get_stored_overloaded (IRoseElementPtr elem) const;

	// implemented method from InheritedItemHelper
	// ���������� ������ ���������������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	// elem ������ ���� ����������� RoseAbstractDumper (��� ������������ ��� Dumper, ����� �� ��������
	// �� ������ RoseDumpers)
	virtual OverloadedItemSet* get_stored_overloaded (const Base::Dumper* elem) const;

	// implemented method from InheritedItemHelper
	// ������� ������� ������� ��� ����������������� ��������
	virtual IRoseElementPtr make_wrapper (IRoseElementPtr elem, const InheritedItem* state) const;

	// implemented method from InheritedItemHelper
	// ��������� ������ ����������� ���������
	virtual bool save (IRoseElementPtr elem, const ImplementedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// ��������� ������ ��������������� ���������
	virtual bool save (IRoseElementPtr elem, const OverloadedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// ��������� ������ ����������� ���������
	virtual bool save (Base::Dumper* elem, const ImplementedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// ��������� ������ ���������������� ���������
	virtual bool save (Base::Dumper* elem, const OverloadedItemSet& items) const;

	// implemented method from InheritedItemHelper
	// ���������� ��������������� �������� ��� ��������� ���������������� ���������
	virtual const std::string stored_value (const InheritedItemSet& inherited_items) const;

	// implemented method from InheritedItemHelper
	// ���������� ��������������� �������� ��� ��������� ���������������� ���������
	virtual const std::string stored_value (const OverloadedItemSet& inherited_items) const;

	// implemented method from InheritedItemHelper
	// ���������� ��������������� �������� ��� ��������� ���������������� ���������
	virtual const std::string stored_value (const ImplementedItemSet& inherited_items) const;
}; // class InheritedItemHelperImpl

} // namespace RoseModelImpl

#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.i.h"

#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
