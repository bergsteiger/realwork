////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseModel/RoseModel.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::RoseModel
//
// ����������� ������ ��� ���������� ������. ������ �����, ����� �� ���������� ��������� � ����
// ���� (������ ��� RoseHelper)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODEL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODEL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include <vector>
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


class Element;
typedef ::Core::Var<Element> Element_var;
typedef ::Core::Var<const Element> Element_cvar;

class Element;

// ������ ���������
typedef std::vector < Element_var > ElementList;

// ������� ��������� ��� ���� ��������� ������
class Element
	: virtual public ::Core::IObject
{
public:
	// ���������� ������ ���������������� ����� ��������
	virtual ElementList* get_childs () const = 0;

	// ���������� ������ ���� ����� �������� (� ������ �����������)
	virtual ElementList* get_all_childs () const = 0;

	// ���������� true, ���� ������� �������� ��� ��������������
	virtual bool can_modify () const = 0;
};

class Category;
typedef ::Core::Var<Category> Category_var;
typedef ::Core::Var<const Category> Category_cvar;

class Category;

// ������ �����
typedef std::vector < Category_var > CategoryList;

// �������-�����. ������ ��� ��������� ���������, ������������� �������������� ����������������.
class Category
	: virtual public Element
{
public:
	// ���������� true, ���� ������� "�����" � ����������� cat
	virtual bool is_controlled () const = 0;

	// ���������� ����� �� ����� ������ � ��������� ���
	virtual bool can_control () const = 0;

	// ���������� true, ���� ���� �� ���� ������� (����������) "�����" � ����������� cat
	virtual bool has_controlled_child () const = 0;

	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const = 0;

	// ���������� true, ���� ���� �������� �������� �� ��������� ��� ��������������, �.� �� �����
	// ��������� ��� ����, ����� ������ �������������
	virtual bool has_ro_child () const = 0;

	// ���������� ������ ���� ����� - ����� (����������)
	virtual CategoryList* get_all_categories () const = 0;

	// ���������� ������ ����� - ���������������� ����� ��������
	virtual CategoryList* get_categories () const = 0;
};

