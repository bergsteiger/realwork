////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/MMap/MMap.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::MMap
//
// Интерфейсы для работы с диском, как с памятью (mmap)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAP_H__
#define __SHARED_GCI_MMAP_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace MMap {

// 64-битный размер
typedef unsigned long long LongSize;

// Системная ошибка
class SysError : public ::Core::Exception {
public:
	SysError (unsigned long code, const std::string& file_name, const std::string& op_name);

	virtual ~SysError () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual unsigned long get_code () const;

	virtual const std::string& get_file_name () const;

	virtual void set_file_name (const std::string& file_name);

	virtual const std::string& get_op_name () const;

private:
	mutable char m_message[256];
	// код системной ошибки
	unsigned long m_code;
	// имя ммап-файла
	std::string m_file_name;
	// имя API функции вызвавшей ошибку
	std::string m_op_name;
};

class Memory;
typedef ::Core::Var<Memory> Memory_var;
typedef ::Core::Var<const Memory> Memory_cvar;
// Область виртуальной памяти смапленной на файл
// (примечание: ан-мпинг области происходит в деструкторе)
class Memory
	: virtual public ::Core::IObject
{
public:
	// логичексий адресс начала области смапленой памяти - именно этот адрес должен использоваться
	// клиентом для работы.
	virtual const void* get_base_addr () const = 0;
	virtual void* get_base_addr () = 0;

	// Хендл файла владельца
	virtual const ACE_HANDLE get_file_handle () const = 0;

	// сбрабывает буфера своей  mmap-области на диск
	virtual void flush () /*throw (SysError)*/ = 0;

	// Возвращает файл с которого была смаплена память Memory
	virtual const std::string get_file_name () const = 0;

	// Возвращает смещение в файле для смапленного куска.
	virtual LongSize get_file_offset () const = 0;

	// Возвращает размер смапленной области
	virtual const size_t get_view_size () const = 0;
};

class FileForMem;
typedef ::Core::Var<FileForMem> FileForMem_var;
typedef ::Core::Var<const FileForMem> FileForMem_cvar;
// Инкапсулирует объект физичексого файла для мапинга (его создание, инициализация, установка
// мапинга и т.д.). Используется при создапнии объектов памяти (Memory)
class FileForMem
	: virtual public ::Core::IObject
{

	// forward decls for friend interface's servant
	friend class FileForMemConstWrapper;
public:
	// Дескриптор файла
	virtual const ACE_HANDLE get_file_handle () const = 0;

	// системное смещение памяти - смещение от начала файла начиная с которого будут создаваться
	// объекты смапленной памяти (Memory), т.е. именно с это позиции будет отсчитываться их смещение
	// указанное при создании.
	// Может быть полезно если в начале файла идет какая-то служебная информация не предназначенная
	// для обычного мапинга в память или если ее наличие необходимо "скрыть" от последующих алгоритмов
	// .
	virtual LongSize get_memory_offset () const = 0;

	virtual void set_memory_offset (LongSize memory_offset) = 0;

	// Логический кусок памяти, соответствующий заданному смещению и размеру. Всегда создается новый
	// объект и мапируется в данном мап-файле по указанному смещению. После успешного создания в
	// атрибуте base_addr содержит логический адрес смапленной области.
	virtual const Memory* get_memory (LongSize offset, size_t size, size_t& inside_offset) const = 0;
	virtual Memory* get_memory (LongSize offset, size_t size, size_t& inside_offset) = 0;

	// Возвращает имя файла
	virtual const std::string& get_file_name () const = 0;

	// Возвращает размер файла
	virtual LongSize get_file_size () const = 0;

	// Увеличивает размер файла
	virtual void resize_file (LongSize offset) = 0;

//upgrade rw method
	virtual void upgrade_rw () = 0;
};

/// factory interface for FileForMem
class FileForMemFactory {
public:
	// Открывает и маппирует ранее созданный файл
	static FileForMem* open (const char* file_name, unsigned long flags, size_t file_increase)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/;

