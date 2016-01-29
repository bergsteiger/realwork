////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/LargeMemoryImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCI::MMapComImpl::LargeMemoryImpl
//
// реализация фасета "большой Памяти"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_LARGEMEMORYIMPL_H__
#define __SHARED_GCI_MMAPCOMIMPL_LARGEMEMORYIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMap.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

// реализация фасета "большой Памяти"
class LargeMemoryImpl;
typedef Core::Var<LargeMemoryImpl> LargeMemoryImpl_var;
typedef Core::Var<const LargeMemoryImpl> LargeMemoryImpl_cvar;

class LargeMemoryImpl :
	virtual public MMap::LargeMemory
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LargeMemoryImpl)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// Конструктор с параметром PoolListHandler
	LargeMemoryImpl (
		const MMap::FileForMem* file
		, PoolListHandler* pool_list_handler
		, size_t page_size
		, size_t granularity
		, bool regulary_segmentation
	);

public:
	virtual ~LargeMemoryImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Интерфес файла для каждого LargeMemory свой, необходим для получения
	// памяти Memory
	MMap::FileForMem_cvar m_file;

	// Гранулярность памяти
	size_t m_granularity;

	// Размер памяти для маппинга
	size_t m_page_size;

	// Интерфейс предоставляющие методы работы со списком MemoryPool
	mutable PoolListHandler_var m_pool_list_handler;

	// Флаг указывает нужно ли делать равномерное разбиение при мапинге файла.
	bool m_regulary_segmentation;

	// Закешированная системная область файла.
	mutable MMap::Memory_cvar m_system_memory;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MMap::LargeMemory
	// соотвествующий данной логической памяти ммап-файл
	virtual const MMap::FileForMem& get_map_file () const;
	virtual MMap::FileForMem& get_map_file ();

	// implemented method from MMap::LargeMemory
	// Логический кусок памяти, соотвествующий указанному смещению (указанное смещение гарантированно
	// находится внутри него). В out параметре возвращает смещение от начала логического куска
	// (Memeory::base_addr) до заданного.
	virtual const MMap::Memory* get_memory (MMap::LongSize offset, size_t& inside_offset) const;
	virtual MMap::Memory* get_memory (MMap::LongSize offset, size_t& inside_offset);

	// implemented method from MMap::LargeMemory
	// Фискированный размер страницы соотвествующий этой логической памяти
	virtual const size_t get_page_size () const;

	// implemented method from MMap::LargeMemory
	// Системная область файла, недоступная через метод get_memory()
	virtual const MMap::Memory* get_system_memory () const;
	virtual MMap::Memory* get_system_memory ();
}; // class LargeMemoryImpl

} // namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_LARGEMEMORYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

