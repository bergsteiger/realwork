////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase_NodeExpander.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::TreeBase::NodeExpander
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"

namespace GblAdapterLib {
class TreeBase;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TreeBase::NodeExpander::NodeExpander (bool all_expanded, bool expand_root)
//#UC START# *45F55B100186_BASE_INIT*
: m_all_expanded (all_expanded), m_expand_root (expand_root)
//#UC END# *45F55B100186_BASE_INIT*
{
	//#UC START# *45F55B100186_BODY*
	//#UC END# *45F55B100186_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void TreeBase::NodeExpander::each_func (GCL::StaticNode* static_node, int& dummy) const {
	//#UC START# *45F55B5A03B9*
	FlagNodeBase* flag_node = dynamic_cast<FlagNodeBase*> (static_node);

	if (flag_node && !m_all_expanded) {
		flag_node->set_flag (FM_SELECTION, false, false);
	}

	if (!static_node->has_children () || (static_node->is_root () && !m_expand_root)) {
		return;
	}

	if (flag_node) {
		flag_node->set_flag (FM_OPEN, m_all_expanded, true);
	}
	//#UC END# *45F55B5A03B9*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

