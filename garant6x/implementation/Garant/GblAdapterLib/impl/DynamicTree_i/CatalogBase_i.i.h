////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CatalogBase_i.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CatalogBase_i
// Файл inline реализации класса серванта для интерфеса CatalogBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class NodeType_>
CatalogBase_i<NodeType_>::~CatalogBase_i () {
	//#UC START# *45F68EF8008C_DESTR_BODY*
	//#UC END# *45F68EF8008C_DESTR_BODY**cpp*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

template <class NodeType_>
TreeBase* CatalogBase_i<NodeType_>::get_cached_adapter_tree () const {
	//#UC START# *45F7E92A009C*
	GDS_ASSERT (!m_root.is_nil ());
	DefaultNodeBase* node_base = dynamic_cast<NodeBase_i*> (m_root.in ());
	GDS_ASSERT (node_base);
	return node_base->owner_tree ();
	//#UC END# *45F7E92A009C**cpp*
}

// Получение рута
template <class NodeType_>
NodeBase* CatalogBase_i<NodeType_>::get_cached_root () const {
	//#UC START# *4A01865200F5*
	return m_root.ptr ();
	//#UC END# *4A01865200F5**cpp*
}

template <class NodeType_>
GTree::Tree* CatalogBase_i<NodeType_>::get_cached_server_tree () const {
	//#UC START# *45F7E8A0038A*
	GDS_ASSERT (!m_root.is_nil ());
	DefaultNodeBase* node_base = dynamic_cast<NodeBase_i*> (m_root.in ());
	GDS_ASSERT (node_base);
	return node_base->owner_tree ()->get_cached_server_tree ();
	//#UC END# *45F7E8A0038A**cpp*
}

template <class NodeType_>
void CatalogBase_i<NodeType_>::make_tree (GTree::Tree* server_tree, bool active_changeable) {
	//#UC START# *45F7E96601C5*
	TreeBase_var tree = new Tree<NodeType_, NodeDelegate> (active_changeable);
	tree->apply_server_tree (server_tree);
	m_root = dynamic_cast<NodeBase*> (tree->root ());
	//#UC END# *45F7E96601C5**cpp*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

template <class NodeType_>
const NodeBase* CatalogBase_i<NodeType_>::get_root () const {
	//#UC START# *45F6961F01A5_GET_ACCESSOR*
	GDS_ASSERT (m_root.ptr ());
	return m_root._sretn ();
	//#UC END# *45F6961F01A5_GET_ACCESSOR*
}

template <class NodeType_>
void CatalogBase_i<NodeType_>::set_root (NodeBase* root) const {
	//#UC START# *45F6961F01A5_SET_ACCESSOR*
	m_root = const_cast <NodeBase*> (root);
	//#UC END# *45F6961F01A5_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CatalogBase
template <class NodeType_>
NodeBase* CatalogBase_i<NodeType_>::get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/ {
	//#UC START# *45EEBA2C02C1_45F68EF8008C*
	DefaultNodeBase* root_node = dynamic_cast<DefaultNodeBase*> (m_root.in ());
	GDS_ASSERT (root_node);
	GTree::NodeIndexPath_var srv_path = DefaultNodeBase::adapter_path_to_srv (path);
	
	DefaultNodeBase_var result = root_node->find_node_by_path (srv_path.ptr ());

	if (result.is_nil ()) {
		throw NotFound ();
	}

	NodeBase* out_node_base = dynamic_cast <NodeBase*> (result._retn ());
	GDS_ASSERT (out_node_base);
	return out_node_base;
	//#UC END# *45EEBA2C02C1_45F68EF8008C**cpp*
}

// implemented method from CatalogBase
template <class NodeType_>
const GCI::IO::String& CatalogBase_i<NodeType_>::get_name () const {
	//#UC START# *45EEBA2C02CD_45F68EF8008C_GET*
	GDS_ASSERT (!m_name.is_nil ());
	return *m_name.ptr ();
	//#UC END# *45EEBA2C02CD_45F68EF8008C_GET*
}

template <class NodeType_>
GCI::IO::String& CatalogBase_i<NodeType_>::get_name () {
	return const_cast<GCI::IO::String&>(((const CatalogBase_i*)this)->get_name ());
}

template <class NodeType_>
void CatalogBase_i<NodeType_>::set_name (GCI::IO::String* name) {
	//#UC START# *45EEBA2C02CD_45F68EF8008C_SET*
	m_name = Core::IObject::_duplicate (name);
	//#UC END# *45EEBA2C02CD_45F68EF8008C_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

