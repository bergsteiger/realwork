////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/mt_i/ThreadPool_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::mt_i::ThreadPool_i
//
// пул потоков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/impl/mt_i/ThreadPool_i_factory.h"
#include "shared/Core/impl/mt_i/ThreadPool_i.h"

namespace Core {
namespace mt_i {

ThreadPool_i_factory::ThreadPool_i_factory () {
}

void ThreadPool_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ThreadPoolFactoryManager::register_factory (this, priority);
}

const char* ThreadPool_i_factory::key () const {
	return "ThreadPool_i";
}

ThreadPool* ThreadPool_i_factory::def () {
	ThreadPool_i_var ret = new ThreadPool_i ();
	return ret._retn ();
}

ThreadPool* ThreadPool_i_factory::make (unsigned long pool_size) {
	ThreadPool_i_var ret = new ThreadPool_i (pool_size);
	return ret._retn ();
}

} // namespace mt_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

