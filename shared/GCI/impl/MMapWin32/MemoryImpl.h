////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapWin32/MemoryImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCI::MMapWin32::MemoryImpl
//
// реализация фасета объекта Память
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPWIN32_MEMORYIMPL_H__
#define __SHARED_GCI_MMAPWIN32_MEMORYIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMap.h"

#if defined(WIN32)
// forward decls for defined friends
namespace GCI {
namespace MMapWin32 {
	class FileForMemImpl;
} // namespace MMapWin32
} // namespace GCI


namespace GCI {
namespace MMapWin32 {

// реализация фасета объекта Память
class MemoryImpl;
typedef Core::Var<MemoryImpl> MemoryImpl_var;
typedef Core::Var<const MemoryImpl> MemoryImpl_cvar;

class MemoryImpl :
	virtual public MMap::Memory
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MemoryImpl)
	friend class FileForMemImpl; // defined friend
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// Конструктор с параметрами
	MemoryImpl (
		MMap::LongSize file_offset
		, const std::string& file_name
		, size_t view_size
		, unsigned long flush_count
		, unsigned long flush_timeout
	);

public:
	virtual ~MemoryImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	void* m_base_addr;

	// Имя файла
	std::string m_file_name;

	// Смещние в файле соответствующее смапленному куску.
	MMap::LongSize m_file_offset;

	// Количество попыток сбросить память на диск
	unsigned long m_flush_count;

	// Время ожидания перед очередной попыткой сброса памяти на диск в милисекундах
	unsigned long m_flush_timeout;

	MMap::FileForMem_cvar m_map_file;

	size_t m_view_size;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MMap::Memory
	// логичексий адресс начала области смапленой памяти - именно этот адрес должен использоваться
	// клиентом для работы.
	virtual const void* get_base_addr () const;
	virtual void* get_base_addr ();

	// implemented method from MMap::Memory
	// Хендл файла владельца
	virtual const ACE_HANDLE get_file_handle () const;

	// implemented method from MMap::Memory
	// сбрабывает буфера своей  mmap-области на диск
	virtual void flush () /*throw (MMap::SysError)*/;

	// implemented method from MMap::Memory
	// Возвращает файл с которого была смаплена память Memory
	virtual const std::string get_file_name () const;

	// implemented method from MMap::Memory
	// Возвращает смещение в файле для смапленного куска.
	virtual MMap::LongSize get_file_offset () const;

	// implemented method from MMap::Memory
	// Возвращает размер смапленной области
	virtual const size_t get_view_size () const;
}; // class MemoryImpl

} // namespace MMapWin32
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPWIN32_MEMORYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

