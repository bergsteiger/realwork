////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mt/mt.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::mt
//
// работа с многопоточностью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/mt/mt.h"
#include "shared/Core/mt/mtFactories.h"

namespace Core {


const char* UnmanagedThread::uid () const /*throw ()*/ {
	return "5B1D3638-9354-4494-8F8C-243713F4C521";
}

const char* UnmanagedThread::what () const throw () {
	//#UC START# *45EFEBF60018_WHAT_IMPL*
	return "UnmanagedThread (Поток переданный в метод не пренадлежит данному пулу потоков)";
	//#UC END# *45EFEBF60018_WHAT_IMPL*
}

// factory interface wrapper for ThreadPool
ThreadPool& ThreadPoolFactory::def () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ThreadPoolFactoryManager::Singleton::instance ()->def ();
}

ThreadPool* ThreadPoolFactory::make (
	unsigned long pool_size
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ThreadPoolFactoryManager::Singleton::instance ()->make (pool_size);
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

