////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BaseSearchPanesTree_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::BaseSearchPanesTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BaseSearchPanesTree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BaseSearchPanesTree.h"

namespace GblAdapterLib {

BaseSearchPanesTree_factory::BaseSearchPanesTree_factory () {
}

void BaseSearchPanesTree_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
}

const char* BaseSearchPanesTree_factory::key () const {
	return AT_BASE_SEARCH_PANES;
}

NodeBase* BaseSearchPanesTree_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C54DDB5B54036C_45F6694A01B5_IMPL*
	return make_tree_and_root (this->key ());
	//#UC END# *45EEB95901C54DDB5B54036C_45F6694A01B5_IMPL*
}

NodeBase* BaseSearchPanesTree_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C54DDB5B54036C_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C54DDB5B54036C_45FFF849002E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

