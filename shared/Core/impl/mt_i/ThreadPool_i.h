////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/mt_i/ThreadPool_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::mt_i::ThreadPool_i
// Заголовок реализации класса серванта для интерфеса ThreadPool
//
// пул потоков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MT_I_THREADPOOL_I_H__
#define __SHARED_CORE_MT_I_THREADPOOL_I_H__

#include "ace/ACE.h"
#include <map>
#include "shared/Core/mt/mt.h"
#include "shared/Core/sys/synch.h"
#include "ace/Task.h"
#include "ace/Task.h"
#include "ace/Thread_Manager.h"
#include "ace/Message_Block.h"
#include "ace/Manual_Event.h"

namespace Core {
namespace mt_i {

class ThreadPool_i; // self forward Var
typedef ::Core::Var<ThreadPool_i> ThreadPool_i_var;
typedef ::Core::Var<const ThreadPool_i> ThreadPool_i_cvar;

class ThreadPool_i_factory;

// пул потоков
class ThreadPool_i:
	virtual public ThreadPool
	, virtual public ::Core::RefCountObjectBase
	, virtual public ACE_Task<ACE_MT_SYNCH>
{
	SET_OBJECT_COUNTER (ThreadPool_i)
	friend class ThreadPool_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// Допустимые флаги потока
	class ThreadFlag : public Core::BitMaskType<unsigned long, ThreadFlag> {
		friend class Core::BitMaskType<unsigned long, ThreadFlag>;
		ThreadFlag (unsigned long val) : Core::BitMaskType<unsigned long, ThreadFlag> (val) {
		}
	public:
		ThreadFlag () : Core::BitMaskType<unsigned long, ThreadFlag> (0) {
		}

		static const ThreadFlag CANCEL () {
			return 1 << 1;
		}
	};

	// общие константы
	static const unsigned long DEFAULT_THREADS_COUNTS; // Количество потоков в пуле которым он инициализируется по умолчанию

	// струкутра сообщения для передачи "задачи" в поток
	struct Message {
		// функция для выполнения работы
		ACE_THR_FUNC func;
		// параметры функции
		void* param;
		// присвоенный хендл потока
		ThreadHandle th;
	};

	// Данные связанные с потоком
	struct ThreadData {
		// флаги потока
		ThreadFlag flags;
		// результат выполнения работы
		ThreadResult res;
		// Event (os) для синхронизации
		Core::Box<ACE_Manual_Event> event;
		ThreadData () : res(THREAD_RESULT_OK) {
			//#UC START# *45F051A2021B_DEF_INIT_CTOR*
			//#UC END# *45F051A2021B_DEF_INIT_CTOR**cpp*
		}
	};

	// мапа данных потока по его хендлу, заполняется при аллокации нового хендла
	typedef std::map < ThreadHandle, ThreadData > ThreadResult_map;

	// Мапа потокаов - связь с хендлом черех реальный (внешний) идентификатор потока
	typedef std::map < ACE_thread_t, ThreadHandle > Thread_map;

	// Бакс для специфического удаления собщений
	struct MessageBlock_boxDeallocator {
		static void destroy (ACE_Message_Block* content) {
		//#UC START# *45F069AA0383*
	content->release ();
	//#UC END# *45F069AA0383*
		}
	};
	typedef ::Core::Box<ACE_Message_Block, MessageBlock_boxDeallocator, true> MessageBlock_box;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ThreadPool_i ();

	ThreadPool_i (unsigned long pool_size);

	virtual ~ThreadPool_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// Добавляет в пул внешний поток
	virtual bool add_thread (ACE_thread_t t_id, ThreadHandle th);

	// резервирует необходимое кол-во потокков в пуле
	virtual void check_and_activate ();

	// аллоцирует новый хендл (в виде указателя на Event (os), для возможности ожидания его завершения
	// (по event)
	virtual ThreadHandle create_thread_handle ();

	// освобождает связанные с потоком ресурсы
	virtual bool free_thread_resource (ThreadHandle th) /*throw (UnmanagedThread)*/;

	// возвращает текущее состояние флагов для потока
	virtual ThreadFlag get_thread_flag (ThreadHandle th) const /*throw (UnmanagedThread)*/;

	// возвращает результат выполнения последнего задания указанным потоком
	virtual ThreadResult get_thread_result (ThreadHandle th) /*throw (UnmanagedThread)*/;

	// передает задачу в поток для выполнения и увеличивает кол-во занятых потоков
	virtual bool put (ACE_Message_Block* mb);

	// удаояет из пула поток
	virtual void remove_thread (ACE_thread_t t_id);

	// устанавливает значение флагов потока
	virtual void set_thread_flag (ThreadHandle th, ThreadFlag flag) /*throw (UnmanagedThread)*/;

	// устанавливает значение результата выполненой потоком работы
	virtual bool set_thread_result (ThreadHandle th, ThreadResult res);

	// Iterate <n_iterations> time printing off a message and "waiting" for all other threads to
	// complete this iteration.
	virtual int svc ();

	// ждёт завершения работы потока
	virtual void wait_thread (ThreadHandle th);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::AtomicOp<unsigned long> m_busy_thr_count;

	// номер последнего "отцепленного" потока
	Core::AtomicOp<unsigned long> m_last_thread_number;

	ACE_Thread_Manager* m_separate_thr_mng;

	ThreadResult_map m_thread_results;

	mutable Mutex m_thread_results_mutex;

	Thread_map m_threads;

	mutable Mutex m_threads_mutex;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ThreadPool
	// посылает сигнал остановки всем потокам пула
	virtual void cancel_all_threads ();

	// implemented method from ThreadPool
	// Выставляет потоку с указанным хендлом флаг завершения
	virtual void cancel_thread (ThreadHandle th) /*throw (UnmanagedThread)*/;

	// implemented method from ThreadPool
	// идентификатор текущего потока
	virtual ThreadHandle get_current_thread_handle () const;

	// implemented method from ThreadPool
	// Возвращает true если текущему потоку выставлен флаг завершения
	virtual bool is_current_canceled () const;

	// implemented method from ThreadPool
	// блокирует текущий поток до момента завершения указанного потока, возвращает результат работы
	// потока.
	virtual ThreadResult join_thread (ThreadHandle th);

	// implemented method from ThreadPool
	// устанавливает кол-во потоков в пуле не менее переданного значения (в случае если текущее кол-во
	// потокуов больше переданной величины - ни чего не меняется)
	virtual void reserve (unsigned long pool_size);

	// implemented method from ThreadPool
	// Останавливает все потоки, дожидаясь завершения их работы.
	virtual void shutdown_all_threads ();

	// implemented method from ThreadPool
	// Выбирает свободный поток из пула и газначет ему выполнение переданной функции. В результате
	// возвращает хендл выбранного пготока или 0 в случае ошибки
	virtual ThreadHandle spawn_thread (ACE_THR_FUNC func, void* param);

	// implemented method from ThreadPool
	// блокирует вызывающий поток до тех пор пока все задачи в пуле будут завершены, и соотвественно
	// все потоки будут свободны
	virtual void wait_for_busy () const;
}; // class ThreadPool_i

} // namespace mt_i
} // namespace Core


#endif //__SHARED_CORE_MT_I_THREADPOOL_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
