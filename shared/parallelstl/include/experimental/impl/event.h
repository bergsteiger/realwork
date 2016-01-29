#pragma once
#ifndef _IMPL_EVENT_H
#define _IMPL_EVENT_H

#include <cstdint>
#include <functional>
#include <atomic>
#include "defines.h"

_PSTL_NS1_BEGIN
namespace details {
	class Event
	{
		intptr_t m_lock;
		intptr_t m_cond;
		bool m_isSet;
	public:
		Event(const Event &) = delete;
		Event &operator =(const Event &) = delete;
		_EXP_IMPL Event();
		_EXP_IMPL void __cdecl wait();
		_EXP_IMPL void __cdecl set();
	};

	// The completin Event will never be reset
	class CompletionEvent
	{
		std::atomic<size_t> m_counter;
		Event m_event;
	public:
		CompletionEvent(size_t cnt) : m_counter(cnt) {}

		void wait()
		{
			m_event.wait();
		}

		size_t completeOne()
		{
			auto cnt = --m_counter;
			if (cnt != 0)
				return cnt;

			_ASSERTE(cnt >= 0);
			m_event.set();
			return 0;
		}

		size_t addOne()
		{
			return ++m_counter;
		}
	};
}
_PSTL_NS1_END

#endif
