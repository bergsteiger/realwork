////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_ORG_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ANNO_ORG
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_ORG_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_ORG.h"

namespace GblAdapterLib {

ANNO_ORG_factory::ANNO_ORG_factory () {
}

void ANNO_ORG_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
}

const char* ANNO_ORG_factory::key () const {
	return AT_ANNO_ORG;
}

NodeBase* ANNO_ORG_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C5475E7A6303D8_45F6694A01B5_IMPL*
	return make_tree_and_root (this->key ());
	//#UC END# *45EEB95901C5475E7A6303D8_45F6694A01B5_IMPL*
}

NodeBase* ANNO_ORG_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C5475E7A6303D8_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0; // make_from_owner_tree (owner_tree, snode);
	//#UC END# *45EEB95901C5475E7A6303D8_45FFF849002E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

