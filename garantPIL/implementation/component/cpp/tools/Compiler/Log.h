////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "Log.h"

#ifndef __COMPILER__COMPILE_LOG_H__
#define __COMPILER__COMPILE_LOG_H__

//#include "ace/ACE.h"
//#include "ace/Configuration.h"
//#include "shared/Core/sys/std_inc.h"

#include "advlog.h"

namespace Compiler {

	enum CodePage {cp_None, cp_Dos, cp_Koi, cp_Win, cp_Mac};

	class Log {
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	public:
		Log ();

		virtual ~Log ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		void init (const char* file_name, const char* cd_str);

		void out (AdvLogger::LogPriority pr, AdvLogger::Coding cd, const char* format_str, ...);

		void out (AdvLogger::LogPriority pr, const char* format_str, ...);

		void out_e (CodePage code_page, const char* format_str, ...);

		void out_w (AdvLogger::Coding cd, const char* format_str, ...) {
		}
		void out_i (AdvLogger::Coding cd, const char* format_str, ...) {
		}

	private:
		AdvLogger::Coding get_coding (const char* str) const;
		AdvLogger::Coding translate (CodePage value) const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		AdvLogger m_log;
	};

typedef ACE_Singleton <Log, ACE_SYNCH_RECURSIVE_MUTEX> LogSingleton;

} // namespace Compiler

#endif //__COMPILER__COMPILE_LOG_H__
