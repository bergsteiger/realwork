////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::TreeBase
//
// адаптерное дерево
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TREEBASE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TREEBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/GCL/data/StaticNode.h"
#include "shared/GCL/data/StaticNodeStubBase.h"
#include "shared/GCL/data/StaticNodeMng.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableBase.h"

//#UC START# *45F554750213_CUSTOM_INCLUDES*
//#UC END# *45F554750213_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class RealNodeRoot;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ViewBase;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ViewBase;
class RealNodeBase;
class DefaultNodeBase;
// адаптерное дерево
class TreeBase;
typedef Core::Var<TreeBase> TreeBase_var;
typedef Core::Var<const TreeBase> TreeBase_cvar;

class TreeBase :
	virtual public FakeFacetForFactory
	, virtual public GCL::StaticNodeMng
	, virtual public TimeStampSync::ActiveChangeableBase
{
	friend class RealNodeRoot; // defined friend
	friend class ViewBase; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	class InvalidOwnerTree : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

	class EmptyBranch : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

private:
	class NodeExpander {
		SET_OBJECT_COUNTER (NodeExpander)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		NodeExpander (bool all_expanded, bool expand_root);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		void each_func (GCL::StaticNode* static_node, int& dummy) const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		bool m_all_expanded;

		bool m_expand_root;
	}; // class NodeExpander

protected:
	struct FindedData {
		long index;
		GCL::StaticNode* node;
	};

	typedef std::map < const GCL::StaticNode*, unsigned long > CountMap;

	typedef std::map < FlagMask, CountMap > NodeFlagMap;

	typedef std::map < NotifierID, NodeNotifier_var > NotifierSet;

	typedef std::map < DefaultNodeBase*, long > CounterDeltaMap;

	typedef std::map < const DefaultNodeBase*, FindedData > FindedNodes;

	typedef std::map < FlagMask, DefaultNodeBase* > LastSelectMap;

	typedef std::map < GTree::NodePointer, DefaultNodeBase* > NodeMap;

public:
	class FlagMaskStubPostProcess {
		SET_OBJECT_COUNTER (FlagMaskStubPostProcess)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		FlagMaskStubPostProcess (FlagMask mask, bool action);

	public:
		virtual ~FlagMaskStubPostProcess ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		bool m_action;

		FlagMask m_mask;

	//#UC START# *46013DB90157*
	public:
		void operator () (FlagNodeBase* stub1, FlagNodeBase* stub2) {
			if (stub1) stub1->set_flag (m_mask, m_action, false);
			if (stub2) stub2->set_flag (m_mask, m_action, false);
		}
	//#UC END# *46013DB90157*
	}; // class FlagMaskStubPostProcess

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit TreeBase (bool active_changeable);

protected:
	TreeBase ();

public:
	virtual ~TreeBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void adapter_filters_to_server (FilterList& adap, GTree::Query& serv) const;

	virtual void add_notifier (GCL::StaticNode* root, NodeNotifier* notifier);

	virtual void apply_flags (const FlagNodeBase* from, FlagNodeBase* to, FlagMask shared_mask) const;

	virtual void apply_server_tree (GTree::Tree* server_tree);

	virtual GCL::StaticNode* build_node (const GTree::Node& snode, FlagNodeBase* current_stub, long master_index);

	virtual void cache_finded_node (const DefaultNodeBase* parent, long index, GCL::StaticNode* node) const;

	virtual void change_children_count (
		VisibleIndex index
		, long delta
		, NodeIndexPath& index_path
		, IndexInParent child_index
	);

	virtual void changed () const;

	virtual void changing () const;

	virtual GCL::StaticNode* create_view (
		const GCL::StaticNode* root
		, const GTree::Query& filter
		, FlagMask shared_flags
		, GTree::NodePointer sync_node
		, VisibleIndex& sync_index
		, unsigned int levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
	);

	virtual void expand_all (bool expand);

	virtual GTree::FindIterator* find (const GTree::NodePosition& find_from, FilterList& filter) const;

	virtual GCL::StaticNode* find_cached_node (const DefaultNodeBase* parent, long& index) const;

	virtual void flush_counter_delta ();

	virtual unsigned long get_all_flags_count (const FlagNodeBase* node, FlagMask flag) const;

	virtual GTree::Layers* get_available_layers () const;

	virtual GTree::Tree* get_cached_server_tree () const;

	virtual unsigned long get_children_flags_count (const FlagNodeBase* node, FlagMask flag) const;

	virtual GTree::NodePath* get_first_fit (const GCL::StaticNode* from_node, FilterList& filter) const;

	virtual DefaultNodeBase* get_last_selected (FlagMask flag) const;

	virtual FlagMask get_shared_mode () const;

	virtual void invalidate (const NodeIndexPath& index_path) const;

	virtual void invalidate_finded_node (const DefaultNodeBase* parent) const;

	virtual bool is_all_expanded () const;

	virtual bool is_loaded_node (GTree::NodePointer node_pointer) const;

	virtual bool is_mode (FlagMask shared_flags) const;

	virtual bool is_relevance_search_supported () const;

	virtual bool is_root_nil () const;

	virtual bool is_root_visible () const;

	// прогружает дерево целиком. см. http://mdp.garant.ru/pages/viewpage.action?pageId=17334971
	virtual void load_all_tree () const;

	virtual GCL::StaticNode* load_nodes_from_server (
		GTree::NodePointer parent_point
		, GTree::NodePointer child_point
		, long from
		, unsigned long in_block_position
		, GCL::StaticNodeStubBase* current_stub
	) /*throw (
		InvalidOwnerTree
	)*/;

	virtual GTree::NodeIndexPath* name_path_to_index_path (const GTree::NodeNamePath& name_path) const;

	virtual GTree::NodeIndexPath* pointer_path_to_index_path (const GTree::NodePointerPath& pointer_path) const;

	virtual GTree::NodeIndexPath* pointer_to_index_path (GTree::NodePointer pointer) const;

	virtual void pre_find (FilterList& filters) const;

	virtual void remove_notifier (GCL::StaticNode* root, NodeNotifier* notifier);

	virtual void reset_by_root (unsigned long new_root_ch_count);

	virtual void reset_by_server_tree (GTree::Tree* new_tree);

	virtual void reset_children_count ();

	virtual GCL::StaticNode* root () const;

	// used by RealNodeRoot::delete_obj ONLY
	virtual void root_is_dead ();

	virtual GTree::TreeDataVersionID server_data_version () const;

	virtual void set_changed (bool state);

	virtual void update_counters (const FlagNodeBase* node, FlagMask flag, bool value);

protected:
	// [timestamp_sync]
	virtual void apply_delta_postprocess (GTree::Delta& fake);

	virtual bool changed_layer (bool new_val) const;

	virtual void clear ();

	virtual void dump_flags_map (const char* context) const;

	virtual long get_load_block_half_size () const;

	virtual bool is_load_in_one_direction () const;

	virtual const TreeBase* master_tree () const;

	virtual void safety_remove ();

	virtual void set_load_block_half_size (long new_size);

	virtual void set_load_in_one_direction (bool yes);

private:
	virtual void add_to_loaded (RealNodeBase* node);

	virtual void bidir_calc_from_position (
		long offset
		, GTree::NodePointer child_point
		, GCL::StaticNodeStubBase* current_stub
		, long& from
		, unsigned long& in_block_position
	);

	virtual void calc_from_position (
		long offset
		, GTree::NodePointer child_point
		, GCL::StaticNodeStubBase* current_stub
		, long& from
		, unsigned long& in_block_position
	);

	virtual void load_children (const GCL::StaticNode* parent) const;

	const GCL::StaticNode* load_stub_node (GCL::StaticNodeStubBase* node) const;

	virtual void onedir_calc_from_position (
		long offset
		, GTree::NodePointer child_point
		, GCL::StaticNodeStubBase* current_stub
		, long& from
		, unsigned long& in_block_position
	);


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	virtual RealNodeBase* apply_created_node (const GTree::CreateData& data) = 0;

	virtual GTree::NewNodeUID associate_node_with_uid (RealNodeBase* node) = 0;

	virtual void disassociate_node_with_uid (RealNodeBase* node) = 0;

	virtual GTree::NewNodeUID find_created_uid (RealNodeBase* node) = 0;

	virtual Core::Mutex* get_change_mutex () = 0;

protected:
	virtual DefaultNodeBase* alloc_new_node (const GTree::Node& snode) = 0;

	virtual ViewBase* alloc_new_view () = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_active_changeble;

	bool m_all_expanded;

	mutable bool m_changed_layer;

	mutable CounterDeltaMap m_counter_deltas;

	mutable FindedNodes m_finded_node;

	NodeFlagMap m_flags_map;

	bool m_is_changed;

	LastSelectMap m_last_select;

	long m_load_block_half_size;

	bool m_load_in_one_direction;

	NodeMap m_nodes;

	NotifierSet m_notifiers;

	mutable GCL::StaticNode* m_root;

	unsigned long m_selected_count;

	mutable GTree::TreeDataVersionID m_server_data_version;

	mutable GTree::Tree_var m_server_tree;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const NodeFlagMap& get_flags_map () const;

	virtual bool get_is_changed () const;

	virtual GTree::Tree* get_server_tree () const;

	virtual const std::string& get_tree_name () const = 0;
protected:
	virtual bool get_active_changeble () const;

	virtual void set_active_changeble (bool active_changeble);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from GCL::StaticNodeMng
	// создать ноду
	virtual GCL::StaticNode* make_real_node (
		const GCL::StaticNode* parent
		, const GCL::StaticNode* prev
		, long offset
		, GCL::StaticNodeStubBase* current_stub
	);

	// implemented method from GCL::StaticNodeMng
	// функция вызывается перед удалением?
	virtual void pre_remove (const GCL::StaticNode* node, unsigned int count = 0);
protected:

	// implemented method from ActiveChangeable
	virtual void acquire_update_mutex ();

	// implemented method from ActiveChangeable
	virtual void release_update_mutex ();

	// implemented method from ActiveChangeable
	virtual void update_cache (const CORBA::Any& hint);

//#UC START# *45F554750213*
protected:
#ifdef _USE_FIRST_DROP_SELECTION_HACK
	bool m_first_drop_selection;
#endif
//#UC END# *45F554750213*
}; // class TreeBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TREEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

