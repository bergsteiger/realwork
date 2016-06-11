/* atomic.c -- implement shared_ptr spin lock */
#include <yvals.h>

 #if _MULTI_THREAD
#include <xatomic.h>

volatile _Atomic_flag_t _Shared_ptr_flag;

void _Lock_shared_ptr_spin_lock()
	{	/* spin until _Shared_ptr_flag successfully set */
	while (_ATOMIC_FLAG_TEST_AND_SET(&_Shared_ptr_flag, memory_order_acquire))
		;
	}

void _Unlock_shared_ptr_spin_lock()
	{	/* release previously obtained lock */
	_ATOMIC_FLAG_CLEAR(&_Shared_ptr_flag, memory_order_release);
	}

 #else /* _MULTI_THREAD */
void _Lock_shared_ptr_spin_lock()
	{	/* spin until _Shared_ptr_flag successfully set */
	}

void _Unlock_shared_ptr_spin_lock()
	{	/* release previously obtained lock */
	}
 #endif /* _MULTI_THREAD */

_STD_END

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
