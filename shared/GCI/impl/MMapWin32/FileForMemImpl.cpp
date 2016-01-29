////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapWin32/FileForMemImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapWin32::FileForMemImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/MMapWin32/FileForMemImpl.h"
// by <<friend>> dependencies
#include "shared/GCI/impl/MMapWin32/MemoryImpl.h"

//#UC START# *4972185901BE_CUSTOM_INCLUDES*
#if defined(WIN32) && defined(_WIN32_WINNT) && (_WIN32_WINNT >= 0x0500)
#include <Windows.h>
#include <WinIoCtl.h>
#endif //WIN32 && _WIN32_WINNT>=0x0500
//#UC END# *4972185901BE_CUSTOM_INCLUDES*

#if defined(WIN32) && defined(_WIN32_WINNT) && (_WIN32_WINNT >= 0x0500)
namespace GCI {
namespace MMapWin32 {

//#UC START# *4972185901BE*
//#UC END# *4972185901BE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FileForMemImpl::FileForMemImpl (const char* file_name, unsigned long flags, size_t file_increase, bool ro_mode)
//#UC START# *4971EE25002F_4971EE590147_4972185901BE_BASE_INIT*
	: m_ro_mode (ro_mode)
	  , m_flush_count(GCI::MMap::DEFAULT_FLUSH_COUNT)
	  , m_flush_timeout(GCI::MMap::DEFAULT_FLUSH_TIMEOUT)
	  , m_file_increase(file_increase)
//#UC END# *4971EE25002F_4971EE590147_4972185901BE_BASE_INIT*
{
	//#UC START# *4971EE25002F_4971EE590147_4972185901BE_BODY*
	SYSTEM_INFO sinf;
	GetSystemInfo(&sinf); 

	m_info.name = file_name;
	m_info.memory_offset = 0;
	m_info.desired_size = 0;
	m_info.access = GENERIC_READ;
	m_info.creation = OPEN_EXISTING;
	m_info.shared_mode = FILE_SHARE_READ;
	m_info.granularity = sinf.dwAllocationGranularity; 
	m_info.flags = flags;
		
	if (!m_ro_mode) {
		m_info.access |= GENERIC_WRITE;
		m_info.shared_mode |= FILE_SHARE_WRITE | FILE_SHARE_DELETE;
	}

	this->open_and_map ();
	//#UC END# *4971EE25002F_4971EE590147_4972185901BE_BODY*
}

FileForMemImpl::FileForMemImpl (const char* file_name, MMap::LongSize size, unsigned long flags)
//#UC START# *4971EE25002F_4971EE6000BB_4972185901BE_BASE_INIT*
	: m_ro_mode (false)
      , m_flush_count(GCI::MMap::DEFAULT_FLUSH_COUNT)
	  , m_flush_timeout(GCI::MMap::DEFAULT_FLUSH_TIMEOUT)
  	  , m_file_increase(0)
//#UC END# *4971EE25002F_4971EE6000BB_4972185901BE_BASE_INIT*
{
	//#UC START# *4971EE25002F_4971EE6000BB_4972185901BE_BODY*
	SYSTEM_INFO sinf;
	GetSystemInfo(&sinf); 

	m_info.name = file_name;
	m_info.memory_offset = 0;
	m_info.desired_size = size;
	m_info.access = GENERIC_READ | GENERIC_WRITE;
	m_info.creation = OPEN_ALWAYS;
	m_info.flags = flags;
	m_info.shared_mode = FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE;
	m_info.granularity = sinf.dwAllocationGranularity; 

	this->open_and_map ();
	//#UC END# *4971EE25002F_4971EE6000BB_4972185901BE_BODY*
}

FileForMemImpl::~FileForMemImpl () {
	//#UC START# *4972185901BE_DESTR_BODY*
	if (m_map_object_id) {
		CloseHandle (m_map_object_id);
	}
	if (m_info.access & GENERIC_WRITE) {
		if(!FlushFileBuffers(m_file)) {
			GDS_ASSERT (false && "can't execute FlushFileBuffers");
		}
	}
	if (m_file) {
		CloseHandle (m_file);
	}
	//#UC END# *4972185901BE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// аналог map но для немодифицируемой памяти
const MMap::Memory* FileForMemImpl::map_i (
	MMap::LongSize offset
	, size_t size
	, DWORD access_flags
	, size_t& inside_offset
) const /*throw (
	MMap::SysError
)*/ {
	//#UC START# *49736D9000E4*
	inside_offset = offset % m_info.granularity;
	offset = offset - offset % m_info.granularity;
	offset += m_info.memory_offset;

	if(size % m_info.granularity != 0) {
		size = size - size % m_info.granularity + m_info.granularity;
	}

	if(offset + size > m_info.desired_size) {
		const_cast<FileForMemImpl*>(this)->resize_file(
			offset + size - m_info.desired_size > m_file_increase ? offset + size : m_file_increase + m_info.desired_size 
		);
	}

	MemoryImpl_var ret = new MemoryImpl (
		offset - m_info.memory_offset
		, m_info.name
		, size
		, m_flush_count
		, m_flush_timeout
	);
	
	ret->m_map_file = FileForMem::_duplicate (this);
	ret->m_view_size = size;
	ret->m_base_addr = MapViewOfFileEx (
		m_map_object_id
		, access_flags
		, *(((DWORD*) (void*) &offset) + 1)
		, *(((DWORD*) (void*) &offset) + 0)
		, (SIZE_T) size
		, 0
	);

	if (ret->m_base_addr == NULL) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("MapViewOfFileEx"));
	}

