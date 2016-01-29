////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/MMap/MMap.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::MMap
//
// Интерфейсы для работы с диском, как с памятью (mmap)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMap.h"
#include "shared/GCI/MMap/MMapFactories.h"

namespace GCI {
namespace MMap {


//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

unsigned long SysError::get_code () const {
	//#UC START# *49722B930012_GET_ACCESSOR*
	return m_code;
	//#UC END# *49722B930012_GET_ACCESSOR*
}

const std::string& SysError::get_file_name () const {
	//#UC START# *4972396D0098_GET_ACCESSOR*
	return m_file_name;
	//#UC END# *4972396D0098_GET_ACCESSOR*
}

void SysError::set_file_name (const std::string& file_name) {
	//#UC START# *4972396D0098_SET_ACCESSOR*
	m_file_name = file_name;
	//#UC END# *4972396D0098_SET_ACCESSOR*
}

const std::string& SysError::get_op_name () const {
	//#UC START# *4972399D0170_GET_ACCESSOR*
	return m_op_name;
	//#UC END# *4972399D0170_GET_ACCESSOR*
}

SysError::SysError (unsigned long code, const std::string& file_name, const std::string& op_name)
	: m_code (code), m_file_name (file_name), m_op_name (op_name)
//#UC START# *49722B5B0083_BASE_INIT*
//#UC END# *49722B5B0083_BASE_INIT*
{
	//#UC START# *49722B5B0083_BODY*
	//#UC END# *49722B5B0083_BODY*
}

SysError::~SysError () throw () {
}

const char* SysError::uid () const /*throw ()*/ {
	return "644CC593-4AEF-48C5-8B8C-64B9D427CC62";
}

const char* SysError::what () const throw () {
	//#UC START# *49722B5B0083_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "SysError (Системная ошибка), codse=%u, file_name=%s, op_name=%s"
		, m_code
		, m_file_name.c_str ()
		, m_op_name.c_str ()
	);
	return m_message;
	//#UC END# *49722B5B0083_WHAT_IMPL*
}

// factory interface wrapper for FileForMem
FileForMem* FileForMemFactory::open (
	const char* file_name
	, unsigned long flags
	, size_t file_increase
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/ {
	return FileForMemFactoryManager::Singleton::instance ()->open (file_name, flags, file_increase);
}

const FileForMem* FileForMemFactory::open_ro (
	const char* file_name
	, unsigned long flags
	, size_t file_increase
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/ {
	return FileForMemFactoryManager::Singleton::instance ()->open_ro (file_name, flags, file_increase);
}

FileForMem* FileForMemFactory::create (
	const char* file_name
	, LongSize size
	, unsigned long flags
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/ {
	return FileForMemFactoryManager::Singleton::instance ()->create (file_name, size, flags);
}

// factory interface wrapper for MemoryPool
MemoryPool& MemoryPoolFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MemoryPoolFactoryManager::Singleton::instance ()->get ();
}

} // namespace MMap
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

