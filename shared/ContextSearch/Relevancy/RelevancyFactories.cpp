////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Relevancy/RelevancyFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Relevancy
//
// Интерфейсы и типы для алгоритма вычисления релевантности.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "boost/lexical_cast.hpp"
#include "boost/bind.hpp"
#include "shared/ContextSearch/Relevancy/RelevancyFactories.h"

namespace ContextSearch {
namespace Relevancy {

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
			"ContextSearch::Relevancy::IAlgorithmFactory"
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

IAlgorithm* IAlgorithmFactoryManager::make (const Data& req_data, const AlgorithmProperties& properties, AlgorithmSelector key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"ContextSearch::Relevancy::IAlgorithmFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make (req_data, properties);
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IBlockAlgorithm
bool IBlockAlgorithmFactoryManager::s_was_destroyed = false;

IBlockAlgorithmFactoryManager::IBlockAlgorithmFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IBlockAlgorithmFactoryManager::~IBlockAlgorithmFactoryManager () {
	s_was_destroyed = true;
}

void IBlockAlgorithmFactoryManager::register_factory (
	IBlockAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IBlockAlgorithmFactoryManager::register_factory_i (
	IBlockAlgorithmAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ContextSearch::Relevancy::IBlockAlgorithmFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IBlockAlgorithmAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IBlockAlgorithmAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IBlockAlgorithm* IBlockAlgorithmFactoryManager::make (const Data& req_data, const AlgorithmProperties& properties) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ContextSearch::Relevancy::IBlockAlgorithmFactory");
	}
	IBlockAlgorithm* ret_ = m_single_active_factory->make (req_data, properties);
	GDS_ASSERT_MSG (ret_ != 0, ("ContextSearch::Relevancy::IBlockAlgorithmFactory impl can't return zerro"));
	return ret_;
}
} // namespace Relevancy
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

