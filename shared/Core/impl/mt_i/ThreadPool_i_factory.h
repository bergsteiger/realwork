////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/mt_i/ThreadPool_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::mt_i::ThreadPool_i
// Заголовк реализации фабрик интерфеса ThreadPool для серванта ThreadPool_i
//
// пул потоков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MT_I_THREADPOOL_I_FCTR_H__
#define __SHARED_CORE_MT_I_THREADPOOL_I_FCTR_H__

#include "ace/ACE.h"
#include "shared/Core/mt/mtFactories.h"

namespace Core {
namespace mt_i {

/// Interface-factory implementation for ThreadPool_i
class ThreadPool_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ThreadPoolAbstractFactory {
public:
	ThreadPool_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ThreadPool* def ();

	ThreadPool* make (unsigned long pool_size);

};

typedef ::Core::Var<ThreadPool_i_factory> ThreadPool_i_factory_var;

} // namespace mt_i
} // namespace Core


#endif //__SHARED_CORE_MT_I_THREADPOOL_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

