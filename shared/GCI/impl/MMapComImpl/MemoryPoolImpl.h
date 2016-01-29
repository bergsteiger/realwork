////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MemoryPoolImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapComImpl::MemoryPoolImpl
// Заголовок реализации класса серванта для интерфеса PoolListHandler
//
// Реализация пула.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_H__
#define __SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

class MemoryPoolImpl; // self forward Var
typedef ::Core::Var<MemoryPoolImpl> MemoryPoolImpl_var;
typedef ::Core::Var<const MemoryPoolImpl> MemoryPoolImpl_cvar;

class MemoryPoolImpl_factory;

// Реализация пула.
class MemoryPoolImpl:
	virtual public PoolListHandler
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MemoryPoolImpl)
	friend class MemoryPoolImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MemoryPoolImpl ();

	virtual ~MemoryPoolImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Текущий размер общеё смапленной виртуальной памяти в пуле.
	size_t m_current_pool_size;

	// Гранулярность памяти
	size_t m_granularity;

	// Максимальный размер пула - максимальный размер виртуальной памяти,
	// который может быть использован для маппинга всех файлов.
	size_t m_max_pool_size;

	// Общий для всех файлов список кусков смапленной памяти памяти,
	// который обновляется при запросах памяти у MemoryPool
	mutable MemoryList m_memory_list;

	// Мьютекс для синхронизации доступа к списку пула
	mutable Core::Mutex m_pool_mutex;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	virtual const MemoryList& get_memory_list () const;

	virtual void set_memory_list (const MemoryList& memory_list) const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MMap::MemoryPool
	// персонифицированный участок памяти, связанный с указанным указанный ммап-файлом. Этот файл
	// будет добавлен в пул, доступ к нему будет "разбит" на страницы указанного размера. Если размер
	// = 0 (или меньше пороговой величины), то берется размер по умолчанию. При попытке переразбить
	// ранее добавленный файл - исключение.
	virtual const MMap::LargeMemory* get_large_memory (const MMap::FileForMem* file, size_t page_size, bool regulary_segmentation) const;
	virtual MMap::LargeMemory* get_large_memory (MMap::FileForMem* file, size_t page_size, bool regulary_segmentation);

	// implemented method from MMap::MemoryPool
	// Максимальный размер пула - максимальный размер виртуальной памяти,
	// который может быть использован для маппинга всех файлов.
	virtual const size_t get_pool_size () const;

	virtual void set_pool_size (size_t pool_size);

	// implemented method from PoolListHandler
	// Возвращает смапленный кусок памяти из списка по заданному
	// смещению в файле - offset.
	virtual MMap::Memory* get_memory (MMap::LongSize offset, HANDLE file_handle) const;

	// implemented method from PoolListHandler
	// Добавляем заданный кусок памяти в список
	virtual void set_memory (MMap::Memory* memory);
}; // class MemoryPoolImpl

} // namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
