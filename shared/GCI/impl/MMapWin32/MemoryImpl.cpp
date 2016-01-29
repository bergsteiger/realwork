////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapWin32/MemoryImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCI::MMapWin32::MemoryImpl
//
// реализация фасета объекта Память
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapWin32/MemoryImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapWin32 {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// Конструктор с параметрами
MemoryImpl::MemoryImpl (
	MMap::LongSize file_offset
	, const std::string& file_name
	, size_t view_size
	, unsigned long flush_count
	, unsigned long flush_timeout
)
//#UC START# *49DCA7F90041_BASE_INIT*
: m_file_offset(file_offset)
  , m_view_size(view_size)
  , m_file_name(file_name)
  , m_flush_count(flush_count)
  , m_flush_timeout(flush_timeout)
//#UC END# *49DCA7F90041_BASE_INIT*
{
	//#UC START# *49DCA7F90041_BODY*
	//#UC END# *49DCA7F90041_BODY*
}

MemoryImpl::~MemoryImpl () {
	//#UC START# *497218650260_DESTR_BODY*
	if (m_base_addr != 0) {
		if (!UnmapViewOfFile (m_base_addr)) {
			LOG_E (("%s (%d) UnmapViewOfFile returns err = %d", GDS_CURRENT_FUNCTION, m_base_addr, GetLastError ()));
		}
	}
	//#UC END# *497218650260_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MMap::Memory
// логичексий адресс начала области смапленой памяти - именно этот адрес должен использоваться
// клиентом для работы.
const void* MemoryImpl::get_base_addr () const {
	//#UC START# *497204EF0150_497218650260_GET*
	return m_base_addr;
	//#UC END# *497204EF0150_497218650260_GET*
}

void* MemoryImpl::get_base_addr () {
	return const_cast<void*>(((const MemoryImpl*)this)->get_base_addr ());
}

// implemented method from MMap::Memory
// Хендл файла владельца
const ACE_HANDLE MemoryImpl::get_file_handle () const {
	//#UC START# *4A1FD5770302_497218650260_GET*
	return m_map_file->get_file_handle();
	//#UC END# *4A1FD5770302_497218650260_GET*
}

// implemented method from MMap::Memory
// сбрабывает буфера своей  mmap-области на диск
void MemoryImpl::flush () /*throw (MMap::SysError)*/ {
	//#UC START# *4971DD2F031E_497218650260*
	unsigned int tryes_count = 0;
	while(!FlushViewOfFile (m_base_addr, m_view_size) && (tryes_count < m_flush_count)) {
		if (GetLastError () != ERROR_LOCK_VIOLATION) {
			throw MMap::SysError (GetLastError (), "", std::string ("FlushViewOfFile"));
		} else {
			LOG_D (("%s (%@, %d) FlushViewOfFile returns ERROR_LOCK_VIOLATION", GDS_CURRENT_FUNCTION, m_base_addr, m_view_size));
			tryes_count++;
			LOG_D (("Try Number: %d", tryes_count));
			Sleep(m_flush_timeout);
		}
	}
	//#UC END# *4971DD2F031E_497218650260*
}

// implemented method from MMap::Memory
// Возвращает файл с которого была смаплена память Memory
const std::string MemoryImpl::get_file_name () const {
	//#UC START# *49E483630359_497218650260*
	return m_file_name;
	//#UC END# *49E483630359_497218650260*
}

// implemented method from MMap::Memory
// Возвращает смещение в файле для смапленного куска.
MMap::LongSize MemoryImpl::get_file_offset () const {
	//#UC START# *49DCA5E400EF_497218650260*
	return m_file_offset;
	//#UC END# *49DCA5E400EF_497218650260*
}

// implemented method from MMap::Memory
// Возвращает размер смапленной области
const size_t MemoryImpl::get_view_size () const {
	//#UC START# *49DDA7170190_497218650260_GET*
	return m_view_size;
	//#UC END# *49DDA7170190_497218650260_GET*
}
} // namespace MMapWin32
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

