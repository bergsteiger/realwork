////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PrefixTree
//
// Дерево для Вид правовой информации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTreeFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for PrefixNode
PrefixNode* PrefixNodeFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, CanNotFindData)*/ {
	return PrefixNodeFactoryManager::Singleton::instance ()->make ();
}

PrefixNode* PrefixNodeFactory::make (
	FakeFacetForFactory* owner_tree
	, const GTree::Node& snode
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PrefixNodeFactoryManager::Singleton::instance ()->make (owner_tree, snode);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

