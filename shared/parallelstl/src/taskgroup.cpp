#include <thread>
#include <numeric>
#include <cstdint>
#include <Windows.h>
#include <experimental\impl\taskgroup.h>
#include <experimental\impl\algorithm_impl.h>

_PSTL_NS1_BEGIN
namespace details
{
	const unsigned int TotalWorkStealingQueueNumber = 1024u; // It must be 2^n and greater than number of CPUs

	void freeWorkStealingQueueOnCurrentThread();

	class WorkStealingQueueFactory;
	class WorkStealingQueueSet;

	bool IsWindows7()
	{
#if !defined(WINAPI_FAMILY) || WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)
		enum _OsValueType { Win7, Initial, NonWin7 };

		static volatile _OsValueType _OsType = Initial;

		if (_OsType == Initial) {

			OSVERSIONINFOEX _osvi = {};
			_osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);

			// The Causality is supported on Windows version higher than Windows 8
			_osvi.dwMajorVersion = 6;
			_osvi.dwMinorVersion = 1;

			DWORDLONG _conditionMask = 0;
			VER_SET_CONDITION(_conditionMask, VER_MAJORVERSION, VER_EQUAL);
			VER_SET_CONDITION(_conditionMask, VER_MINORVERSION, VER_EQUAL);

			if (::VerifyVersionInfo(&_osvi, VER_MAJORVERSION | VER_MINORVERSION, _conditionMask))
			{
				_OsType = Win7;
				return true;
			}
			else {
				_OsType = NonWin7;
				return false;
			}
		}

