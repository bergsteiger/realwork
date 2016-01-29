////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for ListEntryInfo
ListEntryInfo* ListEntryInfoFactory::make (
	const GblPilot::ListEntryInfo& info
	, const NodeBase* root
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ListEntryInfoFactoryManager::Singleton::instance ()->make (info, root);
}

ListEntryInfo* ListEntryInfoFactory::make (
	const GblPilot::ListEntryInfo& info
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ListEntryInfoFactoryManager::Singleton::instance ()->make (info);
}

// factory interface wrapper for DynList
DynList* DynListFactory::make (
	GblDocList::DocListTree* server_list
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DynListFactoryManager::Singleton::instance ()->make (server_list);
}

DynList* DynListFactory::make (
	GblPilot::LegalDocument* legal_document
	, const GblPilotQueryDef::Query& query
	, DynListType type
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DynListFactoryManager::Singleton::instance ()->make (legal_document, query, type);
}

DynList* DynListFactory::make (
	SpecialListKey key
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DynListFactoryManager::Singleton::instance ()->make (key);
}

// factory interface wrapper for SearchDynList
SearchDynList* SearchDynListFactory::make (
	GblPilot::SearchDocList* search_doc_list
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SearchDynListFactoryManager::Singleton::instance ()->make (search_doc_list);
}

// factory interface wrapper for DocListFactory
DocListFactory* DocListFactoryFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DocListFactoryFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for DynListNode
DynListNode* DynListNodeFactory::make (
	FakeFacetForFactory* owner_tree
	, const GTree::Node& snode
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DynListNodeFactoryManager::Singleton::instance ()->make (owner_tree, snode);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

