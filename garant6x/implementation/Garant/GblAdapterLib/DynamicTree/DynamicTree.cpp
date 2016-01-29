////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for SortFilter
SortFilter* SortFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SortFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for TrimFilter
TrimFilter* TrimFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return TrimFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for LayerFilter
LayerFilter* LayerFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return LayerFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for FindIterator
FindIterator* FindIteratorFactory::make (
	GTree::FindIterator* iterator
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FindIteratorFactoryManager::Singleton::instance ()->make (iterator);
}


const char* NoEntity::uid () const /*throw ()*/ {
	return "AEAD1A12-C9B8-4BC7-83BE-3879BF08050F";
}

const char* NoEntity::what () const throw () {
	//#UC START# *45EECBE20280_WHAT_IMPL*
	return "NoEntity (генерируется при попытке получить сущность на ноде которая ее не содержит )";
	//#UC END# *45EECBE20280_WHAT_IMPL*
}


const char* NotFound::uid () const /*throw ()*/ {
	return "C77F1E09-8D6D-4A2A-B273-9E81772DD261";
}

const char* NotFound::what () const throw () {
	//#UC START# *45EECBE20290_WHAT_IMPL*
	return "NotFound (возвращается если get_visible_delta не может найти ноду)";
	//#UC END# *45EECBE20290_WHAT_IMPL*
}

// factory interface wrapper for NodesClipboard
NodesClipboard* NodesClipboardFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return NodesClipboardFactoryManager::Singleton::instance ()->make ();
}

NodesClipboard* NodesClipboardFactory::make (
	GTree::NodeHolder* node_holder
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return NodesClipboardFactoryManager::Singleton::instance ()->make (node_holder);
}

// factory interface wrapper for NodeBase
NodeBase* NodeBaseFactory::make (const char* key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed, CanNotFindData)*/ {
	return NodeBaseFactoryManager::Singleton::instance ()->make (key);
}

NodeBase* NodeBaseFactory::make (
	FakeFacetForFactory* owner_tree
	, const GTree::Node& snode
	, const char* key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return NodeBaseFactoryManager::Singleton::instance ()->make (owner_tree, snode, key);
}


NodeBaseFactory::KeySet* NodeBaseFactory::keys () {
	return NodeBaseFactoryManager::keys ();
}

// factory interface wrapper for NodeIterator
NodeIterator* NodeIteratorFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return NodeIteratorFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for TrimLeafFilter
TrimLeafFilter* TrimLeafFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return TrimLeafFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for CountryFilter
CountryFilter* CountryFilterFactory::make (
	const NodeBase* country
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CountryFilterFactoryManager::Singleton::instance ()->make (country);
}

CountryFilter* CountryFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CountryFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for CutToLeafCountFilter
CutToLeafCountFilter* CutToLeafCountFilterFactory::make (
	unsigned long leaf_count
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CutToLeafCountFilterFactoryManager::Singleton::instance ()->make (leaf_count);
}

CutToLeafCountFilter* CutToLeafCountFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CutToLeafCountFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for BlocksFilter
BlocksFilter* BlocksFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return BlocksFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for InpharmFilter
InpharmFilter* InpharmFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return InpharmFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for VariantsForDocFilter
VariantsForDocFilter* VariantsForDocFilterFactory::make (
	unsigned long doc_id
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return VariantsForDocFilterFactoryManager::Singleton::instance ()->make (doc_id);
}

VariantsForDocFilter* VariantsForDocFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return VariantsForDocFilterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for ContextFilter
ContextFilter* ContextFilterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ContextFilterFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

