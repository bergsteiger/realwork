////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImplFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::VirtualElementsFuncionsImpl
//
// пакет функций для работы с виртуальными элементами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImplFactories.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for AddDependencyLocal
bool AddDependencyLocalFactoryManager::s_was_destroyed = false;

AddDependencyLocalFactoryManager::AddDependencyLocalFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

AddDependencyLocalFactoryManager::~AddDependencyLocalFactoryManager () {
	s_was_destroyed = true;
}

void AddDependencyLocalFactoryManager::register_factory (
	AddDependencyLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (factory, priority);
	
}

void AddDependencyLocalFactoryManager::register_factory_i (
	AddDependencyLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::VirtualElementsFuncionsImpl::AddDependencyLocalFactory"
			, factory->key().c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = AddDependencyLocalAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = AddDependencyLocalAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

AddDependencyLocal& AddDependencyLocalFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::VirtualElementsFuncionsImpl::AddDependencyLocalFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::VirtualElementsFuncionsImpl::AddDependencyLocalFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

