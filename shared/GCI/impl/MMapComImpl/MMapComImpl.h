////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MMapComImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::MMapComImpl
//
// платформонезависимая часть реализации MMAP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_H__
#define __SHARED_GCI_MMAPCOMIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCI/MMap/MMap.h"


#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

class PoolListHandler;
typedef ::Core::Var<PoolListHandler> PoolListHandler_var;
typedef ::Core::Var<const PoolListHandler> PoolListHandler_cvar;
// Интерфейс доступа к списку смапированных областей памяти,
// используется в реализации интерфейса LargeMemory.
class PoolListHandler
	: virtual public MMap::MemoryPool
{
public:
	// Добавляем заданный кусок памяти в список
	virtual void set_memory (MMap::Memory* memory) = 0;

	// Возвращает смапленный кусок памяти из списка по заданному
	// смещению в файле - offset.
	virtual MMap::Memory* get_memory (MMap::LongSize offset, HANDLE file_handle) const = 0;
};

/// factory interface for PoolListHandler
class PoolListHandlerFactory {
public:
	// возвращает интерфейс глобального пула
	static PoolListHandler& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Общий для всех файлов список кусков смапленной памяти памяти,
// который обновляется при запросах памяти у MemoryPool
typedef std::vector < MMap::Memory_var > MemoryList;

} //namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

