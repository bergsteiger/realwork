////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/GDS/MemoryWatcher.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::GDS::MemoryWatcher
//
// класс профайлинга использования памяти
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_GDS_MEMORYWATCHER_H__
#define __SHARED_CORE_GDS_MEMORYWATCHER_H__

#include "ace/ACE.h"
#include "shared/Core/fix/PragmaWarningDisable.h"

//#UC START# *450E987A0251_USER_INCLUDES*
#include "shared/Core/sys/start_stop.h"
#include "ace/Singleton.h"
#include "ace/Synch.h"

#if defined (_MSC_VER) && (_MSC_VER >= 1200) && defined (_DEBUG)
#include <assert.h>
#include <crtdbg.h>
#include <malloc.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <map>
#else
#include "ace/Basic_Types.h" // GARANT_GCC
#endif
//#UC END# *450E987A0251_USER_INCLUDES*

namespace Core {
namespace GDS {

//#UC START# *450E987A0251_USER_DEFINITION*

const unsigned long SIZED_ALLOC_COUNT_BORDER = 4098;

#if defined (_MSC_VER) && (_MSC_VER >= 1200) && defined (_DEBUG)

class MemoryWatcher {
	friend int Core::init ();
	typedef ACE_Singleton <MemoryWatcher, ACE_SYNCH_RECURSIVE_MUTEX> MemoryWatcherSingleton;

public:
	typedef unsigned long SizedAllocCountArray [SIZED_ALLOC_COUNT_BORDER + 2];

public:
	static const unsigned __int64 alloc_call_count () {
		return MemoryWatcherSingleton::instance ()->m_alloc_call_count;
	}

	static const unsigned __int64 realloc_call_count () {
		return MemoryWatcherSingleton::instance ()->m_realloc_call_count;
	}

	static const unsigned __int64 free_call_count () {
		return MemoryWatcherSingleton::instance ()->m_free_call_count;
	}

	static const unsigned __int64 allocated_size () {
		return MemoryWatcherSingleton::instance ()->m_allocated_size;
	}

	static const unsigned __int64 allocated_size_peak () {
		return MemoryWatcherSingleton::instance ()->m_allocated_size_peak;
	}

	static const unsigned __int64 through_allocated_size () {
		return MemoryWatcherSingleton::instance ()->m_through_allocated_size;
	}

	static const SizedAllocCountArray& sized_alloc_count () {
		return MemoryWatcherSingleton::instance ()->m_sized_alloc_count;
	}

	static void save_state (unsigned int state_number) {
		MemoryWatcherSingleton::instance ()->m_memory_states[state_number] = allocated_size ();
	}

	static void dump_diff_with_state (FILE* to_dump, unsigned int state_number) {
		assert (MemoryWatcherSingleton::instance ()->m_memory_states.end () != MemoryWatcherSingleton::instance ()->m_memory_states.find (state_number));
		unsigned __int64 cur = allocated_size ();
		unsigned __int64 prev = MemoryWatcherSingleton::instance ()->m_memory_states[state_number];
		if (cur > prev) {
			assert (0xFFFFFFFF >= (cur-prev));
			fprintf (to_dump, "Memory diff DEBUG : %llu\n", cur-prev);
		} else {
			assert (0xFFFFFFFF >= (prev-cur));
			fprintf (to_dump, "Memory diff DEBUG : -%llu\n", prev-cur);
		}
	}

private:
	static int _cdecl crt_alloc_hook (int a_alloc_type, void* a_data, size_t a_size, int a_block_use, long a_request, const unsigned char* a_file_name, int a_line) {
		try {
			int l_result = (MemoryWatcherSingleton::instance ()->m_crt_alloc_hook != 0) ? (MemoryWatcherSingleton::instance ()->m_crt_alloc_hook (a_alloc_type, a_data, a_size, a_block_use, a_request, a_file_name, a_line)) : (1);
			if ((l_result != 0) && (a_block_use != _CRT_BLOCK)) {
				switch (a_alloc_type) {
					case _HOOK_ALLOC: {
						++MemoryWatcherSingleton::instance ()->m_alloc_call_count;
						MemoryWatcherSingleton::instance ()->increment_allocated_size (a_size);
					} break;
					case _HOOK_REALLOC: {
						++MemoryWatcherSingleton::instance ()->m_realloc_call_count;
						MemoryWatcherSingleton::instance ()->decrement_allocated_size (_msize (a_data));
						MemoryWatcherSingleton::instance ()->increment_allocated_size (a_size);
					} break;
					case _HOOK_FREE: {
						++MemoryWatcherSingleton::instance ()->m_free_call_count;
						MemoryWatcherSingleton::instance ()->decrement_allocated_size (_msize (a_data));
					} break;
					default: {
						assert (false);
					} break;
				}
			}
			return l_result;
		} catch (...) {
			return 0; // disable warning like `not all control paths return a value`; this line never to be executed
		}
	}
public:
	MemoryWatcher () : 
	  m_allocated_size (0)
	  , m_allocated_size_peak (0)
	  , m_alloc_call_count (0)
	  , m_realloc_call_count (0)
	  , m_free_call_count (0)
	  , m_through_allocated_size (0) {
		m_crt_alloc_hook = _CrtSetAllocHook (crt_alloc_hook);
		memset(m_sized_alloc_count, 0, (SIZED_ALLOC_COUNT_BORDER + 2)*sizeof(unsigned long));
	}

