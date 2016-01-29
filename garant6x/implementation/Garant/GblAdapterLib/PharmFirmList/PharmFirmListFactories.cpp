////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmListFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// Список фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmListFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PharmFirmListEntry
bool PharmFirmListEntryFactoryManager::s_was_destroyed = false;

PharmFirmListEntryFactoryManager::PharmFirmListEntryFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PharmFirmListEntryFactoryManager::~PharmFirmListEntryFactoryManager () {
	s_was_destroyed = true;
}

void PharmFirmListEntryFactoryManager::register_factory (
	PharmFirmListEntryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PharmFirmListEntryFactoryManager::register_factory_i (
	PharmFirmListEntryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::PharmFirmList::PharmFirmListEntryFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PharmFirmListEntryAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PharmFirmListEntryAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PharmFirmListEntry* PharmFirmListEntryFactoryManager::make (GCD::ObjectID id) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PharmFirmList::PharmFirmListEntryFactory");
	}
	PharmFirmListEntry* ret_ = m_single_active_factory->make (id);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::PharmFirmList::PharmFirmListEntryFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