	return ret._retn ();
	//#UC END# *49736D9000E4*
}

// увеличивает размер фала (если нужно и можно) и ммапит его
void FileForMemImpl::open_and_map () {
	//#UC START# *4972231A0384*

	m_file = CreateFileA (
		m_info.name.c_str()
		, m_info.access
		, m_info.shared_mode
		, NULL
		, m_info.creation
		, m_info.flags
		, NULL
	);
	
	if (m_file == INVALID_HANDLE_VALUE) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("CreateFileA"));
	}

	LARGE_INTEGER pointer_offset;
	pointer_offset.QuadPart = 0;
	
	LARGE_INTEGER real_size;
	
	if (!SetFilePointerEx (m_file, pointer_offset, &real_size, FILE_END)) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("SetFilePointerEx"));
	}
	
	if (m_info.desired_size > (MMap::LongSize) real_size.QuadPart) { // requested size > current size
		if (m_ro_mode) {
			// try to resize
			pointer_offset.QuadPart = m_info.desired_size;
			
			if (!SetFilePointerEx (m_file, pointer_offset, NULL, FILE_BEGIN)) {
				throw MMap::SysError (GetLastError (), m_info.name, std::string ("SetFilePointerEx (2)"));
			}
		} else {
			// try to resize
			pointer_offset.QuadPart = m_info.desired_size;
			
			if (!SetFilePointerEx (m_file, pointer_offset, NULL, FILE_BEGIN)) {
				throw MMap::SysError (GetLastError (), m_info.name, std::string ("SetFilePointerEx (2)"));
			}
			if (!SetEndOfFile (m_file)) {
				throw MMap::SysError (GetLastError (), m_info.name, std::string ("SetEndOfFile"));
			}
		}
	} else {
		m_info.desired_size = (MMap::LongSize) real_size.QuadPart;
	}

	DWORD protect;
	if (m_ro_mode) {
		protect = PAGE_READONLY;
	} else {
		protect = PAGE_READWRITE;
	}
	
	m_map_object_id = CreateFileMapping (m_file, NULL, protect, 0, 0, NULL);
	if (m_map_object_id == NULL) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("CreateFileMapping"));
	}
	//#UC END# *4972231A0384*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

unsigned long FileForMemImpl::get_flush_count () const {
	//#UC START# *49EC8CE301EC_GET_ACCESSOR*
	return m_flush_count;
	//#UC END# *49EC8CE301EC_GET_ACCESSOR*
}

void FileForMemImpl::set_flush_count (unsigned long flush_count) {
	//#UC START# *49EC8CE301EC_SET_ACCESSOR*
	m_flush_count = flush_count;
	//#UC END# *49EC8CE301EC_SET_ACCESSOR*
}

unsigned long FileForMemImpl::get_flush_timeout () const {
	//#UC START# *49EC8D2502EC_GET_ACCESSOR*
	return m_flush_timeout;
	//#UC END# *49EC8D2502EC_GET_ACCESSOR*
}

