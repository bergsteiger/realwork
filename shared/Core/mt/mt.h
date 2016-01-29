////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mt/mt.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::mt
//
// работа с многопоточностью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MT_H__
#define __SHARED_CORE_MT_H__

#include "shared/Core/sys/core_std_inc.h"
#include "ace/Task.h"

namespace Core {

// идентификатор потока в пуле
typedef unsigned long ThreadHandle;

// обертка над ACE-овским типом результата завершения функции потока
typedef ACE_THR_FUNC_RETURN ThreadResult;

// Поток переданный в метод не пренадлежит данному пулу потоков
class UnmanagedThread : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ThreadPool;
typedef ::Core::Var<ThreadPool> ThreadPool_var;
typedef ::Core::Var<const ThreadPool> ThreadPool_cvar;
// Пул потоков. Общий интерфейс обеспечивающий работу с пулом потоков. В сисетем может
// использоваться не сколько пулов потоков.
class ThreadPool
	: virtual public ::Core::IObject
{
public:
	// идентификатор текущего потока
	virtual ThreadHandle get_current_thread_handle () const = 0;

	// блокирует текущий поток до момента завершения указанного потока, возвращает результат работы
	// потока.
	virtual ThreadResult join_thread (ThreadHandle th) = 0;

	// Выставляет потоку с указанным хендлом флаг завершения
	virtual void cancel_thread (ThreadHandle th) /*throw (UnmanagedThread)*/ = 0;

	// посылает сигнал остановки всем потокам пула
	virtual void cancel_all_threads () = 0;

	// Возвращает true если текущему потоку выставлен флаг завершения
	virtual bool is_current_canceled () const = 0;

	// Выбирает свободный поток из пула и газначет ему выполнение переданной функции. В результате
	// возвращает хендл выбранного пготока или 0 в случае ошибки
	virtual ThreadHandle spawn_thread (ACE_THR_FUNC func, void* param) = 0;

	// устанавливает кол-во потоков в пуле не менее переданного значения (в случае если текущее кол-во
	// потокуов больше переданной величины - ни чего не меняется)
	virtual void reserve (unsigned long pool_size) = 0;

	// Останавливает все потоки, дожидаясь завершения их работы.
	virtual void shutdown_all_threads () = 0;

	// блокирует вызывающий поток до тех пор пока все задачи в пуле будут завершены, и соотвественно
	// все потоки будут свободны
	virtual void wait_for_busy () const = 0;
};

/// factory interface for ThreadPool
class ThreadPoolFactory {
public:
	// возвращает общий пул "по умолчанию"
	static ThreadPool& def ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// создает новый пул с указанным кол-вом потоков
	static ThreadPool* make (unsigned long pool_size)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// предустановленые значения хендлов потока
static const ThreadHandle BAD_HANDLE = 0; // Значение невалидного хендла потока

// предустановленные значения результата потоковой функции
static const ThreadResult THREAD_RESULT_OK = 0; // функция потока завершилась успешно

} // namespace Core

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Core::ThreadPool> {
	typedef Core::ThreadPoolFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORE_MT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
