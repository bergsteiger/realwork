////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/impl/mt_i/ThreadPool_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::mt_i::ThreadPool_i
// ��������� ���������� ������ �������� ��� ��������� ThreadPool
//
// ��� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ��� �������
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
	// ���������� ����� ������
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

	// ����� ���������
	static const unsigned long DEFAULT_THREADS_COUNTS; // ���������� ������� � ���� ������� �� ���������������� �� ���������

	// ��������� ��������� ��� �������� "������" � �����
	struct Message {
		// ������� ��� ���������� ������
		ACE_THR_FUNC func;
		// ��������� �������
		void* param;
		// ����������� ����� ������
		ThreadHandle th;
	};

	// ������ ��������� � �������
	struct ThreadData {
		// ����� ������
		ThreadFlag flags;
		// ��������� ���������� ������
		ThreadResult res;
		// Event (os) ��� �������������
		Core::Box<ACE_Manual_Event> event;
		ThreadData () : res(THREAD_RESULT_OK) {
			//#UC START# *45F051A2021B_DEF_INIT_CTOR*
			//#UC END# *45F051A2021B_DEF_INIT_CTOR**cpp*
		}
	};

	// ���� ������ ������ �� ��� ������, ����������� ��� ��������� ������ ������
	typedef std::map < ThreadHandle, ThreadData > ThreadResult_map;

	// ���� �������� - ����� � ������� ����� �������� (�������) ������������� ������
	typedef std::map < ACE_thread_t, ThreadHandle > Thread_map;

	// ���� ��� �������������� �������� ��������
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
	// ��������� � ��� ������� �����
	virtual bool add_thread (ACE_thread_t t_id, ThreadHandle th);

	// ����������� ����������� ���-�� �������� � ����
	virtual void check_and_activate ();

	// ���������� ����� ����� (� ���� ��������� �� Event (os), ��� ����������� �������� ��� ����������
	// (�� event)
	virtual ThreadHandle create_thread_handle ();

	// ����������� ��������� � ������� �������
	virtual bool free_thread_resource (ThreadHandle th) /*throw (UnmanagedThread)*/;

	// ���������� ������� ��������� ������ ��� ������
	virtual ThreadFlag get_thread_flag (ThreadHandle th) const /*throw (UnmanagedThread)*/;

	// ���������� ��������� ���������� ���������� ������� ��������� �������
	virtual ThreadResult get_thread_result (ThreadHandle th) /*throw (UnmanagedThread)*/;

	// �������� ������ � ����� ��� ���������� � ����������� ���-�� ������� �������
	virtual bool put (ACE_Message_Block* mb);

	// ������� �� ���� �����
	virtual void remove_thread (ACE_thread_t t_id);

	// ������������� �������� ������ ������
	virtual void set_thread_flag (ThreadHandle th, ThreadFlag flag) /*throw (UnmanagedThread)*/;

	// ������������� �������� ���������� ���������� ������� ������
	virtual bool set_thread_result (ThreadHandle th, ThreadResult res);

	// Iterate <n_iterations> time printing off a message and "waiting" for all other threads to
	// complete this iteration.
	virtual int svc ();

	// ��� ���������� ������ ������
	virtual void wait_thread (ThreadHandle th);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::AtomicOp<unsigned long> m_busy_thr_count;

	// ����� ���������� "������������" ������
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
	// �������� ������ ��������� ���� ������� ����
	virtual void cancel_all_threads ();

	// implemented method from ThreadPool
	// ���������� ������ � ��������� ������� ���� ����������
	virtual void cancel_thread (ThreadHandle th) /*throw (UnmanagedThread)*/;

	// implemented method from ThreadPool
	// ������������� �������� ������
	virtual ThreadHandle get_current_thread_handle () const;

	// implemented method from ThreadPool
	// ���������� true ���� �������� ������ ��������� ���� ����������
	virtual bool is_current_canceled () const;

	// implemented method from ThreadPool
	// ��������� ������� ����� �� ������� ���������� ���������� ������, ���������� ��������� ������
	// ������.
	virtual ThreadResult join_thread (ThreadHandle th);

	// implemented method from ThreadPool
	// ������������� ���-�� ������� � ���� �� ����� ����������� �������� (� ������ ���� ������� ���-��
	// �������� ������ ���������� �������� - �� ���� �� ��������)
	virtual void reserve (unsigned long pool_size);

	// implemented method from ThreadPool
	// ������������� ��� ������, ��������� ���������� �� ������.
	virtual void shutdown_all_threads ();

	// implemented method from ThreadPool
	// �������� ��������� ����� �� ���� � �������� ��� ���������� ���������� �������. � ����������
	// ���������� ����� ���������� ������� ��� 0 � ������ ������
	virtual ThreadHandle spawn_thread (ACE_THR_FUNC func, void* param);

	// implemented method from ThreadPool
	// ��������� ���������� ����� �� ��� ��� ���� ��� ������ � ���� ����� ���������, � �������������
	// ��� ������ ����� ��������
	virtual void wait_for_busy () const;
}; // class ThreadPool_i

} // namespace mt_i
} // namespace Core


#endif //__SHARED_CORE_MT_I_THREADPOOL_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
