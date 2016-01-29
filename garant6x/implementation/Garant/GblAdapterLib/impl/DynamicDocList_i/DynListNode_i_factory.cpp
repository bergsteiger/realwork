////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"

namespace GblAdapterLib {

DynListNode_i_factory* DynListNode_i_factory::s_instance = 0;

DynListNode_i_factory::DynListNode_i_factory () {
}

void DynListNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DynListNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* DynListNode_i_factory::key () const {
	return "DynListNode_i";
}

DynListNode* DynListNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *53CF8873039B460780FC02D6_53CFADB9034E_IMPL*
	return new DynListNode_i (dynamic_cast<TreeBase*> (owner_tree), snode);
	//#UC END# *53CF8873039B460780FC02D6_53CFADB9034E_IMPL*
}

DynListNode_i* DynListNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (DynListNode_i_factory::s_instance) {
		return dynamic_cast<DynListNode_i*>(DynListNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList_i::DynListNode_i_factory");
	}
}

DynListNode_i* DynListNode_iServantFactory::make_servant () {
	//#UC START# *460780FC02D6460780FC02D6_4608DDE7033F_IMPL*
	return new DynListNode_i ();
	//#UC END# *460780FC02D6460780FC02D6_4608DDE7033F_IMPL*
}

DynListNode_i* DynListNode_iServantFactory::make_servant2 (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *460780FC02D6460780FC02D6_4608DDF5017A_IMPL*
	return new DynListNode_i (owner_tree, snode);
	//#UC END# *460780FC02D6460780FC02D6_4608DDF5017A_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

