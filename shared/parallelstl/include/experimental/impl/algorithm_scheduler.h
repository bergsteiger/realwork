#pragma once

#ifndef _ALGORITHM_SCHEDULER_H_
#define _ALGORITHM_SCHEDULER_H_

#include "defines.h"
#include <thread>

_PSTL_NS1_BEGIN
namespace details {

	class _Threadpool_chore
	{
	protected:
		friend _EXP_IMPL void __cdecl schedule_chore(_Threadpool_chore*);
		void *_Work; // Windows::System::Threading::WorkItemHandler^ or PTP_WORK

	public:
		bool is_scheduled() const throw()
		{
			return _Work != nullptr;
		}


		_Threadpool_chore() : _Work(nullptr) {}

		_Threadpool_chore(const _Threadpool_chore & _Other) : _Work(nullptr)
		{
			_ASSERT(!_Other._Work);
			(_Other._Work);
		}

		_EXP_IMPL virtual ~_Threadpool_chore();

		_EXP_IMPL void __cdecl reschedule();

		virtual void __cdecl invoke() = 0;
	};

	inline unsigned int get_hardware_concurrency()
	{
		unsigned int _Res = std::thread::hardware_concurrency();
		return _Res == 0 ? 1 : _Res;
	}

	_EXP_IMPL void __cdecl yield();

	_EXP_IMPL void __cdecl schedule_chore(_Threadpool_chore*);

	_EXP_IMPL unsigned int __cdecl get_current_thread_id();

}
_PSTL_NS1_END // std::experimental::parallel::details

#endif // _ALGORITHM_SCHEDULER_H_

