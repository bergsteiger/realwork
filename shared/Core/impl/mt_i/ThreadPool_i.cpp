////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/mt_i/ThreadPool_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::mt_i::ThreadPool_i
//
// пул потоков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/LibHome.h"
#include "shared/Core/impl/mt_i/ThreadPool_i.h"

namespace Core {
namespace mt_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// общие константы
const unsigned long ThreadPool_i::DEFAULT_THREADS_COUNTS = 8; // Количество потоков в пуле которым он инициализируется по умолчанию

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ThreadPool_i::ThreadPool_i () : m_busy_thr_count (0), m_separate_thr_mng (0), m_last_thread_number (0)
//#UC START# *45EFED4D0298_45EFEF8E00B4_4502939F0280_BASE_INIT*
//#UC END# *45EFED4D0298_45EFEF8E00B4_4502939F0280_BASE_INIT*
{
	//#UC START# *45EFED4D0298_45EFEF8E00B4_4502939F0280_BODY*
	//#UC END# *45EFED4D0298_45EFEF8E00B4_4502939F0280_BODY*
}

ThreadPool_i::ThreadPool_i (unsigned long pool_size)
//#UC START# *45EFED4D0298_45EFEFE00056_4502939F0280_BASE_INIT*
	: ACE_Task<ACE_MT_SYNCH> ()
	, m_busy_thr_count (0)
	, m_last_thread_number (0)
//#UC END# *45EFED4D0298_45EFEFE00056_4502939F0280_BASE_INIT*
{
	//#UC START# *45EFED4D0298_45EFEFE00056_4502939F0280_BODY*
	m_separate_thr_mng = new ACE_Thread_Manager ();
	this->thr_mgr (m_separate_thr_mng);
	//#UC END# *45EFED4D0298_45EFEFE00056_4502939F0280_BODY*
}

ThreadPool_i::~ThreadPool_i () {
	//#UC START# *4502939F0280_DESTR_BODY*
	// К моменту вызова деструктора все потоки должны быть уничтожены
	GDS_ASSERT (this->thr_count () == 0);
	{
		GUARD (m_thread_results_mutex);
		m_thread_results.clear ();
	}
	{
		GUARD (m_threads_mutex);
		m_threads.clear ();
	}

	delete m_separate_thr_mng;
	//#UC END# *4502939F0280_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Добавляет в пул внешний поток
bool ThreadPool_i::add_thread (ACE_thread_t t_id, ThreadHandle th) {
	//#UC START# *45F050FB03B1*
	GUARD (m_threads_mutex)
	std::pair <Thread_map::iterator, bool> res = m_threads.insert (Thread_map::value_type (t_id, th));
	return res.second;
	//#UC END# *45F050FB03B1*
}

// резервирует необходимое кол-во потокков в пуле
void ThreadPool_i::check_and_activate () {
	//#UC START# *45F04F0500A4*
	if (!this->thr_count ()) {
		this->reserve (DEFAULT_THREADS_COUNTS);
	}
	//#UC END# *45F04F0500A4*
}

// аллоцирует новый хендл (в виде указателя на Event (os), для возможности ожидания его завершения
// (по event)
ThreadHandle ThreadPool_i::create_thread_handle () {
	//#UC START# *45F050CD02A8*
	ThreadHandle ret = ++m_last_thread_number;
	
	GUARD (m_thread_results_mutex)
	ThreadData& tr = m_thread_results [ret];
	tr.event = new ACE_Manual_Event;
	
	return ret;
	//#UC END# *45F050CD02A8*
}

// освобождает связанные с потоком ресурсы
bool ThreadPool_i::free_thread_resource (ThreadHandle th) /*throw (UnmanagedThread)*/ {
	//#UC START# *4502ED9303C8*
	GUARD (m_thread_results_mutex)
	ThreadResult_map::iterator it = m_thread_results.find (th);
	if (it == m_thread_results.end ()) {
		return false;
	}
	
	m_thread_results.erase (it);
	return true;
	//#UC END# *4502ED9303C8*
}

// возвращает текущее состояние флагов для потока
ThreadPool_i::ThreadFlag ThreadPool_i::get_thread_flag (ThreadHandle th) const /*throw (UnmanagedThread)*/ {
	//#UC START# *45EFF2170102*
	GUARD (m_thread_results_mutex)
	ThreadResult_map::const_iterator it = m_thread_results.find (th);
	if (it == m_thread_results.end ()) {
		throw UnmanagedThread ();
	}
	return it->second.flags;
	//#UC END# *45EFF2170102*
}

// возвращает результат выполнения последнего задания указанным потоком
ThreadResult ThreadPool_i::get_thread_result (ThreadHandle th) /*throw (UnmanagedThread)*/ {
	//#UC START# *45EFF1C5017F*
	
	//нужно дождаться завершения потока
	this->wait_thread (th);	
	ThreadResult res;
	{
		GUARD (m_thread_results_mutex)
		ThreadResult_map::const_iterator it = m_thread_results.find (th);
		if (it == m_thread_results.end ()) {
			throw UnmanagedThread ();
		}
		
		res = it->second.res;
	}
	this->free_thread_resource (th);
	return res;
	//#UC END# *45EFF1C5017F*
}

// передает задачу в поток для выполнения и увеличивает кол-во занятых потоков
bool ThreadPool_i::put (ACE_Message_Block* mb) {
	//#UC START# *45F04EBB0289*
	int res = this->putq (mb, 0);
	if (res != -1) {
		m_busy_thr_count++;
		return true;
	} else {
		return false;
	}
	//#UC END# *45F04EBB0289*
}

// удаояет из пула поток
void ThreadPool_i::remove_thread (ACE_thread_t t_id) {
	//#UC START# *45F0513801EC*
	ThreadHandle th = BAD_HANDLE;
	{
		GUARD (m_threads_mutex);
		Thread_map::iterator it = m_threads.find (t_id);
		if (it != m_threads.end ()) {
			th = it->second;
			m_threads.erase (it);
		}
	}
	//при удалении потока из пула нужно удалить событие, связанное с потоком
	{
		GUARD(m_thread_results_mutex);
		ThreadResult_map::iterator it = m_thread_results.find (th);
		if (it != m_thread_results.end () && !it->second.event.is_nil ()) {
			//событие больше не нужно
			it->second.event = 0;
		}
	}
	//#UC END# *45F0513801EC*
}

// устанавливает значение флагов потока
void ThreadPool_i::set_thread_flag (ThreadHandle th, ThreadFlag flag) /*throw (UnmanagedThread)*/ {
	//#UC START# *45F04AC602A8*
	GUARD (m_thread_results_mutex)
	ThreadResult_map::iterator it = m_thread_results.find (th);
	if (it == m_thread_results.end ()) {
		throw UnmanagedThread();
	}
	it->second.flags = flag;
	//#UC END# *45F04AC602A8*
}

// устанавливает значение результата выполненой потоком работы
bool ThreadPool_i::set_thread_result (ThreadHandle th, ThreadResult res) {
	//#UC START# *45F0506B0085*
	GUARD (m_thread_results_mutex)

	ThreadResult_map::iterator it = m_thread_results.find (th);
	if (it == m_thread_results.end ()) {
		return false;
	}
	it->second.res = res;
	it->second.event->signal ();
	
	return true;
	//#UC END# *45F0506B0085*
}

// Iterate <n_iterations> time printing off a message and "waiting" for all other threads to
// complete this iteration.
int ThreadPool_i::svc () {
	//#UC START# *45F05156021B*
	//LOG_D (("Thread_Pool::svc: start thread."));

	// Note that the <ACE_Task::svc_run> method automatically adds us to
	// the Thread_Manager when the thread begins.
	try {
		Core::Root::LibHomeManagerFactory::get ().init_thread ();
	} catch (Core::Root::NoActiveFactory&) {
	}

	// Keep looping, reading a message out of the queue, until we get a
	// message with a length == 0, which signals us to quit.
	for (;;) {
		MessageBlock_box mb; // We're responsible for deallocating this.
		if (this->getq (mb.out ()) == -1) {
			LOG_E (("ThreadPool_i::svc - getq got result -1, exiting"));
			break;
		}
		//AutoAtomicCounter acu (m_busy_thr_count);

		const size_t mb_len = mb->length ();
		if (!mb_len) {
			//LOG_D (("Thread_Pool::svc: signals us to quit."));
			m_busy_thr_count--;
			break;
		} else if (mb_len != sizeof(Message)) {
			LOG_E (("ThreadPool_i::svc - message length = %d. Got BAD message, exiting.", mb_len));
			m_busy_thr_count--;
			break;
		}

		Message* msg = reinterpret_cast<Message*>(mb->rd_ptr ());
		
		if (!msg->func) {
			LOG_E (("ThreadPool_i::svc - func is 0, exiting."));
			m_busy_thr_count--;
			break;
		} else {
			if (msg->th) {
				if (!add_thread (ACE_OS::thr_self (), msg->th)) {
					LOG_E (("ThreadPool_i::svc - add_thread fail."));
				}
			}
			mpcxc_set_se_handler ();
			ACE_THR_FUNC_RETURN res = msg->func (msg->param);
			if (msg->th) {
				set_thread_result (msg->th, res);
				remove_thread (ACE_OS::thr_self ());
			}
		}
		m_busy_thr_count--;
	}

	try {
		Core::Root::LibHomeManagerFactory::get().finalize_thread();
	} catch (Core::Root::NoActiveFactory&) {
	}
	// Note that the <ACE_Task::svc_run> method automatically removes us
	// from the <ACE_Thread_Manager> when the thread exits.
	return 0;
	//#UC END# *45F05156021B*
}

// ждёт завершения работы потока
void ThreadPool_i::wait_thread (ThreadHandle th) {
	//#UC START# *496F2D31028C*
	Core::Box<ACE_Manual_Event> thread_event;
	{
		GUARD (m_thread_results_mutex)
		ThreadResult_map::iterator it = m_thread_results.find (th);
		if (it == m_thread_results.end ()) {
			throw UnmanagedThread ();
		}
		thread_event = it->second.event;
	}

	if (!thread_event.is_nil ()) {
		thread_event->wait ();
	}
	//#UC END# *496F2D31028C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ThreadPool
// посылает сигнал остановки всем потокам пула
void ThreadPool_i::cancel_all_threads () {
	//#UC START# *45EFEF1803A2_4502939F0280*
	GUARD (m_thread_results_mutex)
	for (ThreadResult_map::iterator it = m_thread_results.begin(); it != m_thread_results.end(); ++it) {
		it->second.flags = ThreadFlag::CANCEL();
	}
	//#UC END# *45EFEF1803A2_4502939F0280*
}

// implemented method from ThreadPool
// Выставляет потоку с указанным хендлом флаг завершения
void ThreadPool_i::cancel_thread (ThreadHandle th) /*throw (UnmanagedThread)*/ {
	//#UC START# *45EFEDA1016F_4502939F0280*
	ThreadFlag flg = this->get_thread_flag (th);
	this->set_thread_flag (th, flg | ThreadFlag::CANCEL());
	//#UC END# *45EFEDA1016F_4502939F0280*
}

// implemented method from ThreadPool
// идентификатор текущего потока
ThreadHandle ThreadPool_i::get_current_thread_handle () const {
	//#UC START# *45EFEE7303A2_4502939F0280_GET*
	GUARD (m_threads_mutex)
	Thread_map::const_iterator it = m_threads.find (ACE_OS::thr_self ());
	if (it == m_threads.end ()) {
		return BAD_HANDLE;
	}
	return it->second;
	//#UC END# *45EFEE7303A2_4502939F0280_GET*
}

// implemented method from ThreadPool
// Возвращает true если текущему потоку выставлен флаг завершения
bool ThreadPool_i::is_current_canceled () const {
	//#UC START# *45EFEDBC00B4_4502939F0280*
	
	ThreadFlag f = this->get_thread_flag (this->get_current_thread_handle());
	return f.test(ThreadFlag::CANCEL());
	//#UC END# *45EFEDBC00B4_4502939F0280*
}

// implemented method from ThreadPool
// блокирует текущий поток до момента завершения указанного потока, возвращает результат работы
// потока.
ThreadResult ThreadPool_i::join_thread (ThreadHandle th) {
	//#UC START# *45EFEB180112_4502939F0280*
	return this->get_thread_result (th);
	//#UC END# *45EFEB180112_4502939F0280*
}

// implemented method from ThreadPool
// устанавливает кол-во потоков в пуле не менее переданного значения (в случае если текущее кол-во
// потокуов больше переданной величины - ни чего не меняется)
void ThreadPool_i::reserve (unsigned long pool_size) {
	//#UC START# *45EFF04E0066_4502939F0280*
	// Create the pool of worker threads.	
	if (this->ACE_Task<ACE_MT_SYNCH>::activate (THR_NEW_LWP | THR_DETACHED | THR_INHERIT_SCHED, pool_size, true) == -1) {
		LOG_E (("ThreadPool_i::reserve - failed (errno=%d)", errno));
	}
	//#UC END# *45EFF04E0066_4502939F0280*
}

// implemented method from ThreadPool
// Останавливает все потоки, дожидаясь завершения их работы.
void ThreadPool_i::shutdown_all_threads () {
	//#UC START# *45F05A4E01CD_4502939F0280*
	// Send a shutdown message to the waiting threads and exit.
	for (size_t i = 0, count = this->thr_count (); i < count; ++i) {
		 
		// Enqueue a 0 message to flag each consumer to shutdown.
		ACE_Message_Block* mb = new ACE_Message_Block;
		if (this->put (mb) == false) {
			mb->release ();
			LOG_E (("%s: can't put", GDS_CURRENT_FUNCTION));
		}
	}
	
	if (ACE_Thread_Manager* tm = this->thr_mgr ()) {
		tm->cancel_all ();
		tm->wait ();
	}
	//#UC END# *45F05A4E01CD_4502939F0280*
}

// implemented method from ThreadPool
// Выбирает свободный поток из пула и газначет ему выполнение переданной функции. В результате
// возвращает хендл выбранного пготока или 0 в случае ошибки
ThreadHandle ThreadPool_i::spawn_thread (ACE_THR_FUNC func, void* param) {
	//#UC START# *45EFEEA0016F_4502939F0280*
	this->check_and_activate ();

	if (!func) {
		LOG_E (("ThreadPool_i::spawn_thread - func is 0"));
		return BAD_HANDLE;
	}

	ThreadHandle ret = this->create_thread_handle ();
	if (ret != BAD_HANDLE) {
		// Allocate a new message.
		Message msg;
		msg.func = func;
		msg.param = param;
		msg.th = ret;

		ACE_Message_Block* mb = new ACE_Message_Block (sizeof (Message));
		ACE_OS::memcpy (mb->rd_ptr (), &msg, sizeof (Message));
		
		// Send a normal message to the waiting threads and continue
		// producing.
		mb->wr_ptr (sizeof (Message));

		// Pass the message to the Thread_Pool.
		if (!this->put (mb)) {
			mb->release ();
			if (!this->free_thread_resource (ret)) {
				LOG_E (("ThreadPool_i::spawn_thread - can not free thread's resource"));
			}
			LOG_E (("ThreadPool_i::spawn_thread - can't put message in queue"));
			ret = BAD_HANDLE;
		}
	}
	return ret;
	//#UC END# *45EFEEA0016F_4502939F0280*
}

// implemented method from ThreadPool
// блокирует вызывающий поток до тех пор пока все задачи в пуле будут завершены, и соотвественно
// все потоки будут свободны
void ThreadPool_i::wait_for_busy () const {
	//#UC START# *45113B6F003D_4502939F0280*
	while (m_busy_thr_count.value()) {
		ACE_OS::sleep (ACE_Time_Value (0,1000));
	}
	//LOG_D (("ThreadPool::wait_for_busy () - all threads free"));
	//#UC END# *45113B6F003D_4502939F0280*
}
} // namespace mt_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

