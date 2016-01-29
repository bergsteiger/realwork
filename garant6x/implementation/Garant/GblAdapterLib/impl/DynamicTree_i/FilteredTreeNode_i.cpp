////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FilteredTreeNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"

//#UC START# *4DB15A950379_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i_factory.h"
//#UC END# *4DB15A950379_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4DB15A950379*
NodeBase* make_filtered_tree_and_root (const char* key) {
	TreeBase_var tree = NodeServerTree<FilteredTreeNode_i>::make_tree (key);
	return tree.is_nil () ? 0 : dynamic_cast<NodeBase*> (tree->root ()); 
}
//#UC END# *4DB15A950379*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FilteredTreeNode_i::FilteredTreeNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *4DB162C303D3_BASE_INIT*
: RealNodeBase (owner_tree, snode)
, DefaultNodeBase (owner_tree)	
, NodeBase_i (owner_tree, snode)
//#UC END# *4DB162C303D3_BASE_INIT*
{
	//#UC START# *4DB162C303D3_BODY*
	GblPilotDef::IndexNodeValue* inv = GblPilotDef::IndexNodeValue::_downcast (snode.value.in ());
	m_has_filtered_children = inv->has_filtered_children ();
	//#UC END# *4DB162C303D3_BODY*
}

FilteredTreeNode_i::~FilteredTreeNode_i () {
	//#UC START# *4DB15A950379_DESTR_BODY*
	//#UC END# *4DB15A950379_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
// признак того что нода соджержит отфильтрованных детей
bool FilteredTreeNode_i::has_filtered_children () const {
	//#UC START# *45EEB95901ED_4DB15A950379*
	return m_has_filtered_children;
	//#UC END# *45EEB95901ED_4DB15A950379*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

