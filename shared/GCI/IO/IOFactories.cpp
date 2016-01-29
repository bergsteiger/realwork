////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/IO/IOFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// пакет интерфейсов ввода-вывода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"

namespace GCI {
namespace IO {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for String
bool StringFactoryManager::s_was_destroyed = false;

StringFactoryManager::StringFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

StringFactoryManager::~StringFactoryManager () {
	s_was_destroyed = true;
}

void StringFactoryManager::register_factory (
	StringAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void StringFactoryManager::register_factory_i (
	StringAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::IO::StringFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = StringAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = StringAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

String* StringFactoryManager::make (const char* str) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::IO::StringFactory");
	}
	String* ret_ = m_single_active_factory->make (str);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::IO::StringFactory impl can't return zerro"));
	return ret_;
}

String* StringFactoryManager::create (const char* str, short code_page) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::IO::StringFactory");
	}
	String* ret_ = m_single_active_factory->create (str, code_page);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::IO::StringFactory impl can't return zerro"));
	return ret_;
}

String* StringFactoryManager::take (char* str, short code_page) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::IO::StringFactory");
	}
	String* ret_ = m_single_active_factory->take (str, code_page);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::IO::StringFactory impl can't return zerro"));
	return ret_;
}

String* StringFactoryManager::alloc (unsigned long maximum) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::IO::StringFactory");
	}
	String* ret_ = m_single_active_factory->alloc (maximum);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::IO::StringFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Stream
bool StreamFactoryManager::s_was_destroyed = false;

StreamFactoryManager::StreamFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

StreamFactoryManager::~StreamFactoryManager () {
	s_was_destroyed = true;
}

void StreamFactoryManager::register_factory (
	StreamAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void StreamFactoryManager::register_factory_i (
	StreamAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::IO::StreamFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = StreamAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = StreamAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Stream* StreamFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::IO::StreamFactory");
	}
	Stream* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::IO::StreamFactory impl can't return zerro"));
	return ret_;
}

Stream* StreamFactoryManager::make (const char* path) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::IO::StreamFactory");
	}
	Stream* ret_ = m_single_active_factory->make (path);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::IO::StreamFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for BinaryString
bool BinaryStringFactoryManager::s_was_destroyed = false;

BinaryStringFactoryManager::BinaryStringFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BinaryStringFactoryManager::~BinaryStringFactoryManager () {
	s_was_destroyed = true;
}

void BinaryStringFactoryManager::register_factory (
	BinaryStringAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BinaryStringFactoryManager::register_factory_i (
	BinaryStringAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::IO::BinaryStringFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BinaryStringAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BinaryStringAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

BinaryString* BinaryStringFactoryManager::make (const void* buffer, size_t size) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::IO::BinaryStringFactory");
	}
	BinaryString* ret_ = m_single_active_factory->make (buffer, size);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::IO::BinaryStringFactory impl can't return zerro"));
	return ret_;
}
} // namespace IO
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