	static const FileForMem* open_ro (const char* file_name, unsigned long flags, size_t file_increase)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/;

	// создает новый (или открывает существующий) файл устанавливает его виртуальный размер в заданную
	// величину и мапирует его
	static FileForMem* create (const char* file_name, LongSize size, unsigned long flags)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/;
};

class LargeMemory;
typedef ::Core::Var<LargeMemory> LargeMemory_var;
typedef ::Core::Var<const LargeMemory> LargeMemory_cvar;
// Персонифицировапнный (относящийся к одному клиенту пула) объект предоставляющий доступ к буферам
// памяти (Memory) в пуле. Конкретный экземпляр связан с одним ммап-файлом
class LargeMemory
	: virtual public ::Core::IObject
{
public:
	// соотвествующий данной логической памяти ммап-файл
	virtual const FileForMem& get_map_file () const = 0;
	virtual FileForMem& get_map_file () = 0;

	// Логический кусок памяти, соотвествующий указанному смещению (указанное смещение гарантированно
	// находится внутри него). В out параметре возвращает смещение от начала логического куска
	// (Memeory::base_addr) до заданного.
	virtual const Memory* get_memory (LongSize offset, size_t& inside_offset) const = 0;
	virtual Memory* get_memory (LongSize offset, size_t& inside_offset) = 0;

	// Фискированный размер страницы соотвествующий этой логической памяти
	virtual const size_t get_page_size () const = 0;

	// Системная область файла, недоступная через метод get_memory()
	virtual const Memory* get_system_memory () const = 0;
	virtual Memory* get_system_memory () = 0;
};

class MemoryPool;
typedef ::Core::Var<MemoryPool> MemoryPool_var;
typedef ::Core::Var<const MemoryPool> MemoryPool_cvar;
// Пул буферов смапленой памяти, управляет их временим жизни, обеспецивая гарантию того что
// доступное 32 адресное пространство не закончится. Нужен для более прозрачной работы с 64-
// разрядным пространством.
class MemoryPool
	: virtual public ::Core::IObject
{
public:
	// Максимальный размер пула - максимальный размер виртуальной памяти,
	// который может быть использован для маппинга всех файлов.
	virtual const size_t get_pool_size () const = 0;

	virtual void set_pool_size (size_t pool_size) = 0;

	// персонифицированный участок памяти, связанный с указанным указанный ммап-файлом. Этот файл
	// будет добавлен в пул, доступ к нему будет "разбит" на страницы указанного размера. Если размер
	// = 0 (или меньше пороговой величины), то берется размер по умолчанию. При попытке переразбить
	// ранее добавленный файл - исключение.
	virtual const LargeMemory* get_large_memory (const FileForMem* file, size_t page_size, bool regulary_segmentation) const = 0;
	virtual LargeMemory* get_large_memory (FileForMem* file, size_t page_size, bool regulary_segmentation) = 0;
};

/// factory interface for MemoryPool
class MemoryPoolFactory {
public:
	// возвращает интерфейс глобального пула
	static MemoryPool& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Константы пула
static const size_t DEFAULT_MAX_POOL_SIZE = 650117120; // Максимальный размер пула по умолчанию(испозуется, если параметр не был задан через фабрику)

// Список умолчальных констант интерфейса Memory
static const unsigned long DEFAULT_FLUSH_COUNT = 40; // Количество попыток вызвать FlushViewOfFile для сброса содержимого памяти  на диск
static const unsigned long DEFAULT_FLUSH_TIMEOUT = 500; // Время ожидания перед очередной попыткой сбросить содержимое памяти  на диск в милисекундах

} // namespace MMap
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::MMap::FileForMem> {
	typedef GCI::MMap::FileForMemFactory Factory;
};
template <>
struct TypeTraits <GCI::MMap::MemoryPool> {
	typedef GCI::MMap::MemoryPoolFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_MMAP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
