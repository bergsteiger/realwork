#include <experimental\impl\event.h>
#include <Windows.h>

_PSTL_NS1_BEGIN
namespace details {
	static_assert(sizeof(SRWLOCK) == sizeof(intptr_t), "Space for SRWLOCK is not enough");
	static_assert(sizeof(CONDITION_VARIABLE) == sizeof(intptr_t), "Space for CONDITION_VARIABLE is not enough");

	_EXP_IMPL Event::Event() : m_isSet(false)
	{
		InitializeSRWLock(reinterpret_cast<PSRWLOCK>(&m_lock));
		InitializeConditionVariable(reinterpret_cast<PCONDITION_VARIABLE>(&m_cond));
	}

	_EXP_IMPL void __cdecl Event::wait()
	{
		AcquireSRWLockExclusive(reinterpret_cast<PSRWLOCK>(&m_lock));
		while (!m_isSet)
		{
			SleepConditionVariableSRW(reinterpret_cast<PCONDITION_VARIABLE>(&m_cond), reinterpret_cast<PSRWLOCK>(&m_lock),
				INFINITE, 0);
		}
		ReleaseSRWLockExclusive(reinterpret_cast<PSRWLOCK>(&m_lock));

	}

	_EXP_IMPL void __cdecl Event::set()
	{
		AcquireSRWLockExclusive(reinterpret_cast<PSRWLOCK>(&m_lock));
		m_isSet = true;
		WakeAllConditionVariable(reinterpret_cast<PCONDITION_VARIABLE>(&m_cond));
		ReleaseSRWLockExclusive(reinterpret_cast<PSRWLOCK>(&m_lock));
	}
} // std::experimental::parallel::details
_PSTL_NS1_END
