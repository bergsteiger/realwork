////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Complect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/ComplectFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for ComplectInfoNode
ComplectInfoNode* ComplectInfoNodeFactory::make (
	FakeFacetForFactory* owner_tree
	, const GTree::Node& snode
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ComplectInfoNodeFactoryManager::Singleton::instance ()->make (owner_tree, snode);
}

// factory interface wrapper for ComplectInfo
ComplectInfo* ComplectInfoFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ComplectInfoFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

