////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::Tree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"

//#UC START# *45F585F802AF_CUSTOM_INCLUDES*
//#UC END# *45F585F802AF_CUSTOM_INCLUDES*

namespace GblAdapterLib {

template <class NodeType_, class NodeDelegateType_>
class Tree :
	virtual public TreeBase
{

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
protected:
	typedef std::map < GTree::NewNodeUID, RealNodeBase_var > NewNodeMap;

	typedef std::map < RealNodeBase*, GTree::NewNodeUID > NewNodeBackMap;

	typedef std::map < GTree::NodePointer, RealNodeBase_var > ApplyedNodeMap;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
protected:
	static GTree::NewNodeUID create_uid (const RealNodeBase* new_node);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit Tree (bool is_active_changeable);

public:
	virtual ~Tree ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Mutex m_change_mutex;

	NewNodeBackMap m_new_node_back_map;

	NewNodeMap m_new_node_map;

	std::string m_tree_name;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual const std::string& get_tree_name () const;

	virtual void set_tree_name (const std::string& tree_name);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from TreeBase
	virtual RealNodeBase* apply_created_node (const GTree::CreateData& data);

	// implemented method from TreeBase
	virtual GTree::NewNodeUID associate_node_with_uid (RealNodeBase* node);

	// implemented method from TreeBase
	virtual void disassociate_node_with_uid (RealNodeBase* node);

	// implemented method from TreeBase
	virtual GTree::NewNodeUID find_created_uid (RealNodeBase* node);

	// implemented method from TreeBase
	virtual Core::Mutex* get_change_mutex ();
protected:

	// implemented method from TreeBase
	virtual DefaultNodeBase* alloc_new_node (const GTree::Node& snode);

	// implemented method from TreeBase
	virtual ViewBase* alloc_new_view ();

//#UC START# *45F585F802AF*
//#UC END# *45F585F802AF*
}; // class Tree

} // namespace GblAdapterLib

#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.i.h"

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

