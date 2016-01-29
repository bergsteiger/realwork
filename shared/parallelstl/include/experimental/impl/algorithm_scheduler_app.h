#pragma once

#ifndef _ALGORITHM_SCHEDULER_APP_H_
#define _ALGORITHM_SCHEDULER_APP_H_

#include "defines.h"

namespace std {
	namespace experimental {
		namespace parallel {
			namespace details {

				class _Threadpool_chore
				{
				protected:
					friend _EXP_IMPL void __cdecl schedule_chore(_Threadpool_chore*);
					void *_Work; // Windows::System::Threading::WorkItemHandler^

				public:
					bool is_scheduled() const throw()
					{
						return _Work != nullptr;
					}

					// The initial _RunningCounter should be 1 as _CompEvent holds one reference on it
					// When _CompEvent being set, the reference will be released
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

				_EXP_IMPL void __cdecl yield();

				_EXP_IMPL void __cdecl schedule_chore(_Threadpool_chore*);

				_EXP_IMPL size_t __cdecl get_current_thread_id();

			} // std::experimental::parallel::details
		}
	}
}

#endif // _ALGORITHM_SCHEDULER_APP_H_
