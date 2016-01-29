////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocalFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::NotifyLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/bind.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocalFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DataTransformer
bool DataTransformerFactoryManager::s_was_destroyed = false;

DataTransformerFactoryManager::DataTransformerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DataTransformerFactoryManager::~DataTransformerFactoryManager () {
	s_was_destroyed = true;
}

void DataTransformerFactoryManager::register_factory (
	DataTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

DataTransformerFactory::KeySet* DataTransformerFactoryManager::keys () {
	Core::Aptr<DataTransformerFactory::KeySet> keys (new DataTransformerFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void DataTransformerFactoryManager::register_factory_i (
	DataTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::NotifyLocal::DataTransformerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DataTransformerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DataTransformerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DataTransformer* DataTransformerFactoryManager::make (const char* key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"GblAdapterLib::NotifyLocal::DataTransformerFactory"
			, key
		);
	}
	return f->second.factory->make ();
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

