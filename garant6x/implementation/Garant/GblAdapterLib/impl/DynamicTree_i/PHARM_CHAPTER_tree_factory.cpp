////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_CHAPTER_tree_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PHARM_CHAPTER_tree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_CHAPTER_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_CHAPTER_tree.h"

namespace GblAdapterLib {

PHARM_CHAPTER_tree_factory::PHARM_CHAPTER_tree_factory () {
}

void PHARM_CHAPTER_tree_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
}

const char* PHARM_CHAPTER_tree_factory::key () const {
	return AT_PHARM_CHAPTER;
}

NodeBase* PHARM_CHAPTER_tree_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C547D676250100_45F6694A01B5_IMPL*
	return make_tree_and_root (this->key ());
	//#UC END# *45EEB95901C547D676250100_45F6694A01B5_IMPL*
}

NodeBase* PHARM_CHAPTER_tree_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C547D676250100_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0; // make_from_owner_tree (owner_tree, snode);
	//#UC END# *45EEB95901C547D676250100_45FFF849002E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

