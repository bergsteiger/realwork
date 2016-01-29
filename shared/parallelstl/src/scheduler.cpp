#include <thread>
#include <Windows.h>
#include <experimental/impl/algorithm_scheduler.h>

_PSTL_NS1_BEGIN
namespace details {

	void CALLBACK scheduler_callback(PTP_CALLBACK_INSTANCE, PVOID _Args, PTP_WORK)
	{
		_Threadpool_chore *_Work = static_cast<_Threadpool_chore *>(_Args);
		_Work->invoke();
	}

	void __cdecl yield()
	{
		::SwitchToThread();
	}

	_EXP_IMPL _Threadpool_chore::~_Threadpool_chore()
	{
		if (_Work != nullptr) {
			::CloseThreadpoolWork(static_cast<PTP_WORK>(_Work));
			_Work = nullptr;
		}
	}

	_EXP_IMPL void __cdecl _Threadpool_chore::reschedule()
	{
		::SubmitThreadpoolWork(static_cast<PTP_WORK>(_Work));
	}

	_EXP_IMPL void __cdecl schedule_chore(_Threadpool_chore* _Chore)
	{
		_ASSERT(_Chore->_Work == nullptr);
		_Chore->_Work = ::CreateThreadpoolWork(scheduler_callback, _Chore, NULL);
		::SubmitThreadpoolWork(static_cast<PTP_WORK>(_Chore->_Work));
	}

	_EXP_IMPL unsigned int __cdecl get_current_thread_id()
	{
		return GetCurrentThreadId();
	}
} // std::experimental::parallel::details
_PSTL_NS1_END

