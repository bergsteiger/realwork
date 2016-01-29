////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// ��������� ������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// ������������� ���� �������� ������� � ����. � ������ ���������� ������ ������������ ���
// AdapterEnum
typedef unsigned long EntityType;

// ������������ ���� ���� �� ����� ���� �����������.
class CopyDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� ��� ������� ������������ ���� �� ���������� ���������� ��� ���������.
class InvalidContainer : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ���� ���� �� ����� ���� ����������.
class MoveDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ��� ������� ��������� ����� �������� �������� ������� ����.
class InvalidEntityType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ��� ������� �������� ������� ������ �� ��������������� �������. �.�. index<0 ���
// index>=count.
class InvalidIndex : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ��� ������� ������� �������� open � �������� ��������, �� ����������� ��������� (�
// ��������� � �����).
class NotEntityElement : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Node;
typedef ::Core::Var<Node> Node_var;
typedef ::Core::Var<const Node> Node_cvar;
// ��������� ��� ������ ������ �� �������� ����������� ���������.
class Node
	: virtual public EntityStorage
{
public:
	// ������� ����������� �������� � ����������� ���������.
	// � root_node=0.
	virtual long get_level () const = 0;

	// ���������� ��������� ��������� ��� �������� (���� �������).
	// � ��������� ��������� =0.
	virtual long get_child_count () const = 0;

	// ���������� ��������� ��������� ��� �������� � ������ ���� ������� �����������.
	// � ��������� ��������� =0.
	virtual long get_all_child_count () const = 0;

	// ���� ��� �������� �������������� �������� ���������� � ������� ��������.
	virtual long get_flags () const = 0;

	// ������� �������� �������� � ������ (parent).
	virtual long get_index () const = 0;

	// �������� ������� ��������.
	virtual long get_through_index () const = 0;

	// ��������
	virtual const Node* get_parent () const = 0;
	virtual Node* get_parent () = 0;

	// ���������� ���� � ������
	virtual const Node* get_previous_node () const = 0;
	virtual Node* get_previous_node () = 0;

	// ��������� ���� � ������
	virtual const Node* get_next_node () const = 0;
	virtual Node* get_next_node () = 0;

	// ��������
	virtual const GCI::IO::String& get_caption () const = 0;
	virtual GCI::IO::String& get_caption () = 0;

	virtual void set_caption (GCI::IO::String* caption)
		/*throw (ConstantModify, AccessDenied)*/ = 0;

	// ���������� � ����
	virtual const GCI::IO::String& get_hint () const = 0;
	virtual GCI::IO::String& get_hint () = 0;

	virtual void set_hint (GCI::IO::String* hint)
		/*throw (ConstantModify, AccessDenied)*/ = 0;

	// ��� ��������, �������������� �����
	virtual EntityType get_object_type () const
		/*throw (Unsupported)*/ = 0;

	// �������� ��������� �� ���� �� ��������� ���������.
	// �������� ������ ��������� �������� �� ���������: 0<=index<=(child_coun-1)
	virtual Node* get_child (long index) /*throw (InvalidIndex)*/ = 0;

	// ���������� ������� ������� � ���������, �������� � ��������� node.
	// ���������� true � ������ ����������.
	virtual bool is_same_node (const Node* node) const = 0;

	// ���������� ��������� ��� ������ � ���������� ��������� (���������) �������.
	virtual Core::IObject* open () /*throw (CanNotFindData, NotEntityElement)*/ = 0;

	// ������� ��������� ���� �� ������/������.
	// ���� ������ �������, ������� ��������� ��������, �� ��� ���� ���������. ���� ������/������
	// �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	virtual void delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/ = 0;

	// ��������� �������� ��� ������� � ��������� ����, ���������� ����� ��������� ����. ����
	// ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify.
	// ���� ���� �� ����� ��������� ����� ������������ ���������� InvalidContainer
	virtual Node* add_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/ = 0;

	// ��������� �������� ��� "������" ������ � ��������� ����, ���������� ����� ��������� ����. ����
	// ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	virtual Node* add_sibling_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, Unsupported
		, DuplicateNode
	)*/ = 0;

	// ��������� ������� ���� � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� ��������
	// ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� ��������
	// ����������� ����� �� ��������, ������������ ���������� MoveDisabled
	virtual void move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/ = 0;

	// �������� ������� ���� � ���������� ��� �� ����������, � ��������� ����, ����� �� ��� ��������.
	// ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ����������
	// InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ����������
	// CopyDisabled
	virtual void copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/ = 0;

	// ����� �� ����������� ����
	virtual bool can_move () const = 0;

	// ����� �� ����������� ����
	virtual bool can_copy () const = 0;

	// ����� �� �������� ����
	virtual bool can_insert (Node* source) const = 0;

	// ���������� �������.
	virtual bool is_last () const = 0;

	// ������ �������.
	virtual bool is_first () const = 0;

	// ���� �� �������� ��������.
	virtual bool has_child () const = 0;

	// ������������ �������� ����
	virtual Node* override_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/ = 0;

	// ����� �� �������������� ����
	virtual bool can_modify () const = 0;
};

/// factory interface for Node
class NodeFactory {
public:
	// �������
	static Node* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class BaseCatalog;
typedef ::Core::Var<BaseCatalog> BaseCatalog_var;
typedef ::Core::Var<const BaseCatalog> BaseCatalog_cvar;
// ������� ��������� ��� ������ � ������������ �/��� ��������� �������� ��������� ���������
// �������. ��������� �� ��������� (������ ��� �������� ������) �������������� ����� ����������
// ���������� Node. ��� ���� ������ ��������� Node ����� ���� �������� � ���������� �����������
// �������� ����� ����� open ���������� BaseCatalog. ��� ���� ��� �� �������� ����� ���� ��������
// ����� �������, �� ��������� ������ ������������� ��������� BaseEntity.
// � ������ ���� ���������� ������ �� ������������ ��� ��� ���� �������� ������������ ��
// BaseCatalog, �� ��� �� ������ ������ �������������� ����������
class BaseCatalog
	: virtual public ::Core::IObject
{
public:
	// ������ ������
	virtual const Node* get_root () const = 0;
	virtual Node* get_root () = 0;

	// ���������� ������
	virtual const EntityType get_filter () const = 0;

	virtual void set_filter (EntityType filter) = 0;

	// ����� ���� �� ��� ��������.
	virtual Node* find (const Core::IObject* entity) const = 0;

	// ����� ��������� ����� ��������� ������.
	virtual Node* find_context (
		const char* mask
		, const SearchMode& mode
		, const Node* cur_item
		, ContextSearchResult*& result
	) const = 0;

	// ���������� ��� ������������� ������� �� �����
	virtual void reset_type_filter () const = 0;
};

// ����� �� ������ ����
typedef unsigned long BaseTreeNodeMask;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Node> {
	typedef GblAdapterLib::NodeFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
