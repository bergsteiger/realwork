////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocalFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypesLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocalFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DataReadingStream
bool DataReadingStreamFactoryManager::s_was_destroyed = false;

DataReadingStreamFactoryManager::DataReadingStreamFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DataReadingStreamFactoryManager::~DataReadingStreamFactoryManager () {
	s_was_destroyed = true;
}

void DataReadingStreamFactoryManager::register_factory (
	DataReadingStreamAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DataReadingStreamFactoryManager::register_factory_i (
	DataReadingStreamAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::BaseTypesLocal::DataReadingStreamFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DataReadingStreamAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DataReadingStreamAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DataReadingStream* DataReadingStreamFactoryManager::make (GslDataPipe::DataReading* data_reading) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypesLocal::DataReadingStreamFactory");
	}
	DataReadingStream* ret_ = m_single_active_factory->make (data_reading);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypesLocal::DataReadingStreamFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MemoryStream
bool MemoryStreamFactoryManager::s_was_destroyed = false;

MemoryStreamFactoryManager::MemoryStreamFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MemoryStreamFactoryManager::~MemoryStreamFactoryManager () {
	s_was_destroyed = true;
}

void MemoryStreamFactoryManager::register_factory (
	MemoryStreamAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MemoryStreamFactoryManager::register_factory_i (
	MemoryStreamAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::BaseTypesLocal::MemoryStreamFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MemoryStreamAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MemoryStreamAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MemoryStream* MemoryStreamFactoryManager::make (const OctetSeq& data, bool with_copy) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypesLocal::MemoryStreamFactory");
	}
	MemoryStream* ret_ = m_single_active_factory->make (data, with_copy);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypesLocal::MemoryStreamFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

