#ifndef __PTHREAD_H__
#define __PTHREAD_H__

#if defined(WIN32) || defined(__WIN32__)
  #ifdef __cplusplus
	#include <windows.h>
	#define MUTEX_TIME_OUT 55000L // 55 seconds //
	class ProcessMutexObj 
	{
	protected:
		HANDLE	m_object;
	public:
		ProcessMutexObj(	LPSECURITY_ATTRIBUTES pSA= 0,
							bool bInitialOwner= false,
							LPCTSTR pName= 0)
		{
			m_object = ::CreateMutex ( pSA, bInitialOwner, pName );
		}
		~ProcessMutexObj()
		{
		}
		bool Lock()
		{
			if(m_object == 0)
				return false;

			DWORD dwWaitResult=
				::WaitForSingleObject (	m_object,			// Handle of mutex object
										MUTEX_TIME_OUT);	// Five-second time-out
			switch (dwWaitResult)
			{
			case WAIT_OBJECT_0:
			  return true;

			// Cannot get mutex object ownership due to time-out
			case WAIT_TIMEOUT:
			  return false;

			// Got ownership of an abandoned mutex object
			case WAIT_ABANDONED:
			  return false;
			}
		}
		bool UnLock()
		{
			if(m_object == 0)
				return false;

			return ::ReleaseMutex(m_object);
		}
	};
	class MutexObj 
	{
	protected:
		CRITICAL_SECTION m_object;
	public:
		MutexObj()
		{
			::InitializeCriticalSection(&m_object);
		}
		~MutexObj()
		{
			::DeleteCriticalSection(&m_object);
		}
		bool Lock()
		{
			if(&m_object == 0)
				return false;

			printf("Locking : enter to critical section for object %x\n", (int)&m_object);
			::EnterCriticalSection(&m_object);
			return true;
		}
		bool UnLock()
		{
			if(&m_object == 0)
				return false;

			printf("Unlocking : leave to critical section for object %x\n", (int)&m_object);
			::LeaveCriticalSection(&m_object);
			return true;
		}
	};
	typedef MutexObj pthread_mutex_t;
	
	inline int pthread_mutex_lock(MutexObj *a)
	{
		if(a == 0)
			return EINVAL;

		return a->Lock();
	}
	inline int pthread_mutex_unlock(MutexObj *a)
	{
		if(a == 0)
			return EINVAL;

		return a->UnLock();
	}

	#define pthread_self() 0
  #endif
#else
	#error << Unknown OS with multi threads mechanism >>
#endif

#endif  /* __PTHREAD_H__ */