	~MemoryWatcher () {
		if (m_crt_alloc_hook != 0) {
			_CrtSetAllocHook (m_crt_alloc_hook);
		}

		for (unsigned long i = 0; i < SIZED_ALLOC_COUNT_BORDER + 2; i++) {
			if (m_sized_alloc_count[i]) {
				unsigned long alloc_size = i;
				if (i <= SIZED_ALLOC_COUNT_BORDER) {
					fprintf (stderr, "%u size allocated count:\t%u\n", i, m_sized_alloc_count[i]);
				} else {
					fprintf (stderr, ">%u size allocated count:\t%u\n", SIZED_ALLOC_COUNT_BORDER, m_sized_alloc_count[i]);					
				}
			}
		}
	}
private:
	inline void increment_allocated_size (const unsigned __int64 a_size) {
		m_allocated_size += a_size;
		m_allocated_size_peak = __max (m_allocated_size_peak, m_allocated_size);

		m_through_allocated_size += a_size;
		if (a_size <= SIZED_ALLOC_COUNT_BORDER) {
			m_sized_alloc_count[a_size]++;
		} else {
			m_sized_alloc_count[SIZED_ALLOC_COUNT_BORDER + 1]++;
		}
	}

	inline void decrement_allocated_size (const unsigned __int64 a_size) {
		m_allocated_size -= a_size;
	}
private:
	unsigned __int64 m_alloc_call_count;
	unsigned __int64 m_realloc_call_count;
	unsigned __int64 m_free_call_count;
	unsigned __int64 m_allocated_size;
	unsigned __int64 m_allocated_size_peak;
	unsigned __int64 m_through_allocated_size;
	SizedAllocCountArray m_sized_alloc_count;

	typedef std::map<unsigned int, unsigned __int64> MemoryStates;
	MemoryStates m_memory_states;

	_CRT_ALLOC_HOOK m_crt_alloc_hook;
}; // class MemoryWatcher

#else // defined (_MSC_VER) && (_MSC_VER >= 1200) && defined (_DEBUG)

class MemoryWatcher {
public:
public:
	static const ACE_UINT64 alloc_call_count () {
		return 0;
	}

	static const ACE_UINT64 realloc_call_count () {
		return 0;
	}

	static const ACE_UINT64 free_call_count () {
		return 0;
	}

	static const ACE_UINT64 allocated_size () {
		return 0;
	}

	static const ACE_UINT64 allocated_size_peak () {
		return 0;
	}

	static const ACE_UINT64 through_allocated_size () {
		return 0;
	}
};

#endif //_DEBUG

//#UC END# *450E987A0251_USER_DEFINITION*

} // namespace GDS
} // namespace Core


#endif //__SHARED_CORE_GDS_MEMORYWATCHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
