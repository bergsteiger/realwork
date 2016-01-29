////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PrefixTree_i::PrefixNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i.h"
// by <<uses>> dependencies
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PrefixNode_i::PrefixNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *460A73FD0213_BASE_INIT*
: RealNodeBase (owner_tree, snode)
, DefaultNodeBase (owner_tree)	
, NodeBase_i (owner_tree, snode)
, FilteredTreeNode_i (owner_tree, snode)
//#UC END# *460A73FD0213_BASE_INIT*
{
	//#UC START# *460A73FD0213_BODY*
	GblPilotDef::PrefixValue* pv = GblPilotDef::PrefixValue::_downcast(snode.value.in ());
	m_mask = pv->mask ();
	//#UC END# *460A73FD0213_BODY*
}

PrefixNode_i::~PrefixNode_i () {
	//#UC START# *460A7164034B_DESTR_BODY*
	//#UC END# *460A7164034B_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType PrefixNode_i::get_type () const {
	//#UC START# *45EEB9590224_460A7164034B_GET*
	return m_mask;
	//#UC END# *45EEB9590224_460A7164034B_GET*
}

void PrefixNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_460A7164034B_SET*
	throw ConstantModify ();
	//#UC END# *45EEB9590224_460A7164034B_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

