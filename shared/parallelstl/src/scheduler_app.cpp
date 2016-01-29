#include <Windows.h>
#include <windows.foundation.h>
#include <windows.system.threading.h>
#include <windows.system.threading.core.h>
#include <functional>
#include <wrl\implements.h>
#include <wrl\event.h>
#include <new>
#include <utility>
#include <type_traits>
#include <thread>
#include <stdexcept>
#include <experimental/impl/algorithm_scheduler.h>

using namespace ABI::Windows::Foundation;
using namespace ABI::Windows::System::Threading;
using namespace ABI::Windows::System::Threading::Core;

using namespace Microsoft::WRL;
using namespace Microsoft::WRL::Wrappers;

_PSTL_NS1_BEGIN
namespace details {

	void _ThrowIfError(HRESULT _hr, const char * _message = "Scheduler Error")
	{
		if (_hr != S_OK) // Treats S_False as an error too.
		{
			char buffer[256];
			sprintf_s(buffer, "ERROR: %s, HRESULT: 0x%X\n", _message, _hr);

			throw std::runtime_error(buffer);
		}
	}

	class _ThreadpoolScheduler
	{
		ComPtr<IThreadPoolStatics> _M_ThreadPoolAPIs;

	public:
		_ThreadpoolScheduler()
		{
			_ThrowIfError(GetActivationFactory(HStringReference(RuntimeClass_Windows_System_Threading_ThreadPool).Get(), &_M_ThreadPoolAPIs),
				"Scheduler initialization failed");
		}

		ComPtr<IAsyncAction> _RunAsync(IWorkItemHandler *_Chore)
		{
			ComPtr<IAsyncAction> _Res;
			_ThrowIfError(_M_ThreadPoolAPIs->RunAsync(_Chore, &_Res), "Schedule chore on threadpool failed");
			return _Res;
		}
	} _SchedulerIns;

	_EXP_IMPL void __cdecl _Threadpool_chore::reschedule()
	{
		_SchedulerIns._RunAsync(static_cast<IWorkItemHandler*>(_Work));
	}

	_EXP_IMPL _Threadpool_chore::~_Threadpool_chore()
	{
		if (_Work) {
			static_cast<IWorkItemHandler*>(_Work)->Release();
			_Work = nullptr;
		}
	}

	_EXP_IMPL void __cdecl schedule_chore(_Threadpool_chore *_Chore)
	{
		_ASSERT(_Chore->_Work == nullptr);

		_Chore->_Work = Callback<Implements<RuntimeClassFlags<Delegate>, IWorkItemHandler, FtmBase>>([_Chore](IAsyncAction*) mutable -> HRESULT {
			_Chore->invoke();
			return S_OK;
		}).Detach();
		_Chore->reschedule();
	}

	_EXP_IMPL void __cdecl yield()
	{
		return std::this_thread::yield();
	}

	_EXP_IMPL unsigned int __cdecl get_current_thread_id()
	{
		return GetCurrentThreadId();
	}
} // std::experimental::parallel::details
_PSTL_NS1_END
