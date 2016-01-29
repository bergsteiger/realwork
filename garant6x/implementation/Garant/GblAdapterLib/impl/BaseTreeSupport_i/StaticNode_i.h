////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/StaticNode_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTreeSupport_i::StaticNode_i
// ��������� ���������� ������ �������� ��� ��������� Node
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_I_STATICNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_I_STATICNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"

namespace GblAdapterLib {

class StaticNode_i; // self forward Var
typedef ::Core::Var<StaticNode_i> StaticNode_i_var;
typedef ::Core::Var<const StaticNode_i> StaticNode_i_cvar;

class StaticNode_i:
	virtual public Node
	, virtual public ::Core::RefCountObjectBase
	, virtual public GCL::StaticNode
{
	SET_OBJECT_COUNTER (StaticNode_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StaticNode_i ();

	virtual ~StaticNode_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Node
	// ���������� ��������� ��������� ��� �������� � ������ ���� ������� �����������.
	// � ��������� ��������� =0.
	virtual long get_all_child_count () const;

	// implemented method from Node
	// ����� �� ����������� ����
	virtual bool can_copy () const;

	// implemented method from Node
	// ����� �� �������� ����
	virtual bool can_insert (Node* source) const;

	// implemented method from Node
	// ����� �� �������������� ����
	virtual bool can_modify () const;

	// implemented method from Node
	// ����� �� ����������� ����
	virtual bool can_move () const;

	// implemented method from Node
	// ���������� ��������� ��������� ��� �������� (���� �������).
	// � ��������� ��������� =0.
	virtual long get_child_count () const;

	// implemented method from Node
	// �������� ������� ���� � ���������� ��� �� ����������, � ��������� ����, ����� �� ��� ��������.
	// ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ����������
	// InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ����������
	// CopyDisabled
	virtual void copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/;

	// implemented method from Node
	// ������� ��������� ���� �� ������/������.
	// ���� ������ �������, ������� ��������� ��������, �� ��� ���� ���������. ���� ������/������
	// �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	virtual void delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/;

	// implemented method from Node
	// �������� ��������� �� ���� �� ��������� ���������.
	// �������� ������ ��������� �������� �� ���������: 0<=index<=(child_coun-1)
	virtual Node* get_child (long index) /*throw (InvalidIndex)*/;

	// implemented method from Node
	// ���� �� �������� ��������.
	virtual bool has_child () const;

	// implemented method from Node
	// ������� �������� �������� � ������ (parent).
	virtual long get_index () const;

	// implemented method from Node
	// ������ �������.
	virtual bool is_first () const;

	// implemented method from Node
	// ���������� �������.
	virtual bool is_last () const;

	// implemented method from Node
	// ���������� ������� ������� � ���������, �������� � ��������� node.
	// ���������� true � ������ ����������.
	virtual bool is_same_node (const Node* node) const;

	// implemented method from Node
	// ������� ����������� �������� � ����������� ���������.
	// � root_node=0.
	virtual long get_level () const;

	// implemented method from Node
	// ��������� ������� ���� � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� ��������
	// ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� ��������
	// ����������� ����� �� ��������, ������������ ���������� MoveDisabled
	virtual void move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/;

	// implemented method from Node
	// ��������� ���� � ������
	virtual const Node* get_next_node () const;
	virtual Node* get_next_node ();

	// implemented method from Node
	// ��� ��������, �������������� �����
	virtual EntityType get_object_type () const
		/*throw (Unsupported)*/;

	// implemented method from Node
	// ������������ �������� ����
	virtual Node* override_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/;

	// implemented method from Node
	// ��������
	virtual const Node* get_parent () const;
	virtual Node* get_parent ();

	// implemented method from Node
	// ���������� ���� � ������
	virtual const Node* get_previous_node () const;
	virtual Node* get_previous_node ();

	// implemented method from Node
	// �������� ������� ��������.
	virtual long get_through_index () const;
}; // class StaticNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_I_STATICNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
