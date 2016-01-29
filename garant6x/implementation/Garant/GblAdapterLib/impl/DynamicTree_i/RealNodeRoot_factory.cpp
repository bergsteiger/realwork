////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeRoot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.h"

namespace GblAdapterLib {

RealNodeRoot_factory* RealNodeRoot_factory::s_instance = 0;

RealNodeRoot_factory::RealNodeRoot_factory () {
}

void RealNodeRoot_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* RealNodeRoot_factory::key () const {
	return "RealNodeRoot";
}

NodeBase* RealNodeRoot_factory::make () /*throw (CanNotFindData)*/ {
	RealNodeRoot_var ret = new RealNodeRoot ();
	return ret._retn ();
}

NodeBase* RealNodeRoot_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	RealNodeRoot_var ret = new RealNodeRoot (owner_tree, snode);
	return ret._retn ();
}

RealNodeRoot* RealNodeRootServantFactory::make () /*throw (CanNotFindData)*/ {
	if (RealNodeRoot_factory::s_instance) {
		return dynamic_cast<RealNodeRoot*>(RealNodeRoot_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::RealNodeRoot_factory");
	}
}

RealNodeRoot* RealNodeRootServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (RealNodeRoot_factory::s_instance) {
		return dynamic_cast<RealNodeRoot*>(RealNodeRoot_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::RealNodeRoot_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

