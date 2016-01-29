////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Search/Search.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Search
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for QueryPhoneNumberAttribute
QueryPhoneNumberAttribute* QueryPhoneNumberAttributeFactory::make (
	AttributeTag_const attribute_tag
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return QueryPhoneNumberAttributeFactoryManager::Singleton::instance ()->make (attribute_tag);
}


QueryNodeValue::QueryNodeValue (NodeBase* node_, QueryLogicOperation operation_)
//#UC START# *46151C4A0238_INIT_CTOR_BASE_INIT*
	: node (Core::IObject::_duplicate (node_)), operation (operation_)
//#UC END# *46151C4A0238_INIT_CTOR_BASE_INIT*
{
	//#UC START# *46151C4A0238_CTOR_BODY*
	//#UC END# *46151C4A0238_CTOR_BODY*
}

// конструктор по умолчанию
QueryNodeValue::QueryNodeValue ()
//#UC START# *473064CF02EE_INIT_CTOR_BASE_INIT*
//#UC END# *473064CF02EE_INIT_CTOR_BASE_INIT*
{
	//#UC START# *473064CF02EE_CTOR_BODY*
	//#UC END# *473064CF02EE_CTOR_BODY*
}

ContextValue::ContextValue (GCI::IO::String* context_)
//#UC START# *461A637E0017_INIT_CTOR_BASE_INIT*
	:	context (Core::IObject::_duplicate (context_))
//#UC END# *461A637E0017_INIT_CTOR_BASE_INIT*
{
	//#UC START# *461A637E0017_CTOR_BODY*
		//#UC END# *461A637E0017_CTOR_BODY*
}

// конструктор по умолчанию
ContextValue::ContextValue ()
//#UC START# *4730657502FD_INIT_CTOR_BASE_INIT*
//#UC END# *4730657502FD_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4730657502FD_CTOR_BODY*
	//#UC END# *4730657502FD_CTOR_BODY*
}
DateValue::DateValue (const Date& from_, const Date& to_, QueryLogicOperation operation_)
//#UC START# *45EEE5C6012B_INIT_CTOR_BASE_INIT*
	: operation (operation_), from (from_), to (to_)
//#UC END# *45EEE5C6012B_INIT_CTOR_BASE_INIT*
{
	//#UC START# *45EEE5C6012B_INIT_CTOR*
	//#UC END# *45EEE5C6012B_INIT_CTOR*
}

// конструктор по умолчанию
DateValue::DateValue ()
//#UC START# *47306DD6030D_INIT_CTOR_BASE_INIT*
//#UC END# *47306DD6030D_INIT_CTOR_BASE_INIT*
{
	//#UC START# *47306DD6030D_CTOR_BODY*
	//#UC END# *47306DD6030D_CTOR_BODY*
}
// factory interface wrapper for QueryDateAttribute
QueryDateAttribute* QueryDateAttributeFactory::make (
	AttributeTag_const attribute_tag
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return QueryDateAttributeFactoryManager::Singleton::instance ()->make (attribute_tag);
}

// factory interface wrapper for QueryNodeAttribute
QueryNodeAttribute* QueryNodeAttributeFactory::make (
	AttributeTag_const attribute_tag
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return QueryNodeAttributeFactoryManager::Singleton::instance ()->make (attribute_tag);
}

// factory interface wrapper for QueryContextAttribute
QueryContextAttribute* QueryContextAttributeFactory::make (
	AttributeTag_const attribute_tag
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return QueryContextAttributeFactoryManager::Singleton::instance ()->make (attribute_tag);
}

// factory interface wrapper for AttributeInfo
AttributeInfo* AttributeInfoFactory::make (
	AttributeTag_const tag
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return AttributeInfoFactoryManager::Singleton::instance ()->make (tag);
}


const char* NoDefaultValue::uid () const /*throw ()*/ {
	return "69B6D1D4-7DBB-40EE-8FDE-9675D33D230B";
}

const char* NoDefaultValue::what () const throw () {
	//#UC START# *45F1161402AB_WHAT_IMPL*
	return "NoDefaultValue (Для атрибута нет значения по умолчанию)";
	//#UC END# *45F1161402AB_WHAT_IMPL*
}

// factory interface wrapper for Query
Query* QueryFactory::make (
	QueryType type
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return QueryFactoryManager::Singleton::instance ()->make (type);
}

// factory interface wrapper for Search
Search* SearchFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SearchFactoryManager::Singleton::instance ()->make ();
}


const char* QueryNotExecuted::uid () const /*throw ()*/ {
	return "7EA1017A-32F2-4EAC-AF81-62300653DE90";
}

const char* QueryNotExecuted::what () const throw () {
	//#UC START# *461CF26C02FA_WHAT_IMPL*
	return "QueryNotExecuted ()";
	//#UC END# *461CF26C02FA_WHAT_IMPL*
}

// factory interface wrapper for QueryCreator
QueryCreator* QueryCreatorFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return QueryCreatorFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for FiltersQuery
FiltersQuery* FiltersQueryFactory::make (
	FilterFromQuery* filter
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FiltersQueryFactoryManager::Singleton::instance ()->make (filter);
}

// factory interface wrapper for AdapterFiltersQuery
AdapterFiltersQuery* AdapterFiltersQueryFactory::make (
	QueryType type
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return AdapterFiltersQueryFactoryManager::Singleton::instance ()->make (type);
}

// factory interface wrapper for FullAttributeInfo
FullAttributeInfo* FullAttributeInfoFactory::make (
	const GblPilotQueryDef::FullAttributeInfo& full_info
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FullAttributeInfoFactoryManager::Singleton::instance ()->make (full_info);
}

// factory interface wrapper for QueryCardInfo
QueryCardInfo* QueryCardInfoFactory::create (const char* key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return QueryCardInfoFactoryManager::Singleton::instance ()->create (key);
}


QueryCardInfoFactory::KeySet* QueryCardInfoFactory::keys () {
	return QueryCardInfoFactoryManager::keys ();
}

// factory interface wrapper for AttributesHelper
AttributesHelper* AttributesHelperFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return AttributesHelperFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

