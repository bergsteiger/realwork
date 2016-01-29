////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// Интерфейсы для взаимодействия с отделом Пащака
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/bind.hpp"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapterLib {
namespace HCInterfaces {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for OnlineData
bool OnlineDataFactoryManager::s_was_destroyed = false;

OnlineDataFactoryManager::OnlineDataFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

OnlineDataFactoryManager::~OnlineDataFactoryManager () {
	s_was_destroyed = true;
}

void OnlineDataFactoryManager::register_factory (
	OnlineDataAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

OnlineDataFactory::KeySet* OnlineDataFactoryManager::keys () {
	Core::Aptr<OnlineDataFactory::KeySet> keys (new OnlineDataFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void OnlineDataFactoryManager::register_factory_i (
	OnlineDataAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"HCAdapterLib::HCInterfaces::OnlineDataFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = OnlineDataAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = OnlineDataAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

OnlineData* OnlineDataFactoryManager::make (GCI::IO::Stream* xml_stream, const GblConsultingDef::ConsultationID& consultation_id, const char* key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"HCAdapterLib::HCInterfaces::OnlineDataFactory"
			, key
		);
	}
	return f->second.factory->make (xml_stream, consultation_id);
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for BusinessLogicLifeCycle
bool BusinessLogicLifeCycleFactoryManager::s_was_destroyed = false;

BusinessLogicLifeCycleFactoryManager::BusinessLogicLifeCycleFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BusinessLogicLifeCycleFactoryManager::~BusinessLogicLifeCycleFactoryManager () {
	s_was_destroyed = true;
}

void BusinessLogicLifeCycleFactoryManager::register_factory (
	BusinessLogicLifeCycleAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BusinessLogicLifeCycleFactoryManager::register_factory_i (
	BusinessLogicLifeCycleAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"HCAdapterLib::HCInterfaces::BusinessLogicLifeCycleFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BusinessLogicLifeCycleAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BusinessLogicLifeCycleAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

BusinessLogicLifeCycle* BusinessLogicLifeCycleFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("HCAdapterLib::HCInterfaces::BusinessLogicLifeCycleFactory");
	}
	BusinessLogicLifeCycle* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("HCAdapterLib::HCInterfaces::BusinessLogicLifeCycleFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ConsultingRequests
bool ConsultingRequestsFactoryManager::s_was_destroyed = false;

ConsultingRequestsFactoryManager::ConsultingRequestsFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ConsultingRequestsFactoryManager::~ConsultingRequestsFactoryManager () {
	s_was_destroyed = true;
}

void ConsultingRequestsFactoryManager::register_factory (
	ConsultingRequestsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ConsultingRequestsFactoryManager::register_factory_i (
	ConsultingRequestsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"HCAdapterLib::HCInterfaces::ConsultingRequestsFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ConsultingRequestsAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ConsultingRequestsAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ConsultingRequests* ConsultingRequestsFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("HCAdapterLib::HCInterfaces::ConsultingRequestsFactory");
	}
	ConsultingRequests* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("HCAdapterLib::HCInterfaces::ConsultingRequestsFactory impl can't return zerro"));
	return ret_;
}
} // namespace HCInterfaces
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

