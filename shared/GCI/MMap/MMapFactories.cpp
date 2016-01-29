////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/MMap/MMapFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::MMap
//
// Интерфейсы для работы с диском, как с памятью (mmap)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMapFactories.h"

namespace GCI {
namespace MMap {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FileForMem
bool FileForMemFactoryManager::s_was_destroyed = false;


const std::string& FileForMemConstWrapper::get_file_name () const {
	return m_impl->get_file_name ();
}

LongSize FileForMemConstWrapper::get_file_size () const {
	return m_impl->get_file_size ();
}

void FileForMemConstWrapper::resize_file (LongSize offset) {
	if (is_rw) {
		return m_impl->resize_file (offset);
	} else {
		throw Core::Root::ConstViolation ();
	}
}

const ACE_HANDLE FileForMemConstWrapper::get_file_handle () const {
	return m_impl->get_file_handle ();
}

LongSize FileForMemConstWrapper::get_memory_offset () const {
	return m_impl->get_memory_offset ();
}

void FileForMemConstWrapper::set_memory_offset (LongSize memory_offset) {
	if (is_rw) {
		m_impl->set_memory_offset (memory_offset);
	} else {
		throw Core::Root::ConstViolation ();
	}
}

const Memory* FileForMemConstWrapper::get_memory (LongSize offset, size_t size, size_t& inside_offset) const {
	return m_impl->get_memory (offset, size, inside_offset);
}

Memory* FileForMemConstWrapper::get_memory (LongSize offset, size_t size, size_t& inside_offset) {
	if (is_rw) {
		return m_impl->get_memory (offset, size, inside_offset);
	} else {
		throw Core::Root::ConstViolation ();
	}
}

void FileForMemConstWrapper::upgrade_rw () {
	m_impl->upgrade_rw ();
	is_rw = true;
}

FileForMemConstWrapper::FileForMemConstWrapper (FileForMem* impl)
	: m_impl (impl), is_rw (false)
{
}

FileForMemFactoryManager::ComboDataVar::ComboDataVar ()
	: rw_data (0), ro_data (0), is_ro_first (false)
{
}

FileForMemFactoryManager::ComboDataVar::ComboDataVar (FileForMem* rw_data_)
	: rw_data (rw_data_), ro_data (0), is_ro_first (false)
{
}


FileForMemFactoryManager::FileForMemFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FileForMemFactoryManager::~FileForMemFactoryManager () {
	s_was_destroyed = true;
}

void FileForMemFactoryManager::register_factory (
	FileForMemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FileForMemFactoryManager::register_factory_i (
	FileForMemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::MMap::FileForMemFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FileForMemAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FileForMemAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FileForMem* FileForMemFactoryManager::open (const char* file_name, unsigned long flags, size_t file_increase) /*throw (Core::Root::NoActiveFactory, SysError)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::MMap::FileForMemFactory");
	}
	FileForMem* ret_ = m_single_active_factory->open (file_name, flags, file_increase, false);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::MMap::FileForMemFactory impl can't return zerro"));
	return ret_;
}

const FileForMem* FileForMemFactoryManager::open_ro (const char* file_name, unsigned long flags, size_t file_increase) /*throw (Core::Root::NoActiveFactory, SysError)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::MMap::FileForMemFactory");
	}
	FileForMem* ret_ = m_single_active_factory->open (file_name, flags, file_increase, true);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::MMap::FileForMemFactory impl can't return zerro"));
	return new FileForMemConstWrapper (ret_);
}

FileForMem* FileForMemFactoryManager::create (const char* file_name, LongSize size, unsigned long flags) /*throw (Core::Root::NoActiveFactory, SysError)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GCI::MMap::FileForMemFactory");
	}
	FileForMem* ret_ = m_single_active_factory->create (file_name, size, flags);
	GDS_ASSERT_MSG (ret_ != 0, ("GCI::MMap::FileForMemFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MemoryPool
bool MemoryPoolFactoryManager::s_was_destroyed = false;

MemoryPoolFactoryManager::MemoryPoolFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MemoryPoolFactoryManager::~MemoryPoolFactoryManager () {
	s_was_destroyed = true;
}

void MemoryPoolFactoryManager::register_factory (
	MemoryPoolAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MemoryPoolFactoryManager::register_factory_i (
	MemoryPoolAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::MMap::MemoryPoolFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MemoryPoolAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MemoryPoolAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MemoryPool& MemoryPoolFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GCI::MMap::MemoryPoolFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("GCI::MMap::MemoryPoolFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace MMap
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

