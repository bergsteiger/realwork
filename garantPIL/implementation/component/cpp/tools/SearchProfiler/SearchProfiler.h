////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "SearchProfiler.h"

#ifndef __SEARCH_PROFILER_H__
#define __SEARCH_PROFILER_H__

#include "shared/Core/sys/std_inc.h"

namespace SearchProfiler {

	class Profiler {
	public:
		Profiler (const std::string& ini_file, bool is_etalon);

		virtual ~Profiler ();

	public:
		void execute ();

	private:
		void make_diff_file (const std::string& folder, std::ofstream& ofs);

	private:
		bool m_is_etalon;

		std::string m_root;
	};

} // namespace SearchProfiler

#endif //__SEARCH_PROFILER_H__
