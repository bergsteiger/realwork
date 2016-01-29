////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Manage/ManageFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Manage
//
// Интерфейсы и типы для менеджеров поисковых алгоритмов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Manage/ManageFactories.h"

namespace ContextSearch {
namespace Manage {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IRequestTransformer
bool IRequestTransformerFactoryManager::s_was_destroyed = false;

IRequestTransformerFactoryManager::IRequestTransformerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IRequestTransformerFactoryManager::~IRequestTransformerFactoryManager () {
	s_was_destroyed = true;
}

void IRequestTransformerFactoryManager::register_factory (
	IRequestTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IRequestTransformerFactoryManager::register_factory_i (
	IRequestTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ContextSearch::Manage::IRequestTransformerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IRequestTransformerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IRequestTransformerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IRequestTransformer* IRequestTransformerFactoryManager::make (Morpho::Def::INormalizer* normalizer) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ContextSearch::Manage::IRequestTransformerFactory");
	}
	IRequestTransformer* ret_ = m_single_active_factory->make (normalizer);
	GDS_ASSERT_MSG (ret_ != 0, ("ContextSearch::Manage::IRequestTransformerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ISynManager
bool ISynManagerFactoryManager::s_was_destroyed = false;

ISynManagerFactoryManager::ISynManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ISynManagerFactoryManager::~ISynManagerFactoryManager () {
	s_was_destroyed = true;
}

void ISynManagerFactoryManager::register_factory (
	ISynManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ISynManagerFactoryManager::register_factory_i (
	ISynManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ContextSearch::Manage::ISynManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ISynManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ISynManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ISynManager* ISynManagerFactoryManager::make (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ContextSearch::Manage::ISynManagerFactory");
	}
	ISynManager* ret_ = m_single_active_factory->make (normalizer, comm);
	GDS_ASSERT_MSG (ret_ != 0, ("ContextSearch::Manage::ISynManagerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IQuery
bool IQueryFactoryManager::s_was_destroyed = false;

IQueryFactoryManager::IQueryFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IQueryFactoryManager::~IQueryFactoryManager () {
	s_was_destroyed = true;
}

void IQueryFactoryManager::register_factory (
	IQueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IQueryFactoryManager::register_factory_i (
	IQueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ContextSearch::Manage::IQueryFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IQueryAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IQueryAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IQuery* IQueryFactoryManager::make (const Env& in, DBComm::IDBCommunicator* comm) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ContextSearch::Manage::IQueryFactory");
	}
	IQuery* ret_ = m_single_active_factory->make (in, comm);
	GDS_ASSERT_MSG (ret_ != 0, ("ContextSearch::Manage::IQueryFactory impl can't return zerro"));
	return ret_;
}
} // namespace Manage
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

