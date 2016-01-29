//
// ThreadManager.h : header file
//

#ifndef __CONVERT_THREAD_MANAGER_H__
#define __CONVERT_THREAD_MANAGER_H__

#include "shared/Core/sys/std_inc.h"

#include "garantPIL/implementation/component/cpp/libs/endt/Common.h"
#include "stdbase.h"

namespace EndtConvertor {

	class ThreadManager {
	public:
		ThreadManager ();

	public:
		void init (const std::string& path, size_t thr_count);
		void execute (ACE_THR_FUNC thr_func, void* arg, size_t from, EndtTools::ProcessIndicator* progress);

		Base* make ();

		size_t get_pos ();

	public:
		typedef ACE_Singleton <ThreadManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <ThreadManager, ACE_SYNCH_RECURSIVE_MUTEX>;

	private:
		Core::Mutex m_mutex;

		std::string m_path;

		EndtTools::ProcessIndicator* m_progress;

		size_t m_pos;
		size_t m_count;
	};

} // namespace

#endif // #ifndef __CONVERT_THREAD_MANAGER_H__
