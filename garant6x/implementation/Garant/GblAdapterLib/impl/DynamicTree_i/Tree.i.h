////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::Tree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/View.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i_factory.h"

//#UC START# *45F585F802AF_CUSTOM_INCLUDES*
//#UC END# *45F585F802AF_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F585F802AF*
//#UC END# *45F585F802AF*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

template <class NodeType_, class NodeDelegateType_>
GTree::NewNodeUID Tree<NodeType_, NodeDelegateType_>::create_uid (const RealNodeBase* new_node) {
	//#UC START# *4602552E0157*
	return ACE_OS::gethrtime ();
	//#UC END# *4602552E0157**cpp*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class NodeType_, class NodeDelegateType_>
Tree<NodeType_, NodeDelegateType_>::Tree (
	bool is_active_changeable
)
//#UC START# *45F589A9009C_BASE_INIT*
: TreeBase (is_active_changeable)
//#UC END# *45F589A9009C_BASE_INIT**cpp*
{
	//#UC START# *45F589A9009C_BODY*
	//#UC END# *45F589A9009C_BODY**cpp*
}

template <class NodeType_, class NodeDelegateType_>
Tree<NodeType_, NodeDelegateType_>::~Tree () {
	//#UC START# *45F585F802AF_DESTR_BODY*
	//LOG_D (("%s", GDS_CURRENT_FUNCTION));
	//#UC END# *45F585F802AF_DESTR_BODY**cpp*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

template <class NodeType_, class NodeDelegateType_>
const std::string& Tree<NodeType_, NodeDelegateType_>::get_tree_name () const {
	//#UC START# *460259A6032C_GET_ACCESSOR*
	return m_tree_name;
	//#UC END# *460259A6032C_GET_ACCESSOR*
}

template <class NodeType_, class NodeDelegateType_>
void Tree<NodeType_, NodeDelegateType_>::set_tree_name (const std::string& tree_name) {
	//#UC START# *460259A6032C_SET_ACCESSOR*
	m_tree_name = tree_name;
	//#UC END# *460259A6032C_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TreeBase
template <class NodeType_, class NodeDelegateType_>
DefaultNodeBase* Tree<NodeType_, NodeDelegateType_>::alloc_new_node (const GTree::Node& snode) {
	//#UC START# *460127AC0157_45F585F802AF*
	//LOG_D (("Tree[%d]::alloc_new_node (%d, %s)", (TreeBase*)this, snode.pointer, (const char*)snode.name));
	if (snode.pointer != GTree::ROOT_POINT) {
		return Core::TypeTraits<NodeType_>::Factory::make (this, snode);
	} else {
		return RealNodeRootServantFactory::make (this, snode);
	}		
	//#UC END# *460127AC0157_45F585F802AF**cpp*
}

// implemented method from TreeBase
template <class NodeType_, class NodeDelegateType_>
ViewBase* Tree<NodeType_, NodeDelegateType_>::alloc_new_view () {
	//#UC START# *460127E400EA_45F585F802AF*
	return new View<NodeDelegateType_> ();
	//#UC END# *460127E400EA_45F585F802AF**cpp*
}

// implemented method from TreeBase
template <class NodeType_, class NodeDelegateType_>
RealNodeBase* Tree<NodeType_, NodeDelegateType_>::apply_created_node (const GTree::CreateData& data) {
	//#UC START# *460125E60203_45F585F802AF*
	//LOG_D (("Tree[%d]::apply_created_node(uid=%d, point=%d) try...", this, data.created_uid, data.new_node_pointer));
	RealNodeBase_var ret;
	NewNodeMap::iterator f = m_new_node_map.find (data.created_uid);
	if (f != m_new_node_map.end()) {
		ret = f->second;
		ret->init_inserted (this, data);
		m_new_node_map.erase (f);			
		m_new_node_back_map.erase (ret.in());
	}
	return ret._retn();
	//#UC END# *460125E60203_45F585F802AF**cpp*
}

// implemented method from TreeBase
template <class NodeType_, class NodeDelegateType_>
GTree::NewNodeUID Tree<NodeType_, NodeDelegateType_>::associate_node_with_uid (RealNodeBase* node) {
	//#UC START# *46012657032C_45F585F802AF*
	node->init (this);

	GTree::NewNodeUID uid = Tree::create_uid (node);
	m_new_node_map[uid] = RealNodeBase::_duplicate(node);
	m_new_node_back_map[node] = uid;
	
	return uid;
	//#UC END# *46012657032C_45F585F802AF**cpp*
}

// implemented method from TreeBase
template <class NodeType_, class NodeDelegateType_>
void Tree<NodeType_, NodeDelegateType_>::disassociate_node_with_uid (RealNodeBase* node) {
	//#UC START# *4601267E0177_45F585F802AF*
	node->reset (this);

	m_new_node_map.erase (m_new_node_back_map[node]);
	m_new_node_back_map.erase(node);
	//#UC END# *4601267E0177_45F585F802AF**cpp*
}

// implemented method from TreeBase
template <class NodeType_, class NodeDelegateType_>
GTree::NewNodeUID Tree<NodeType_, NodeDelegateType_>::find_created_uid (RealNodeBase* node) {
	//#UC START# *46012631034B_45F585F802AF*
	//LOG_D (("Tree::find_created_uid(node=%d) try...", (StaticNode*)node));
	NewNodeBackMap::iterator f = m_new_node_back_map.find(node);
	if (f != m_new_node_back_map.end()) {
		//LOG_D (("\t ...find %d", f->second));
		return f->second;
	} else {
		return 0;
	}
	//#UC END# *46012631034B_45F585F802AF**cpp*
}

// implemented method from TreeBase
template <class NodeType_, class NodeDelegateType_>
Core::Mutex* Tree<NodeType_, NodeDelegateType_>::get_change_mutex () {
	//#UC START# *460139CE02BF_45F585F802AF*
	return &m_change_mutex;
	//#UC END# *460139CE02BF_45F585F802AF**cpp*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

