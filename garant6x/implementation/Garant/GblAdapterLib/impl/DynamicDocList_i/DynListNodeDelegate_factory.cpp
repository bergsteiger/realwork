////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"

namespace GblAdapterLib {

DynListNodeDelegate_factory* DynListNodeDelegate_factory::s_instance = 0;

DynListNodeDelegate_factory::DynListNodeDelegate_factory () {
}

void DynListNodeDelegate_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DynListNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* DynListNodeDelegate_factory::key () const {
	return "DynListNodeDelegate";
}

DynListNode* DynListNodeDelegate_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *53CF8873039B5464C77601DC_53CFADB9034E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *53CF8873039B5464C77601DC_53CFADB9034E_IMPL*
}

DynListNodeDelegate* DynListNodeDelegateServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (DynListNodeDelegate_factory::s_instance) {
		return dynamic_cast<DynListNodeDelegate*>(DynListNodeDelegate_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList_i::DynListNodeDelegate_factory");
	}
}

DynListNodeDelegate* DynListNodeDelegateServantFactory::make (TreeBase* owner_tree) {
	//#UC START# *5464C77601DC5464C77601DC_5464C79400FD_IMPL*
	return new DynListNodeDelegate (owner_tree);
	//#UC END# *5464C77601DC5464C77601DC_5464C79400FD_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

