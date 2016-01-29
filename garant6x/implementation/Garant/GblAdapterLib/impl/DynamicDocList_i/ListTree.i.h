////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTree.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTreeView.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class NodeType_>
ListTree<NodeType_>::ListTree (bool active_changeable)
//#UC START# *4603AC6A0320_BASE_INIT*
	: TreeBase (active_changeable), Tree<NodeType_, DynListNodeDelegate> (active_changeable)
//#UC END# *4603AC6A0320_BASE_INIT**cpp*
{
	//#UC START# *4603AC6A0320_BODY*
	//#UC END# *4603AC6A0320_BODY**cpp*
}

template <class NodeType_>
ListTree<NodeType_>::~ListTree () {
	//#UC START# *4603A0B8004B_DESTR_BODY*
	try {
		GTree::Tree_var stree = this->get_server_tree ();
		if (!CORBA::is_nil (stree)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (stree);
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *4603A0B8004B_DESTR_BODY**cpp*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

template <class NodeType_>
void ListTree<NodeType_>::add_block_position (GTree::NodePointer pointer, unsigned long position) {
	//#UC START# *4603C5FF036D*
	m_node_pointer_2_block_position[pointer] = position;
	//#UC END# *4603C5FF036D**cpp*
}

template <class NodeType_>
void ListTree<NodeType_>::clear_block_positions () {
	//#UC START# *4603C5490003*
	m_node_pointer_2_block_position.clear ();
	//#UC END# *4603C5490003**cpp*
}

template <class NodeType_>
unsigned long ListTree<NodeType_>::get_block_position (GTree::NodePointer pointer) const {
	//#UC START# *4603C55B00DE*
	GDS_ASSERT (m_node_pointer_2_block_position.end () != m_node_pointer_2_block_position.find (pointer));
	return const_cast<ListTree<NodeType_>*> (this)->m_node_pointer_2_block_position [pointer];
	//#UC END# *4603C55B00DE**cpp*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from TreeBase
template <class NodeType_>
ViewBase* ListTree<NodeType_>::alloc_new_view () {
	//#UC START# *460127E400EA_4603A0B8004B*
	return new ListTreeView ();
	//#UC END# *460127E400EA_4603A0B8004B**cpp*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

