#pragma once

#ifndef _IMPL_TASKGROUP_H_
#define _IMPL_TASKGROUP_H_

#include <atomic>
#include <mutex>
#include <random>
#include <limits>
#include <list>
#include <type_traits>
#include "event.h"
#include "algorithm_impl.h"

_PSTL_NS1_BEGIN
namespace details
{
	class WorkStealingQueue;
	class TaskGroup;

	class WorkChoreBase
	{
		TaskGroup *m_taskGroup;
		WorkChoreBase *m_prev;
		std::atomic<WorkChoreBase*> m_next;
		friend class TaskGroup;
		friend class WorkStealingQueue;

		inline void run(bool isAsync);

		inline WorkChoreBase * tryStealNextChore();

		inline bool tryClaimThisChore();

		inline WorkStealingQueue * getWorkStealingQueue();

	protected:
		virtual void __cdecl userFunc() = 0;
		WorkChoreBase() : m_prev(nullptr), m_taskGroup(nullptr)
		{
			_ASSERT(m_next.load() == nullptr);
		}
	};

	template <typename Func>
	class UserWorkChore : public WorkChoreBase
	{
		Func m_userFunc;
	protected:
		virtual void __cdecl userFunc() override
		{
			m_userFunc();
		}
	public:
		UserWorkChore(const Func &userFunc) : m_userFunc(userFunc) {}
		UserWorkChore(UserWorkChore &&right) : WorkChoreBase(std::move(right)), m_userFunc(std::move(right.m_userFunc)) {}
	};

	template <typename Func>
	inline UserWorkChore<std::decay_t<Func>> make_task(Func &&func)
	{
		return UserWorkChore<std::decay_t<Func>>(std::forward<Func>(func));
	}

	class TaskGroup
	{
		static const int MaximalChoreNum = INT_MAX - 1; // preventing overflow

		WorkChoreBase *m_head, *m_tail;
		WorkStealingQueue *m_queue;
		int m_choreCounter;
		bool m_needReleaseWSQ;
		std::atomic<int> m_pendingChore;
		Event m_event;

		friend class WorkChoreBase;

		void finishAsync()
		{
			if (--m_pendingChore == 0)
			{
				m_event.set();
			}
		}

	public:
		_EXP_IMPL TaskGroup();

		TaskGroup(const TaskGroup &) = delete;
		TaskGroup &operator =(const TaskGroup &) = delete;

		_EXP_IMPL ~TaskGroup();
		_EXP_IMPL void __cdecl run(WorkChoreBase &work);
		_EXP_IMPL void __cdecl wait();
	};
}
_PSTL_NS1_END // std::experimental::parallel

#endif // _IMPL_TASKGROUP_H_