void FileForMemImpl::set_flush_timeout (unsigned long flush_timeout) {
	//#UC START# *49EC8D2502EC_SET_ACCESSOR*
	m_flush_timeout = flush_timeout;
	//#UC END# *49EC8D2502EC_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MMap::FileForMem
// Дескриптор файла
const ACE_HANDLE FileForMemImpl::get_file_handle () const {
	//#UC START# *4A1FD1D8016D_4972185901BE_GET*
	return m_file;
	//#UC END# *4A1FD1D8016D_4972185901BE_GET*
}

// implemented method from MMap::FileForMem
// Возвращает имя файла
const std::string& FileForMemImpl::get_file_name () const {
	//#UC START# *49DE0304038F_4972185901BE*
	return m_info.name;
	//#UC END# *49DE0304038F_4972185901BE*
}

// implemented method from MMap::FileForMem
// Возвращает размер файла
MMap::LongSize FileForMemImpl::get_file_size () const {
	//#UC START# *49DF35B0022E_4972185901BE*
	return m_info.desired_size;
	//#UC END# *49DF35B0022E_4972185901BE*
}

// implemented method from MMap::FileForMem
// Логический кусок памяти, соответствующий заданному смещению и размеру. Всегда создается новый
// объект и мапируется в данном мап-файле по указанному смещению. После успешного создания в
// атрибуте base_addr содержит логический адрес смапленной области.
const MMap::Memory* FileForMemImpl::get_memory (MMap::LongSize offset, size_t size, size_t& inside_offset) const {
	//#UC START# *497F06DA0136_4972185901BE_GET*
	if (m_ro_mode) {
		return this->map_i (offset, size, FILE_MAP_READ, inside_offset);
	} else {
		return this->map_i (offset, size, FILE_MAP_WRITE, inside_offset);
	}
	//#UC END# *497F06DA0136_4972185901BE_GET*
}

MMap::Memory* FileForMemImpl::get_memory (MMap::LongSize offset, size_t size, size_t& inside_offset) {
	return const_cast<MMap::Memory*>(((const FileForMemImpl*)this)->get_memory (offset, size, inside_offset));
}

// implemented method from MMap::FileForMem
// системное смещение памяти - смещение от начала файла начиная с которого будут создаваться
// объекты смапленной памяти (Memory), т.е. именно с это позиции будет отсчитываться их смещение
// указанное при создании.
// Может быть полезно если в начале файла идет какая-то служебная информация не предназначенная для
// обычного мапинга в память или если ее наличие необходимо "скрыть" от последующих алгоритмов .
MMap::LongSize FileForMemImpl::get_memory_offset () const {
	//#UC START# *497362E10154_4972185901BE_GET*
	return m_info.memory_offset;
	//#UC END# *497362E10154_4972185901BE_GET*
}

void FileForMemImpl::set_memory_offset (MMap::LongSize memory_offset) {
	//#UC START# *497362E10154_4972185901BE_SET*
	if(memory_offset % m_info.granularity != 0) {
		memory_offset = memory_offset - memory_offset % m_info.granularity + m_info.granularity;
	}
	m_info.memory_offset = memory_offset;
	//#UC END# *497362E10154_4972185901BE_SET*
}

// implemented method from MMap::FileForMem
// Увеличивает размер файла
void FileForMemImpl::resize_file (MMap::LongSize offset) {
	//#UC START# *49E6E56B009E_4972185901BE*
	if(!CloseHandle(m_map_object_id)) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("CloseHandle"));
	}

	LARGE_INTEGER pointer_offset;
	pointer_offset.QuadPart = offset;
	
	if (!SetFilePointerEx (m_file, pointer_offset, NULL, FILE_BEGIN)) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("SetFilePointerEx (2)"));
	}

	if (!SetEndOfFile (m_file)) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("SetEndOfFile"));
	}

	DWORD protect;
	if (m_ro_mode) {
		protect = PAGE_READONLY;
	} else {
		protect = PAGE_READWRITE;
	}
	
	m_map_object_id = CreateFileMapping (m_file, NULL, protect, 0, 0, NULL);
	if (m_map_object_id == NULL) {
		throw MMap::SysError (GetLastError (), m_info.name, std::string ("CreateFileMapping"));
	}
	
	m_info.desired_size = offset;
	//#UC END# *49E6E56B009E_4972185901BE*
}
void FileForMemImpl::upgrade_rw () {
	//#UC START# *4972185901BE_UPDATE_RW*
	//#UC END# *4972185901BE_UPDATE_RW*
}
} // namespace MMapWin32
} // namespace GCI

#endif //WIN32 && _WIN32_WINNT>=0x0500
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

