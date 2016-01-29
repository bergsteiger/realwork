////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Search/SearchFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Search
//
// Интерфейсы и типы для алгоритмов контекстного поиска.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "boost/lexical_cast.hpp"
#include "boost/bind.hpp"
#include "shared/ContextSearch/Search/SearchFactories.h"

namespace ContextSearch {
namespace Search {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IWorker
bool IWorkerFactoryManager::s_was_destroyed = false;

IWorkerFactoryManager::IWorkerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IWorkerFactoryManager::~IWorkerFactoryManager () {
	s_was_destroyed = true;
}

void IWorkerFactoryManager::register_factory (
	IWorkerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IWorkerFactoryManager::register_factory_i (
	IWorkerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ContextSearch::Search::IWorkerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IWorkerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IWorkerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IWorker* IWorkerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ContextSearch::Search::IWorkerFactory");
	}
	IWorker* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ContextSearch::Search::IWorkerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IRequestView
bool IRequestViewFactoryManager::s_was_destroyed = false;

IRequestViewFactoryManager::IRequestViewFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IRequestViewFactoryManager::~IRequestViewFactoryManager () {
	s_was_destroyed = true;
}

void IRequestViewFactoryManager::register_factory (
	IRequestViewAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

IRequestViewFactory::KeySet* IRequestViewFactoryManager::keys () {
	Core::Aptr<IRequestViewFactory::KeySet> keys (new IRequestViewFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void IRequestViewFactoryManager::register_factory_i (
	IRequestViewAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ContextSearch::Search::IRequestViewFactory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IRequestViewAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IRequestViewAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IRequestView* IRequestViewFactoryManager::make (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer, AlgorithmSelector key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"ContextSearch::Search::IRequestViewFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make (comm, normalizer);
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IAlgorithm
bool IAlgorithmFactoryManager::s_was_destroyed = false;

IAlgorithmFactoryManager::IAlgorithmFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IAlgorithmFactoryManager::~IAlgorithmFactoryManager () {
	s_was_destroyed = true;
}

void IAlgorithmFactoryManager::register_factory (
	IAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

IAlgorithmFactory::KeySet* IAlgorithmFactoryManager::keys () {
	Core::Aptr<IAlgorithmFactory::KeySet> keys (new IAlgorithmFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void IAlgorithmFactoryManager::register_factory_i (
	IAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ContextSearch::Search::IAlgorithmFactory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IAlgorithmAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IAlgorithmAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IAlgorithm* IAlgorithmFactoryManager::make (IRequestView* view, DBComm::IProgress* progress, const AlgorithmProperties& properties, AlgorithmSelector key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"ContextSearch::Search::IAlgorithmFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make (view, progress, properties);
}
} // namespace Search
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

