////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/Node_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTreeSupport_i::Node_i
// ��������� ���������� ������ �������� ��� ��������� Node
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_I_NODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_I_NODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"

//#UC START# *45702285038A_CUSTOM_INCLUDES*
#include <map>
//#UC END# *45702285038A_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class Node_i; // self forward Var
typedef ::Core::Var<Node_i> Node_i_var;
typedef ::Core::Var<const Node_i> Node_i_cvar;

class Node_i:
	virtual public Node
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Node_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Node_i ();


	Node_i (
		const char* caption
		, void* data
		, long flags
		, const char* hint
		, unsigned long level
		, unsigned long index
		, unsigned long object_type
		, Node* parent
	);

	virtual ~Node_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void clear_cache ();

	virtual void clear_cache (unsigned long index, long count);

	virtual void fix_after_del (unsigned long index, long decrement);

	virtual void fix_indexes (long index_decrement, long through_index_decrement, long index_in_list_decrement);

	virtual void* get_data () const;

	virtual void nil_parent ();

protected:
	virtual bool load () = 0;

	virtual Node* load_child (unsigned long index) = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���������� ���� �����
	mutable unsigned long m_all_children_count;

	// ���������
	GCI::IO::String_var m_caption;

	// ���������� ���������������� �����
	mutable unsigned long m_children_count;

	// ������
	const void* m_data;

	// �����
	BaseTreeNodeMask m_flags;

	// �����������
	GCI::IO::String_var m_hint;

	// ���������� �����
	unsigned long m_index;

	// ��� �������
	unsigned long m_object_type;

	// ��������
	Node* m_parent;

	// �������� ���������� �����
	mutable unsigned long m_through_index;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Node
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
	)*/;

	// implemented method from Node
	// ��������� �������� ��� "������" ������ � ��������� ����, ���������� ����� ��������� ����. ����
	// ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	virtual Node* add_sibling_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, Unsupported
		, DuplicateNode
	)*/;

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
	// ��������
	virtual const GCI::IO::String& get_caption () const;
	virtual GCI::IO::String& get_caption ();

	virtual void set_caption (GCI::IO::String* caption)
		/*throw (ConstantModify, AccessDenied)*/;

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
	// ���� ��� �������� �������������� �������� ���������� � ������� ��������.
	virtual long get_flags () const;

	// implemented method from Node
	// �������� ��������� �� ���� �� ��������� ���������.
	// �������� ������ ��������� �������� �� ���������: 0<=index<=(child_coun-1)
	virtual Node* get_child (long index) /*throw (InvalidIndex)*/;

	// implemented method from Node
	// ���� �� �������� ��������.
	virtual bool has_child () const;

	// implemented method from Node
	// ���������� � ����
	virtual const GCI::IO::String& get_hint () const;
	virtual GCI::IO::String& get_hint ();

	virtual void set_hint (GCI::IO::String* hint)
		/*throw (ConstantModify, AccessDenied)*/;

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
	// ���������� ��������� ��� ������ � ���������� ��������� (���������) �������.
	virtual Core::IObject* open () /*throw (CanNotFindData, NotEntityElement)*/;

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

//#UC START# *45702285038A*
protected:
	//typedef ACE_Hash_Map_Manager <ACE_UINT32, INode_var, ACE_SYNCH_MUTEX> ChildrenMap;
	//class ChildrenMap : public std::map<ACE_UINT32, INode_var> {
	typedef std::map<unsigned long, Node_var> ChildrenMap;

private:
	ChildrenMap m_children_map;

	// �������
	ACE_UINT32 m_level : 31;
	
	// ��������� �� ������ ����
	//mutable ACE_Atomic_Op <ACE_SYNCH_RECURSIVE_MUTEX, bool> m_loaded;
	mutable bool m_loaded : 1;
//#UC END# *45702285038A*
}; // class Node_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETREESUPPORT_I_NODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
