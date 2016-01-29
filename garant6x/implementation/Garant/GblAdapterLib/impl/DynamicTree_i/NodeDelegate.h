////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeDelegate
// ��������� ���������� ������ �������� ��� ��������� NodeBase
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"

// forward decls for defined friends
namespace GblAdapterLib {
	class NodeBase_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class NodeDelegate; // self forward Var
typedef ::Core::Var<NodeDelegate> NodeDelegate_var;
typedef ::Core::Var<const NodeDelegate> NodeDelegate_cvar;

class NodeDelegateServantFactory;

class NodeDelegate:
	virtual public NodeBase
	, virtual public ::Core::RefCountObjectBase
	, virtual public DelegateNodeBase
{
	SET_OBJECT_COUNTER (NodeDelegate)
	friend class NodeDelegateServantFactory;
	friend class NodeBase_i; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<NodeDelegate>::PoolMemoryManagerSingleton PoolNodeDelegate;
	typedef ::Core::PoolMemoryManager<NodeDelegate> Pool;
	friend class ::Core::PoolMemoryManager<NodeDelegate>;
	void* operator new (size_t cs) {              
		return PoolNodeDelegate::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolNodeDelegate::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit NodeDelegate (TreeBase* owner_tree);

	virtual ~NodeDelegate ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	const GCI::IO::String& get_master_caption () const;

	// ���������� false, ���� ���� ����������� ������� ������
	bool is_alive () const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NodeBase
	// ���������� add_last_childs �� ��� ����� ���� (���-���� ���������� ��������, �����
	// create_new_node ��� �������� �� ������, ���� ��� ���� �� ������ �� ����� ������� �����)
	virtual void add_last_child (NodeBase* node) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	// ��������� ���� �� ���������� � ����� ������ ����� - �� ����� ���� ���� ���� ���������� ��
	// ������� ������� ����� ����� �������, �� ����������� � ��������� �������
	virtual void add_last_childs (NodesClipboard* nodes);

	// implemented method from NodeBase
	virtual void add_notifier (NodeNotifier* notifier);

	// implemented method from NodeBase
	// ���������� add_prev_siblings �� ��� ����� ����
	virtual void add_prev_sibling (NodeBase* node) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	// ���������� add_last_childs, �� ���� ����������� ����� ��������� ��� ������, ��������������
	// ����������� ����� ������ ������� ����
	virtual void add_prev_siblings (NodesClipboard* nodes) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	// ���������������� �������� ����
	virtual const GCI::IO::String& get_caption () const;
	virtual GCI::IO::String& get_caption ();

	// implemented method from NodeBase
	virtual long get_child_count () const;

	// implemented method from NodeBase
	// ��������� ����������, � ���� ��� ������ ��� "�������" �������� ���������� - ��������� ���
	// ��������� ��������� �� ���� (���������� ������ �� ������)
	virtual void commit_change_transaction ();

	// implemented method from NodeBase
	// �������� ���� �� ��������� ����� � ���������� �� � ���� ���������� ��� ����������� ������� �
	// ����� ������ ������.�������� ��������� � �������� �� ����!!!
	virtual NodesClipboard* copy_nodes (FlagMask mask);

	// implemented method from NodeBase
	// ����������� ������ ������ create_view. (������� ��� ������ ��������� �� ����)
	virtual NodeBase* create_view_ex (
		const FilterList& filter
		, FlagMask shared_flags
		, const NodeBase* sync_node
		, VisibleIndex& sync_index
		, unsigned long levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
	);

	// implemented method from NodeBase
	// ������� ������� ����
	virtual void delete_node ();

	// implemented method from NodeBase
	// ������� ��� ���� �� ��������� �����. �������� ��������� � �������� �� ����!!!
	virtual void delete_nodes (FlagMask mask) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/;

	virtual void set_entity (EntityBase* entity);

	// implemented method from NodeBase
	// ������������� � ������� ���� ��������� ���� ��� � ������
	virtual void expand_all (bool expand);

	// implemented method from NodeBase
	// ����� � ������ �� �������, ��������� � �������. � ������ ������ ���������� �������� �������
	// ���������, ����� ������ �������� (is_good!=true).
	virtual FindIterator* find (const FilterList& filter, const NodePosition& find_from) const;

	// implemented method from NodeBase
	// ���� � ������� ������ ���� ������ ����������
	virtual NodeBase* find_node (const NodeBase* node_to_find) const;

	// implemented method from NodeBase
	// ��������� ���������� ���� ����. ������ ������ � ���� ��� ���� node_to_find
	virtual NodeIndexPath* find_node_path (NodeBase* node_to_find) const;

	// implemented method from NodeBase
	virtual const NodeBase* get_first_child () const;
	virtual NodeBase* get_first_child ();

	// implemented method from NodeBase
	// ���������� ���. ������ ��� ����
	virtual VisibleIndex get_abs_index () const /*throw (CanNotFindData)*/;

	// implemented method from NodeBase
	virtual LayerIdList* get_available_layers () const;

	// implemented method from NodeBase
	// ���������� ����-������ (�.�. "�����" �������) �� �������
	virtual NodeBase* get_by_sibbling_index (VisibleIndex ind);

	// implemented method from NodeBase
	// ���������� ���� �� �������� ������� ������������ �������
	virtual NodeBase* get_by_visible_index (VisibleIndex ind);

	// implemented method from NodeBase
	// ���������� ���� � ���� �� � ���. �������
	virtual NodeIndexPath* get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/;

	// implemented method from NodeBase
	virtual NodeIndexPath* get_first_fit (const FilterList& filter) const;

	// implemented method from NodeBase
	virtual unsigned long get_first_level_children_flag_count (FlagMask flag) const;

	// implemented method from NodeBase
	// ���������� ���-�� ��������� ������ � ������� ���������
	virtual unsigned long get_flag_count (FlagMask flag) const;

	// implemented method from NodeBase
	virtual NodeBase* get_frozen_node () const;

	// implemented method from NodeBase
	// ���������� ���������� ����� ���� ������������ �������� (������� � 1)
	virtual VisibleIndex get_index_from_parent () const;

	// implemented method from NodeBase
	// ��������� � CatalogBase
	virtual NodeBase* get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/;

	// implemented method from NodeBase
	// ��������� �������������� ����. ������ ���������� �������, �� ��� ��������� value->id (), �.�.
	// �� ��������.
	virtual NodeId get_node_id () const;

	// implemented method from NodeBase
	virtual NodeBase* get_unfiltered_node () const;

	// implemented method from NodeBase
	// ���������� ������� ������� �������� ���� ��� (����� ������������� ���������� ����������� ������)
	virtual VisibleIndex get_visible_delta (const NodeBase* node) const /*throw (NotFound)*/;

	// implemented method from NodeBase
	virtual VisibleIndex get_visible_delta_by_entity (const EntityBase* entity) const /*throw (NotFound)*/;

	// implemented method from NodeBase
	// �������� ���� �� ����
	virtual bool has_children () const;

	// implemented method from NodeBase
	// ������� ������� �� � ����� ��������� ����
	virtual bool has_children_flag (FlagMask flag) const;

	// implemented method from NodeBase
	// ������� ���� ��� ���� ��������� ��������������� �����
	virtual bool has_filtered_children () const;

	// implemented method from NodeBase
	// ������� ������� �� ��������� ����
	virtual bool has_flag (FlagMask flag) const;

	// implemented method from NodeBase
	// ������� ������� �� � ��������� ��������� ����
	virtual bool has_parent_flag (FlagMask flag) const;

	// implemented method from NodeBase
	// ���������� true, ���� ���������� ���� ��������� ���� ���
	virtual bool get_is_expanded () const;

	// implemented method from NodeBase
	// ������� ������ �� ��� �������
	virtual bool is_first () const;

	// implemented method from NodeBase
	// ���������� true ���� ���������� ���� (it) ���� �������
	virtual bool is_it_higher (NodeBase* it) const;

	// implemented method from NodeBase
	// ������� ��������� �� ��� �������
	virtual bool is_last () const;

	// implemented method from NodeBase
	virtual bool is_relevance_search_supported () const;

	// implemented method from NodeBase
	// ��������� �� ��������� ��� ����
	virtual bool is_same_node (NodeBase* node) const;

	// implemented method from NodeBase
	virtual NodeIterator* iterate_all_nodes (FlagMask with_flag);

	// implemented method from NodeBase
	// ���������� �������� �������� �� ����� � ��������� ������
	virtual NodeIterator* iterate_nodes (FlagMask with_flag);

	// implemented method from NodeBase
	// ������� ���� � ������
	virtual long get_level () const;

	// implemented method from NodeBase
	virtual void make_visible ();

	// implemented method from NodeBase
	virtual const NodeBase* get_next () const;
	virtual NodeBase* get_next ();

	// implemented method from NodeBase
	virtual const NodeBase* get_parent () const;
	virtual NodeBase* get_parent ();

	// implemented method from NodeBase
	virtual const NodeBase* get_prev () const;
	virtual NodeBase* get_prev ();

	// implemented method from NodeBase
	virtual void remove_notifier (NodeNotifier* notifier);

	// implemented method from NodeBase
	// ���������� �������� ���������� (������ �� ����� ����������),  ���������� ��� ���������
	// (������������ � ������� ��� ����������� �������)
	virtual void rollback_change_transaction ();

	// implemented method from NodeBase
	// ������������� � ����� ��������� (����� ����� ���� �� ������� ���� ������� ��������) ���������
	// ���� (������ �������� ������ �� ����, � ������ ������ ������ ���������, ����� ��������
	// ���������)
	virtual void set_all_flag (FlagMask flag, bool value);

	// implemented method from NodeBase
	virtual void set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value);

	// implemented method from NodeBase
	// ������� ��������� ����
	virtual void set_flag (FlagMask flag, bool value);

	// implemented method from NodeBase
	// �������� ������������� ����. ������ ������ �� ������, �� ��� ��������� �������� value->id ().
	virtual void set_node_id (NodeId id);

	// implemented method from NodeBase
	// ������� ��������� ���� �� ����������
	virtual void set_range_flag (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	// implemented method from NodeBase
	virtual void set_range_flag_except_first_children_of_root_children (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	// implemented method from NodeBase
	// ��������� �� ������ ���������� ��������� ������ ����. ���������� ����� ���� ����������
	virtual void start_change_transaction ();

	// implemented method from NodeBase
	// ���������������� ��� ����. ����� ���������� ��� ��������� ��������, ��� ������ ��������������
	// ��� ������������� �����������
	virtual NodeType get_type () const;

	virtual void set_type (NodeType type)
		/*throw (ConstantModify)*/;

	// implemented method from SettingEntity
	// ��������������� "������" �� �������� �������� � ������ ������ � ������ ����� (�������, �������)
	// �������.
	virtual SettingEntity* load_from_setting (PropertyID_const id) const;

	// implemented method from SettingEntity
	// ��������� "������" �� ������ ��������� � ����������, �������� �� � ���������� ��������� ������.
	// ��� ������ ������� ������� �� ����������� ������ ������������ ������� ���������.
	virtual void save_in_setting (PropertyID_const id) const;
}; // class NodeDelegate

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
