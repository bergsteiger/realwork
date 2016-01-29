////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/Params/ParamsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Params
//
// пакет для работы с параметрами приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/Params/ParamsFactories.h"

namespace Core {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ParamManager
bool ParamManagerFactoryManager::s_was_destroyed = false;

ParamManagerFactoryManager::ParamManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ParamManagerFactoryManager::~ParamManagerFactoryManager () {
	s_was_destroyed = true;
}

void ParamManagerFactoryManager::register_factory (
	ParamManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ParamManagerFactoryManager::register_factory_i (
	ParamManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"Core::Params::ParamManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ParamManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ParamManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ParamManager& ParamManagerFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("Core::Params::ParamManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("Core::Params::ParamManagerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

ParamManager* ParamManagerFactoryManager::make (const std::string& args) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("Core::Params::ParamManagerFactory");
	}
	ParamManager* ret_ = m_single_active_factory->make (args);
	GDS_ASSERT_MSG (ret_ != 0, ("Core::Params::ParamManagerFactory impl can't return zerro"));
	return ret_;
}
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

