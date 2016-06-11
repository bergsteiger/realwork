// threadexc.cpp -- threads exception support functions
#include <new>


#include <string>
#include <utility>
#include <Dinkum/threads/exceptions>

namespace Dinkum
	{	// Dinkum Libraries
	namespace threads
		{	// Dinkum C++ Threads Library

void _Throw_lock_error()
	{	// throw lock_error exception
	_RAISE(lock_error());
	}

void _Throw_resource_error()
	{	// throw resource_error exception
	_RAISE(thread_resource_error());
	}

	}	// namespace threads
}	// namespace Dinkum

/*
 * This file is derived from software bearing the following
 * restrictions:
 *
 * (c) Copyright William E. Kempf 2001
 *
 * Permission to use, copy, modify, distribute and sell this
 * software and its documentation for any purpose is hereby
 * granted without fee, provided that the above copyright
 * notice appear in all copies and that both that copyright
 * notice and this permission notice appear in supporting
 * documentation. William E. Kempf makes no representations
 * about the suitability of this software for any purpose.
 * It is provided "as is" without express or implied warranty.
 */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
