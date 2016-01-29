////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "SearchProfiler.h"

#ifndef __THREAD_MANAGER_H__
#define __THREAD_MANAGER_H__

#include "shared/Core/sys/std_inc.h"

#include "ROCBase.h"

namespace SearchProfiler {

	static const std::string ctx_ext = ".ctx";
	static const std::string oth_ext = ".oth";

	class ThreadManager {
	public:
		static void execute (
			const std::string& root
			, const std::string& rt_file
			, const std::string& path
			, const std::string& ext
		);

	public:
		typedef ACE_Singleton <ThreadManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <ThreadManager, ACE_SYNCH_RECURSIVE_MUTEX>;
	};

} // namespace SearchProfiler

#endif //__THREAD_MANAGER_H__