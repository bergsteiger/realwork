////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::TemplateFunctions
//
// пакет интерфейсов для работы с встроенными функциями генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/bind.hpp"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace TemplateFunctions {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for InternalStereotypeFunction
bool InternalStereotypeFunctionFactoryManager::s_was_destroyed = false;

InternalStereotypeFunctionFactoryManager::InternalStereotypeFunctionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

InternalStereotypeFunctionFactoryManager::~InternalStereotypeFunctionFactoryManager () {
	s_was_destroyed = true;
}

void InternalStereotypeFunctionFactoryManager::register_factory (
	InternalStereotypeFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

InternalStereotypeFunctionFactory::KeySet* InternalStereotypeFunctionFactoryManager::keys () {
	Core::Aptr<InternalStereotypeFunctionFactory::KeySet> keys (new InternalStereotypeFunctionFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void InternalStereotypeFunctionFactoryManager::register_factory_i (
	InternalStereotypeFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::TemplateFunctions::InternalStereotypeFunctionFactory"
			, factory->key().c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = InternalStereotypeFunctionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = InternalStereotypeFunctionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

InternalStereotypeFunction& InternalStereotypeFunctionFactoryManager::make (const std::string& key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	GUARD(m_mutex_for_make);
	CachedObjectsForMake::iterator f = m_cached_objects_for_make.find (ObjectCreationIdForMake(key));
	if (f == m_cached_objects_for_make.end()) {
		FactoryMap::iterator f_fct = m_factories_map.find (key);
		if (f_fct == m_factories_map.end()) {
			throw Core::Root::UnknownFactoryKey (
				"MDAModel::TemplateFunctions::BaseFunctionFactory"
				, key
			);
		}
		f = m_cached_objects_for_make.insert (
			CachedObjectsForMake::value_type(
				ObjectCreationIdForMake(key)
				, f_fct->second.factory->make ()
			)
		).first;
		m_cached_objects_index_for_make.insert (
			CachedObjectsIndexForMake::value_type (
				f->second.in()
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("MDAModel::TemplateFunctions::BaseFunctionFactory impl can't return zerro"));
	return *f->second;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for InternalFunction
bool InternalFunctionFactoryManager::s_was_destroyed = false;

InternalFunctionFactoryManager::InternalFunctionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

InternalFunctionFactoryManager::~InternalFunctionFactoryManager () {
	s_was_destroyed = true;
}

void InternalFunctionFactoryManager::register_factory (
	InternalFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

InternalFunctionFactory::KeySet* InternalFunctionFactoryManager::keys () {
	Core::Aptr<InternalFunctionFactory::KeySet> keys (new InternalFunctionFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void InternalFunctionFactoryManager::register_factory_i (
	InternalFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::TemplateFunctions::InternalFunctionFactory"
			, factory->key().c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = InternalFunctionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = InternalFunctionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

InternalFunction& InternalFunctionFactoryManager::make (const std::string& key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	GUARD(m_mutex_for_make);
	CachedObjectsForMake::iterator f = m_cached_objects_for_make.find (ObjectCreationIdForMake(key));
	if (f == m_cached_objects_for_make.end()) {
		FactoryMap::iterator f_fct = m_factories_map.find (key);
		if (f_fct == m_factories_map.end()) {
			throw Core::Root::UnknownFactoryKey (
				"MDAModel::TemplateFunctions::BaseFunctionFactory"
				, key
			);
		}
		f = m_cached_objects_for_make.insert (
			CachedObjectsForMake::value_type(
				ObjectCreationIdForMake(key)
				, f_fct->second.factory->make ()
			)
		).first;
		m_cached_objects_index_for_make.insert (
			CachedObjectsIndexForMake::value_type (
				f->second.in()
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("MDAModel::TemplateFunctions::BaseFunctionFactory impl can't return zerro"));
	return *f->second;
}
} // namespace TemplateFunctions

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

