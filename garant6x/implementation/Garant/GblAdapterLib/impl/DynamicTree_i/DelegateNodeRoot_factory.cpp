////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeRoot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.h"

namespace GblAdapterLib {

DelegateNodeRoot_factory* DelegateNodeRoot_factory::s_instance = 0;

DelegateNodeRoot_factory::DelegateNodeRoot_factory () {
}

void DelegateNodeRoot_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* DelegateNodeRoot_factory::key () const {
	return "DelegateNodeRoot";
}

NodeBase* DelegateNodeRoot_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C545FE8E720000_45F6694A01B5_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C545FE8E720000_45F6694A01B5_IMPL*
}

NodeBase* DelegateNodeRoot_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C545FE8E720000_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C545FE8E720000_45FFF849002E_IMPL*
}

DelegateNodeRoot* DelegateNodeRootServantFactory::make () /*throw (CanNotFindData)*/ {
	if (DelegateNodeRoot_factory::s_instance) {
		return dynamic_cast<DelegateNodeRoot*>(DelegateNodeRoot_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::DelegateNodeRoot_factory");
	}
}

DelegateNodeRoot* DelegateNodeRootServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (DelegateNodeRoot_factory::s_instance) {
		return dynamic_cast<DelegateNodeRoot*>(DelegateNodeRoot_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::DelegateNodeRoot_factory");
	}
}

DelegateNodeRoot* DelegateNodeRootServantFactory::make (TreeBase* owner_tree) {
	//#UC START# *45FE8E72000045FE8E720000_45FE9032035B_IMPL*
	return new DelegateNodeRoot (owner_tree);
	//#UC END# *45FE8E72000045FE8E720000_45FE9032035B_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