/// factory interface for Category
class CategoryFactory {
public:
	// ������ ���������
	static Category* make (IRoseCategoryPtr cat)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class IsVirtual;
typedef ::Core::Var<IsVirtual> IsVirtual_var;
typedef ::Core::Var<const IsVirtual> IsVirtual_cvar;
// �������� ����������� ������������� ��������
class IsVirtual
	: virtual public ::Core::IObject
{
public:
	// ���������� true, ���� ������� �����������
	virtual bool execute (IRoseElementPtr elem) const = 0;
};

/// factory interface for IsVirtual
class IsVirtualFactory {
public:
	static IsVirtual& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PropertyHelper;
typedef ::Core::Var<PropertyHelper> PropertyHelper_var;
typedef ::Core::Var<const PropertyHelper> PropertyHelper_cvar;
// ��������������� ��������� ��� ������ �� ����������
class PropertyHelper
	: virtual public ::Core::IObject
{
public:
	// ���������� true, ���� �������� ����� ����������� ��������� � ������
	virtual bool need_persist (const std::string& prop_id) const = 0;

	// ���������� true, ���� �������� ���������� ��������������� ��������
	virtual bool is_self_generated_source (const std::string& prop_id) const = 0;

	// ���������� true, ���� �������� ����� ���� ������� �� ������
	virtual bool can_be_deleted (IRosePropertyPtr property) const = 0;
};

/// factory interface for PropertyHelper
class PropertyHelperFactory {
public:
	static PropertyHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ModelPropertiesHelper;
typedef ::Core::Var<ModelPropertiesHelper> ModelPropertiesHelper_var;
typedef ::Core::Var<const ModelPropertiesHelper> ModelPropertiesHelper_cvar;
// ��������������� ��������� ��� ������ � ��������������� ���������� �������� (���������,
// ���������� � �.�)
class ModelPropertiesHelper
	: virtual public ::Core::IObject
{
public:
	// ���������� ������� ��������� ��� ��������
	virtual int get_visibility_level (IRoseElementPtr elem) const = 0;

	// ������������� ������� ��������� ����� ��� �������� (��� ������������� ����������� �������)
	virtual void set_visibility_level (IRoseElementPtr elem, int level) const = 0;

	virtual bool is_global_locally (IRoseElementPtr elem) const = 0;

	virtual void set_global_locally (IRoseElementPtr elem, bool value) const = 0;
};

/// factory interface for ModelPropertiesHelper
class ModelPropertiesHelperFactory {
public:
	static ModelPropertiesHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class TypeLinkHelper;
typedef ::Core::Var<TypeLinkHelper> TypeLinkHelper_var;
typedef ::Core::Var<const TypeLinkHelper> TypeLinkHelper_cvar;
// ��������������� ���������� ��� ����� ����� ��������� � ��������� ���������� ������
class TypeLinkHelper
	: virtual public ::Core::IObject
{
public:
	// ����������� � �������� ��������, ��� �� ������ � ���������, ������� ���� target_uid
	virtual void link (IRoseElementPtr source, const std::string& target_uid) const = 0;

	// ��������� ����� ��� ��������
	virtual void unlink (IRoseElementPtr source) const = 0;

	// ���������� ������������ ��������, � ������� ������ �������
	virtual const std::string get_linked (IRoseElementPtr source) const = 0;
};

/// factory interface for TypeLinkHelper
class TypeLinkHelperFactory {
public:
	// �������
	static TypeLinkHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class InheritedItem;
typedef ::Core::Var<InheritedItem> InheritedItem_var;
typedef ::Core::Var<const InheritedItem> InheritedItem_cvar;
// ������� ����������� ��������� ��� ���������, �������������� �����������/���������������� �������
class InheritedItem
	: virtual public ::Core::IObject
{
public:
	// ���������� ������������� ��������
	virtual const std::string& get_uid () const = 0;

	// �������, ��� ����� �������� ����� ��������
	virtual bool get_need_collect_children () const = 0;

	virtual void set_need_collect_children (bool need_collect_children) = 0;

	// ��������������� ��� ���������
	virtual const std::string& get_visibility_type () const = 0;

	virtual void set_visibility_type (const std::string& visibility_type) = 0;

	// ���������������� ��������
	virtual const Base::ToolPropertyMap& get_properties () const = 0;

	virtual void set_properties (const Base::ToolPropertyMap& properties) = 0;

	// ������������� ����-��������
	virtual void set_property (const std::string& tool_name, const std::string& name, const std::string& value) = 0;

	// ���������� �������� ��������, ���� �������� ���������� - ���������� 0 (������������ ���������
	// ����������� �� ����!!!)
	virtual std::string* get_property_value (const std::string& tool_name, const std::string& prop_name) const = 0;

	// ������� ��������
	virtual void remove_property (const std::string& tool_name, const std::string& prop_name) = 0;
};

class OverloadedItem;
typedef ::Core::Var<OverloadedItem> OverloadedItem_var;
typedef ::Core::Var<const OverloadedItem> OverloadedItem_cvar;
// �������� ����������������� ��������
class OverloadedItem
	: virtual public InheritedItem
{
};

/// factory interface for OverloadedItem
class OverloadedItemFactory {
public:
	// �������
	static OverloadedItem* make (const std::string& uid, bool need_collect_child)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ImplementedItem;
typedef ::Core::Var<ImplementedItem> ImplementedItem_var;
typedef ::Core::Var<const ImplementedItem> ImplementedItem_cvar;
// �������� ������������ ��������
class ImplementedItem
	: virtual public InheritedItem
{
};

/// factory interface for ImplementedItem
class ImplementedItemFactory {
public:
	// �������
	static ImplementedItem* make (const std::string& uid, bool need_collect_child)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������� ���������
struct InheritedItemComparator : public std::binary_function<InheritedItem_var, InheritedItem_var, bool> {
	bool operator () (InheritedItem_var first_param_, InheritedItem_var second_param_) const;
};

// �������
struct ImplementedItemComparator : public std::binary_function<ImplementedItem_var, ImplementedItem_var, bool> {
	bool operator () (ImplementedItem_var first_param_, ImplementedItem_var second_param_) const;
};

// �������
struct OverloadedItemComparator : public std::binary_function<OverloadedItem_var, OverloadedItem_var, bool> {
	bool operator () (OverloadedItem_var first_param_, OverloadedItem_var second_param_) const;
};

// ��������� �����������/���������������� ���������
typedef std::set < InheritedItem_var, InheritedItemComparator > InheritedItemSet;

typedef std::set < ImplementedItem_var, ImplementedItemComparator > ImplementedItemSet;

typedef std::set < OverloadedItem_var, OverloadedItemComparator > OverloadedItemSet;

class InheritedItemHelper;
typedef ::Core::Var<InheritedItemHelper> InheritedItemHelper_var;
typedef ::Core::Var<const InheritedItemHelper> InheritedItemHelper_cvar;
// �������������� ��������� ��� ������ � ������������/����������������� ����������
class InheritedItemHelper
	: virtual public ::Core::IObject
{
public:
	// ���������� ������ ���������������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	virtual OverloadedItemSet* get_stored_overloaded (IRoseElementPtr elem) const = 0;

	// ���������� ������ ���������������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	// elem ������ ���� ����������� RoseAbstractDumper (��� ������������ ��� Dumper, ����� �� ��������
	// �� ������ RoseDumpers)
	virtual OverloadedItemSet* get_stored_overloaded (const Base::Dumper* elem) const = 0;

	// ���������� ������ ����������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	virtual ImplementedItemSet* get_stored_implemented (IRoseElementPtr elem) const = 0;

	// ���������� ������ ����������� ���������, ��� �������� elem �� ������ ����������� �����
	// ����������
	// elem ������ ���� ����������� RoseAbstractDumper (��� ������������ ��� Dumper, ����� �� ��������
	// �� ������ RoseDumpers)
	virtual ImplementedItemSet* get_stored_implemented (const Base::Dumper* elem) const = 0;

	// ��������� ������ ����������� ���������
	virtual bool save (IRoseElementPtr elem, const ImplementedItemSet& items) const = 0;

	// ��������� ������ ��������������� ���������
	virtual bool save (IRoseElementPtr elem, const OverloadedItemSet& items) const = 0;

	// ���������� ������ ���������������� ��������� ����������� � ��������� �� ����� prop_name
	virtual InheritedItemSet* get_stored_inherited_items (IRoseElementPtr elem, const std::string& prop_name) const = 0;

	// ���������� ������ ���������������� ��������� ����������� � ��������� �� ����� prop_name
	// 
	// elem ������ ���� ����������� RoseAbstractDumper (��� ������������ ��� Dumper, ����� �� ��������
	// �� ������ RoseDumpers)
	virtual InheritedItemSet* get_stored_inherited_items (
		const Base::Dumper* elem
		, const std::string& prop_name
	) const = 0;

	// ���������� ��������������� �������� ��� ��������� ���������������� ���������
	virtual const std::string stored_value (const InheritedItemSet& inherited_items) const = 0;

	// ���������� ��������������� �������� ��� ��������� ���������������� ���������
	virtual const std::string stored_value (const OverloadedItemSet& inherited_items) const = 0;

	// ���������� ��������������� �������� ��� ��������� ���������������� ���������
	virtual const std::string stored_value (const ImplementedItemSet& inherited_items) const = 0;

	// ������� ������� ������� ��� ����������������� ��������
	virtual IRoseElementPtr make_wrapper (IRoseElementPtr elem, const InheritedItem* state) const = 0;

	// ��������� ������ ����������� ���������
	virtual bool save (Base::Dumper* elem, const ImplementedItemSet& items) const = 0;

	// ��������� ������ ���������������� ���������
	virtual bool save (Base::Dumper* elem, const OverloadedItemSet& items) const = 0;
};

/// factory interface for InheritedItemHelper
class InheritedItemHelperFactory {
public:
	static InheritedItemHelper& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ModelSearcher;
typedef ::Core::Var<ModelSearcher> ModelSearcher_var;
typedef ::Core::Var<const ModelSearcher> ModelSearcher_cvar;
// ��������������� ��������� ��� ������ ��������� ������. ��������� ���������� ������ ���������� ��
// ������ � �����! ����� �� ����� ���������� ��������� �� ���������� ����� - �.� ������ �����
// ���������� - � ���� ������ ��������� �� ������������
class ModelSearcher
	: virtual public ::Core::IObject
{
public:
	// ���� ������� ������ �� ��������������, ���� �� ������� - ���������� 0
	virtual IRoseElementPtr search (const std::string& uid) const = 0;

	// ��������� �������� ������ �������� (��� �������� �� ������ �������)
	virtual void on_new_element (IRoseElementPtr element) const = 0;

	// ��������� �������� �������� � ������
	virtual void on_delete_element (IRoseElementPtr elem) const = 0;
};

/// factory interface for ModelSearcher
class ModelSearcherFactory {
public:
	static ModelSearcher& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};


// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Category> {
	typedef CategoryFactory Factory;
};
template <>
struct TypeTraits <IsVirtual> {
	typedef IsVirtualFactory Factory;
};
template <>
struct TypeTraits <PropertyHelper> {
	typedef PropertyHelperFactory Factory;
};
template <>
struct TypeTraits <ModelPropertiesHelper> {
	typedef ModelPropertiesHelperFactory Factory;
};
template <>
struct TypeTraits <TypeLinkHelper> {
	typedef TypeLinkHelperFactory Factory;
};
template <>
struct TypeTraits <OverloadedItem> {
	typedef OverloadedItemFactory Factory;
};
template <>
struct TypeTraits <ImplementedItem> {
	typedef ImplementedItemFactory Factory;
};
template <>
struct TypeTraits <InheritedItemHelper> {
	typedef InheritedItemHelperFactory Factory;
};
template <>
struct TypeTraits <ModelSearcher> {
	typedef ModelSearcherFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_ROSEMODEL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
