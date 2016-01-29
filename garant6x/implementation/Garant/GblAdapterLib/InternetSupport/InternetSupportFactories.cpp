////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupportFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// Возможности, доступные через интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupportFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for InternetSupport
bool InternetSupportFactoryManager::s_was_destroyed = false;

InternetSupportFactoryManager::InternetSupportFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

InternetSupportFactoryManager::~InternetSupportFactoryManager () {
	s_was_destroyed = true;
}

void InternetSupportFactoryManager::register_factory (
	InternetSupportAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void InternetSupportFactoryManager::register_factory_i (
	InternetSupportAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::InternetSupport::InternetSupportFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = InternetSupportAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = InternetSupportAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

InternetSupport* InternetSupportFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::InternetSupport::InternetSupportFactory");
	}
	InternetSupport* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::InternetSupport::InternetSupportFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DecisionsArchiveSupport
bool DecisionsArchiveSupportFactoryManager::s_was_destroyed = false;

DecisionsArchiveSupportFactoryManager::DecisionsArchiveSupportFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DecisionsArchiveSupportFactoryManager::~DecisionsArchiveSupportFactoryManager () {
	s_was_destroyed = true;
}

void DecisionsArchiveSupportFactoryManager::register_factory (
	DecisionsArchiveSupportAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DecisionsArchiveSupportFactoryManager::register_factory_i (
	DecisionsArchiveSupportAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::InternetSupport::DecisionsArchiveSupportFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DecisionsArchiveSupportAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DecisionsArchiveSupportAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DecisionsArchiveSupport* DecisionsArchiveSupportFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::InternetSupport::DecisionsArchiveSupportFactory");
	}
	DecisionsArchiveSupport* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::InternetSupport::DecisionsArchiveSupportFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

