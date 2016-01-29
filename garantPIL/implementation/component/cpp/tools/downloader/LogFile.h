//
// LogFile.h : header file
//

#ifndef __DOWNLOAD_LOG_H__
#define __DOWNLOAD_LOG_H__

#include "shared/Core/sys/synch.h"
#include "shared/Core/sys/Logs.h"

#include <string>

class LogFile {
public:
	LogFile ();
	virtual ~LogFile ();

public:
	void set_extended (bool val);
	void open (const std::string& path);

	void out_t (UINT id);
	void out_t (CString& str);
	void out_t (const std::string& str);

	void out_t (const char* str, ...);
	void out_t_ext (const char* str, ...);

private:
	void out (UINT id);
	void out (const char* str, ...);

private:
	bool m_is_extended;

	FILE* m_file;

	Core::Mutex m_mutex;
};

typedef ACE_Singleton <LogFile, ACE_SYNCH_RECURSIVE_MUTEX> LogSingleton;

#define DLOG LogSingleton::instance ()

#endif // #ifndef __DOWNLOAD_LOG_H__
