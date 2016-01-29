////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"

namespace GblAdapterLib {

template <class NodeType_>
class ListTree :
	virtual public Tree<NodeType_, DynListNodeDelegate>
{
	SET_OBJECT_COUNTER (ListTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit ListTree (bool active_changeable);

public:
	virtual ~ListTree ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	void add_block_position (GTree::NodePointer pointer, unsigned long position);

	void clear_block_positions ();

	unsigned long get_block_position (GTree::NodePointer pointer) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodePointerMap m_node_pointer_2_block_position;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from TreeBase
	virtual ViewBase* alloc_new_view ();

}; // class ListTree

} // namespace GblAdapterLib

#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTree.i.h"

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

