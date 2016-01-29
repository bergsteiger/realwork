////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MemoryPoolImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapComImpl::MemoryPoolImpl
//
// Реализация пула.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapComImpl/MemoryPoolImpl_factory.h"
#include "shared/GCI/impl/MMapComImpl/MemoryPoolImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

MemoryPoolImpl_factory::MemoryPoolImpl_factory () {
}

void MemoryPoolImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PoolListHandlerFactoryManager::register_factory (this, priority);
}

const char* MemoryPoolImpl_factory::key () const {
	return "MemoryPoolImpl";
}

MMap::MemoryPool* MemoryPoolImpl_factory::get () {
	MemoryPoolImpl_var ret = new MemoryPoolImpl ();
	return ret._retn ();
}

} // namespace MMapComImpl
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

