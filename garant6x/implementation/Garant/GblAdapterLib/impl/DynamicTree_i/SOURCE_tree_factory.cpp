////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SOURCE_tree_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::SOURCE_tree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SOURCE_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SOURCE_tree.h"

namespace GblAdapterLib {

SOURCE_tree_factory::SOURCE_tree_factory () {
}

void SOURCE_tree_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
}

const char* SOURCE_tree_factory::key () const {
	return AT_SOURCE;
}

NodeBase* SOURCE_tree_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C54F17DD4F001A_45F6694A01B5_IMPL*
	return make_tree_and_root (this->key ());
	//#UC END# *45EEB95901C54F17DD4F001A_45F6694A01B5_IMPL*
}

NodeBase* SOURCE_tree_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C54F17DD4F001A_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0; // make_from_owner_tree (owner_tree, snode);
	//#UC END# *45EEB95901C54F17DD4F001A_45FFF849002E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