		return _OsType == Win7;
#else
		return false;
#endif					
	}

	// The Workstealing queue is built on following 2 assumptions:
	// 1. Workload of each chore is relatively light
	// 2. Schedule method is invoked under relatively high volume
	// We try to reduce the amount of atomics and dependencies on relaxed memory model
	class WorkStealingQueue : public _Threadpool_chore
	{
		friend class WorkStealingQueueFactory;
		friend class WorkStealingQueueSet;
		friend void freeWorkStealingQueueOnCurrentThread();

		std::atomic<int> m_workstealingPosition;

		// QueueReset, QueueScheduled are 2 status indicate that the chore is ready to be rescheduled
		enum { QueueCreated, QueueReset, QueueScheduled } m_wsqStatus;

		// workstealing queue
		WorkChoreBase * m_topChore;
		std::atomic<WorkChoreBase *> m_rootChore;
		std::atomic<WorkChoreBase *> m_lastChore;

		// Scheduler
		static std::atomic<size_t> s_threadPoolRunning;
		static size_t s_concurrencyLevel;

		void updateStealingPoint()
		{
			// Update stealing point
			if (auto p = m_lastChore.load(std::memory_order_relaxed))
			{
				m_lastChore.store(nullptr, std::memory_order_relaxed);
				m_rootChore = p->m_next.load();
				// no other thread will ever touch this node
				p->m_next.store(nullptr, std::memory_order_relaxed);
			}
		}

		void injectThread()
		{
			if (m_wsqStatus != QueueScheduled)
			{
				m_topChore->m_next = nullptr;
				if (m_wsqStatus == QueueCreated)
					schedule_chore(this);
				else
					reschedule();
				m_wsqStatus = QueueScheduled;
			}
			else
				reschedule();

			++s_threadPoolRunning;
		}
	public:
		std::mt19937 randomGen;

		WorkStealingQueue() : m_workstealingPosition(-1)
		{
			m_wsqStatus = QueueCreated;
			reset();
		}

		~WorkStealingQueue()
		{
			// Leak the thread pool item during shutdown for Win7
			if (IsWindows7())
				_Work = nullptr;
		}

		void reset()
		{
			m_rootChore = m_topChore = nullptr;
			m_lastChore.store(nullptr, std::memory_order_relaxed);
			if (m_wsqStatus != QueueCreated)
				m_wsqStatus = QueueReset;
		}

		// threadpool callback
		virtual void __cdecl invoke() override;

		WorkChoreBase *tryStealChore(bool waitForPending = false)
		{
			WorkChoreBase * const PendingState = reinterpret_cast<WorkChoreBase *>(static_cast<intptr_t>(-1));

			WorkChoreBase *chore = m_rootChore.exchange(PendingState);

			// Busy waiting
			while (waitForPending && chore == PendingState)
			{
				details::yield();
				chore = m_rootChore;
				if (chore != PendingState)
					m_rootChore.compare_exchange_strong(chore, PendingState);
			}

			if (chore && chore != PendingState) // got an available chore
			{
				auto nextChore = chore->tryStealNextChore();

				// if nextChore == nullptr, m_rootChore will be kept as nullptr until someone reset it
				// from m_lastChore
				m_rootChore = nextChore;
				if (!nextChore)
					m_lastChore.store(chore, std::memory_order_relaxed); // The workstealing queue is empty, notify the queue owner
				return chore;
			}
			else
			{
				if (chore == nullptr)
				{
					chore = PendingState;
					m_rootChore.compare_exchange_strong(chore, nullptr);
				}
				return nullptr;
			}
		}


		void schedule(WorkChoreBase *chore)
		{
			// step 1 push chore
			chore->m_prev = m_topChore;
			if (m_topChore)
			{
				m_topChore = m_topChore->m_next = chore;

				updateStealingPoint();
			}
			else
			{
				m_rootChore = m_topChore = chore;
				_ASSERT(m_lastChore.load(std::memory_order_relaxed) == nullptr);
			}

			// step 2 spawn new thread if needed
			if (s_threadPoolRunning < s_concurrencyLevel)
				injectThread();
		}

		void setTopChoreBack(WorkChoreBase *chore)
		{
			// m_lastChore is always set by workstealingqueue owner
			// except during "tryStealChore", which can be set by other threads
			// with spin wait protection
			if (m_lastChore.load(std::memory_order_relaxed) == m_topChore)
				m_lastChore.store(chore, std::memory_order_relaxed);
			m_topChore = chore;
		}
	};

	class SRWLock
	{
		SRWLOCK m_locker;
	public:
		SRWLock() { InitializeSRWLock(&m_locker); }

		_Acquires_exclusive_lock_(this->m_locker) bool try_lock()
		{
			return TryAcquireSRWLockExclusive(&m_locker) != FALSE;
		}

		_Acquires_exclusive_lock_(this->m_locker) void lock()
		{
			AcquireSRWLockExclusive(&m_locker);
		}

		_Releases_exclusive_lock_(this->m_locker) void unlock()
		{
			ReleaseSRWLockExclusive(&m_locker);
		}
	};

	class WorkStealingQueueSet
	{
		WorkStealingQueue m_queuePool[TotalWorkStealingQueueNumber];
		// NOTE: when perf stability become an issue, we need to rewrite this 
		// WorkStealingQueue allocation from LIFO to FIFO.
		std::atomic<WorkStealingQueue *> m_queue[TotalWorkStealingQueueNumber];
		SRWLock m_mutex;
		std::atomic<int> m_top; // lock protected

	public:
		WorkStealingQueueSet() : m_top(0)
		{
			for (unsigned int i = 0; i < TotalWorkStealingQueueNumber; i++)
				m_queue[i] = m_queuePool + i;
		}

		WorkStealingQueue *alloc()
		{
			std::lock_guard<SRWLock> guard(m_mutex);
			int top = m_top.load(std::memory_order_relaxed);
			if (top >= TotalWorkStealingQueueNumber)
				return nullptr;
			auto wd = m_queue[top].load(std::memory_order_relaxed);
			wd->m_workstealingPosition.store(top, std::memory_order_relaxed);
			m_queue[top].store(wd, std::memory_order_relaxed);
			m_top.store(top + 1, std::memory_order_relaxed);
			return wd;
		}

		void free(WorkStealingQueue * wd)
		{
			wd->reset();
			std::lock_guard<SRWLock> guard(m_mutex);
			int pos = wd->m_workstealingPosition.load(std::memory_order_relaxed);
			auto top = m_top.load(std::memory_order_relaxed);
			if (--top != pos)
			{
				auto next = m_queue[top].load(std::memory_order_relaxed);
				m_queue[pos].store(next, std::memory_order_relaxed);
				m_queue[top].store(wd, std::memory_order_relaxed);
				next->m_workstealingPosition.store(pos, std::memory_order_relaxed);
			}
			m_top.store(top, std::memory_order_relaxed);
		}

		WorkChoreBase * tryRandomSteal(WorkStealingQueue *&lastTarget, std::mt19937 &randGen, int retry = 10)
		{
			WorkChoreBase * p = lastTarget->tryStealChore();

			while (p == nullptr && retry--) {
				// Without lock protection, this may access removed queue.
				// However, steal from a removed queue is fail safe.
				if (auto curTarget = m_queue[(lastTarget->m_workstealingPosition.load(std::memory_order_relaxed) + (randGen() & 0xFFFFFF)) % m_top.load(std::memory_order_relaxed)].load(std::memory_order_relaxed))
				{
					p = curTarget->tryStealChore();
					lastTarget = curTarget;
				}
			}

			return p;
		}
	};

	WorkStealingQueueSet g_wsqSet;
	std::atomic<size_t> WorkStealingQueue::s_threadPoolRunning = 0;
	size_t WorkStealingQueue::s_concurrencyLevel = get_hardware_concurrency() * 2;
	__declspec(thread) WorkStealingQueue * tls_threadLocalQueue = 0;


	inline WorkChoreBase *WorkChoreBase::tryStealNextChore()
	{
		return m_next.exchange(nullptr);
	}

	inline bool WorkChoreBase::tryClaimThisChore()
	{
		if (m_prev && m_prev->tryStealNextChore())
			return true;
		else
		{
			// Last chore on the workstealing queue cannot be claimed.
			// We have to steal it
			return getWorkStealingQueue()->tryStealChore(true) != nullptr;
		}
	}


	inline WorkStealingQueue *createWorkStealingQueueOnCurrentThread()
	{
		auto queue = g_wsqSet.alloc();
		tls_threadLocalQueue = queue;
		return queue;
	}

	inline void freeWorkStealingQueueOnCurrentThread()
	{
		auto p = tls_threadLocalQueue;
		if (p != nullptr)
		{
			tls_threadLocalQueue = nullptr;
			g_wsqSet.free(p);
		}
	}

	inline void WorkStealingQueue::invoke()
	{
		auto curQueue = createWorkStealingQueueOnCurrentThread();
		if (curQueue == nullptr)
			return;

		auto myQueue = this;
		while (auto chore = g_wsqSet.tryRandomSteal(myQueue, curQueue->randomGen))
		{
			curQueue->reset();
			chore->run(true);
		}
		freeWorkStealingQueueOnCurrentThread();
		--WorkStealingQueue::s_threadPoolRunning;
	}

	_EXP_IMPL TaskGroup::TaskGroup() : m_pendingChore(MaximalChoreNum), m_head(nullptr), m_tail(nullptr), m_choreCounter(0), m_needReleaseWSQ(false)
	{
		// This TaskGroup belong to workstealing queue on this thread
		m_queue = tls_threadLocalQueue;
		if (m_queue == nullptr)
		{
			m_needReleaseWSQ = true;
			m_queue = createWorkStealingQueueOnCurrentThread();
			if (!m_queue)
				throw std::bad_alloc();
		}
	}

	_EXP_IMPL void __cdecl TaskGroup::run(WorkChoreBase &work)
	{
		_ASSERT(work.m_taskGroup == nullptr);
		work.m_taskGroup = this;

		if (m_head)
		{
			m_tail = &work;
		}
		else
		{
			m_head = m_tail = &work;
		}

		// push work item to current workstealing queue
		m_queue->schedule(&work);

		if (++m_choreCounter >= MaximalChoreNum)
			throw bad_alloc();
	}

	_EXP_IMPL void __cdecl TaskGroup::wait()
	{
		if (m_tail == nullptr)
			return;

		auto p = m_tail;
		int inlinedChore = 0;
		while (p->tryClaimThisChore())
		{
			++inlinedChore;

			// correct the header for potential inline in user function
			m_queue->setTopChoreBack(p->m_prev);

			p->run(false);

			if (p == m_head)
				break;
			p = p->m_prev;
		}

		if (inlinedChore != m_choreCounter && (m_pendingChore -= MaximalChoreNum - m_choreCounter + inlinedChore) > 0)
		{
			m_event.wait();
		}

		// correct the header for next taskgroup
		m_queue->setTopChoreBack(m_head->m_prev);

		m_head = m_tail = nullptr;
	}

	_EXP_IMPL TaskGroup::~TaskGroup()
	{
		wait();
		if (m_needReleaseWSQ)
			freeWorkStealingQueueOnCurrentThread();
	}

	// isAsync indicates whether the chore is called by
	// a strealing thread or work-stealing queue owner thread
	inline void WorkChoreBase::run(bool isAsync)
	{
		// exception handling is not supported here.
		// we require functor nothrow
		userFunc();

		if (isAsync)
			m_taskGroup->finishAsync();
	}

	inline WorkStealingQueue *WorkChoreBase::getWorkStealingQueue()
	{
		_ASSERT(m_taskGroup);
		return m_taskGroup->m_queue;
	}
	}
_PSTL_NS1_END // std::experimental::parallel
