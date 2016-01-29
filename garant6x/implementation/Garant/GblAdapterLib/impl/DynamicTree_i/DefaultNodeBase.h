////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::DefaultNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DEFAULTNODEBASE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DEFAULTNODEBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeStub.h"

//#UC START# *45F7ECA8034B_CUSTOM_INCLUDES*
//#UC END# *45F7ECA8034B_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class TreeBase;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DefaultNodeBase;
typedef Core::Var<DefaultNodeBase> DefaultNodeBase_var;
typedef Core::Var<const DefaultNodeBase> DefaultNodeBase_cvar;

class DefaultNodeBase :
	virtual public FlagNodeBase
{
	friend class TreeBase; // defined friend
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	static GTree::NodeIndexPath* adapter_path_to_srv (const NodeIndexPath& adapter_index_path);

	static void srv_path_to_adapter (GTree::NodeIndexPath* index_path, NodeIndexPath& adap_path);

protected:
	static DefaultNodeBase* get_real_interface (const GCL::StaticNode* node_);

private:
	static void index_path_to_node_path (const NodeIndexPath& path, GTree::NodePath& node_path, long l);

	static void print_path (const DefaultNodeBase* node_to_find, const NodeIndexPath& path);

	static void server_layers_id_list_to_adapter (const GTree::Layers& srv, LayerIdList& adap);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit DefaultNodeBase (TreeBase* owner_tree);

protected:
	DefaultNodeBase ();

public:
	virtual ~DefaultNodeBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual DefaultNodeBase* find_loaded_node_by_path (
		GTree::NodeIndexPath* node_index_path
	) const /*throw (
		GTree::InvalidPointer
	)*/;

	virtual DefaultNodeBase* find_node_by_path (const GTree::NodePath& node_path) const;

	virtual DefaultNodeBase* find_node_by_path (
		GTree::NodeIndexPath* node_index_path
	) const /*throw (
		GTree::InvalidPointer
	)*/;

	virtual GTree::NodePath* get_server_path (GTree::PathType path_type = GTree::PT_POINTER) const;

	virtual const std::string get_settings_root_id () const;

	virtual const char* get_tree_name () const;

	virtual TreeBase* get_tree_owner ();

	virtual VisibleIndex get_visible_index () const;

	virtual TreeBase* owner_tree ();

	virtual const TreeBase* owner_tree () const;

	virtual GTree::TreeDataVersionID server_data_version () const;

	virtual bool set_range_flag_except_first_children_of_root_children (
		VisibleIndex from
		, VisibleIndex to
		, FlagMask flag
		, bool value
		, bool clean_other
		, bool with_notify
	);

protected:
	virtual void add_notifier (NodeNotifier* notifier);

	virtual bool apply_delete_delta (GTree::DeleteDelta& delta);

	virtual bool apply_insert_delta (GTree::InsertDelta& delta);

	virtual bool apply_reset_delta (GTree::ResetDelta& delta);

	virtual void clean ();

	virtual GCL::StaticNode* create_view_ex (
		const FilterList& filter
		, FlagMask shared_flags
		, const DefaultNodeBase* sync_node
		, VisibleIndex& sync_index
		, unsigned long levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
	) const;

	virtual GTree::NodeEntity* entity () const /*throw (NoEntity)*/;

	virtual void expand_all_nodes (bool expand);

	virtual FindIterator* find (const FilterList& filter, const NodePosition& find_from) const;

	virtual DefaultNodeBase* find_node (GTree::NodePointer node_to_find) const;

	virtual DefaultNodeBase* find_node_by_interface (const NodeBase* node_to_find) const;

	virtual NodeIndexPath* find_node_path (NodeBase* node_to_find) const;

	virtual FlagNodeStub* find_stub_for_index (long& index);

	virtual VisibleIndex get_abs_index () const /*throw (CanNotFindData)*/;

	virtual void get_available_layers (LayerIdList& layers) const;

	virtual NodeIndexPath* get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/;

	virtual NodeIndexPath* get_first_fit (const FilterList& filter) const;

	virtual unsigned long get_first_level_children_flag_count (FlagMask flag) const;

	virtual unsigned long get_flag_count (FlagMask flag) const;

	// TODO: упростить, выкинув этот метод
	// ходить только к StaticNode-е
	virtual VisibleIndex get_index_from_parent () const;

	// Дублирует с CatalogBase
	virtual NodeBase* get_node_by_path (const NodeIndexPath& path) const;

	virtual VisibleIndex get_visible_delta (DefaultNodeBase* node) const;

	virtual VisibleIndex get_visible_delta (const GTree::NodePath& node_path) const;

	virtual VisibleIndex get_visible_delta (const EntityBase* entity) const;

	virtual bool has_children_flag (FlagMask flag) const;

	virtual bool has_parent_flag (FlagMask flag) const;

	virtual void invalidate_children_count () const;

	virtual bool is_all_expanded () const;

	virtual bool is_relevance_search_supported () const;

	virtual GTree::NodeIndexPath* node_path_to_index_path (const GTree::NodePath& path) const;

	virtual GCL::StaticNode* remove_me_and_siblings (unsigned long& count);

	virtual void remove_notifier (NodeNotifier* notifier);

	virtual void set_children_flag (FlagMask flag, bool value);

	virtual bool set_range_flag (
		VisibleIndex from
		, VisibleIndex to
		, FlagMask flag
		, bool value
		, bool clean_other
		, bool with_notify
	);


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	virtual GTree::NodePointer get_server_pointer () const = 0;

	virtual const char* node_name () const = 0;

protected:
	virtual bool apply_change_delta (GTree::ChangeDelta& delta) = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	FlagMask m_children_flags;

	TreeBase* m_owner_tree;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual FlagMask get_children_flags () const;

	virtual void set_owner_tree (TreeBase* owner_tree);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from FlagNodeBase
	// возвращает количество взведённых (изменённых?) флагов.
	virtual size_t internal_set_all_flag (FlagMask flag, bool value, bool children_only);

	// implemented method from FlagNodeBase
	virtual size_t internal_set_all_flag_except_first_children_of_root_children (
		FlagMask flag
		, bool value
		, bool children_only
	);

	// implemented method from FlagNodeBase
	virtual void set_all_flag (FlagMask flag, bool value, bool with_notify);

	// implemented method from FlagNodeBase
	virtual void set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value, bool with_notify);
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from FlagNodeBase
	virtual bool set_flag (FlagMask flag, bool value, bool with_notify);


//#UC START# *45F7ECA8034B*
//#UC END# *45F7ECA8034B*
}; // class DefaultNodeBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DEFAULTNODEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

