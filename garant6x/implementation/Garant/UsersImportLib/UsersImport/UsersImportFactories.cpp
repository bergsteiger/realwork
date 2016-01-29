////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::UsersImportLib::UsersImport
//
// интерфейсы уутилиты
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.h"

namespace UsersImport {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DataWriter
bool DataWriterFactoryManager::s_was_destroyed = false;

DataWriterFactoryManager::DataWriterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DataWriterFactoryManager::~DataWriterFactoryManager () {
	s_was_destroyed = true;
}

void DataWriterFactoryManager::register_factory (
	DataWriterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DataWriterFactoryManager::register_factory_i (
	DataWriterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"UsersImportLib::UsersImport::DataWriterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DataWriterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DataWriterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DataWriter* DataWriterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("UsersImportLib::UsersImport::DataWriterFactory");
	}
	DataWriter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("UsersImportLib::UsersImport::DataWriterFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DataParser
bool DataParserFactoryManager::s_was_destroyed = false;

DataParserFactoryManager::DataParserFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DataParserFactoryManager::~DataParserFactoryManager () {
	s_was_destroyed = true;
}

void DataParserFactoryManager::register_factory (
	DataParserAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DataParserFactoryManager::register_factory_i (
	DataParserAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"UsersImportLib::UsersImport::DataParserFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DataParserAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DataParserAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DataParser* DataParserFactoryManager::make (DataWriter* writer) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("UsersImportLib::UsersImport::DataParserFactory");
	}
	DataParser* ret_ = m_single_active_factory->make (writer);
	GDS_ASSERT_MSG (ret_ != 0, ("UsersImportLib::UsersImport::DataParserFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DataReader
bool DataReaderFactoryManager::s_was_destroyed = false;

DataReaderFactoryManager::DataReaderFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DataReaderFactoryManager::~DataReaderFactoryManager () {
	s_was_destroyed = true;
}

void DataReaderFactoryManager::register_factory (
	DataReaderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DataReaderFactoryManager::register_factory_i (
	DataReaderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"UsersImportLib::UsersImport::DataReaderFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DataReaderAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DataReaderAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DataReader* DataReaderFactoryManager::make (const std::string& source, DataParser* parser) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("UsersImportLib::UsersImport::DataReaderFactory");
	}
	DataReader* ret_ = m_single_active_factory->make (source, parser);
	GDS_ASSERT_MSG (ret_ != 0, ("UsersImportLib::UsersImport::DataReaderFactory impl can't return zerro"));
	return ret_;
}

DataReader* DataReaderFactoryManager::make (const std::string& source) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("UsersImportLib::UsersImport::DataReaderFactory");
	}
	DataReader* ret_ = m_single_active_factory->make (source);
	GDS_ASSERT_MSG (ret_ != 0, ("UsersImportLib::UsersImport::DataReaderFactory impl can't return zerro"));
	return ret_;
}
} // namespace UsersImport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

