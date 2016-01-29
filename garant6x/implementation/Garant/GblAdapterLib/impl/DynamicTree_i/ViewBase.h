////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ViewBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::ViewBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VIEWBASE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VIEWBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

namespace GblAdapterLib {

class ViewBase;
typedef Core::Var<ViewBase> ViewBase_var;
typedef Core::Var<const ViewBase> ViewBase_cvar;

class ViewBase :
	virtual public TreeBase
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	ViewBase ();

public:
	virtual ~ViewBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual GCL::StaticNode* build_node (const GTree::ViewNode& snode, FlagNodeBase* current_stub);

	virtual void init (
		FlagMask mode
		, unsigned int levels
		, bool auto_open
		, const TreeBase* parent_tree
		, GTree::Tree* server_tree
	);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_auto_open;

	unsigned int m_maximum_levels_restriction;

	FlagMask m_mode;

	DefaultNodeBase_var m_parent_tree_root;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual bool get_auto_open () const;

	virtual unsigned int get_maximum_levels_restriction () const;

	virtual FlagMask get_mode () const;

	virtual const DefaultNodeBase* get_parent_tree_root () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from TreeBase
	virtual Core::Mutex* get_change_mutex ();

	// implemented method from TreeBase
	virtual const std::string& get_tree_name () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from TreeBase
	virtual void expand_all (bool expand);

	// overloaded method from TreeBase
	virtual FlagMask get_shared_mode () const;

	// overloaded method from TreeBase
	virtual bool is_mode (FlagMask shared_flags) const;

	// overloaded method from TreeBase
	virtual GCL::StaticNode* load_nodes_from_server (
		GTree::NodePointer parent_point
		, GTree::NodePointer child_point
		, long from
		, unsigned long in_block_position
		, GCL::StaticNodeStubBase* current_stub
	) /*throw (
		TreeBase::InvalidOwnerTree
	)*/;
protected:

	// overloaded method from TreeBase
	virtual const TreeBase* master_tree () const;

}; // class ViewBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VIEWBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

