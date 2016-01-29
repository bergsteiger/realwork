/*
 * $Id: AutoMutex.h,v 1.6 2005/06/03 05:35:45 grigorio Exp $
 */

#ifndef __AUTO_MUTEX_H__
#define __AUTO_MUTEX_H__ 1

#include <pthread.h>

class AutoMutex 
{
public :
	enum MutexStatus {
		msUnexist,
		msTryLock,
		msLocked,
		msInvalid,
		msDeadlock
	};
	
protected :
	pthread_mutex_t* m_mutex;
	MutexStatus m_status;

public:
	static unsigned m_in_number;
	static unsigned m_out_number;
	
	AutoMutex () 
		: m_mutex (0), m_status (msUnexist) {}
	AutoMutex ( pthread_mutex_t& pmut ) 
		: m_mutex (&pmut), m_status (msUnexist) {
		if ( m_mutex ) {
			m_status = msTryLock;
			m_in_number++;
			int ret = pthread_mutex_lock ( m_mutex );
			m_out_number++;
			
			if ( ret == EINVAL )
				m_status = msInvalid;
			else if ( ret == EDEADLK ) 
				m_status = msDeadlock;
			else m_status = msLocked;
		}
	}
	~AutoMutex () {
		if ( m_status == msLocked ) 			
			pthread_mutex_unlock ( m_mutex );		
	}
	inline MutexStatus status () const {
		return m_status;
	}
	static unsigned inNumber () {
		return m_in_number;
	}
	static unsigned outNumber () {
		return m_out_number;
	}
};


#endif

