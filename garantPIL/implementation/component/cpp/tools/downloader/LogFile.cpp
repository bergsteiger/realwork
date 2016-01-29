//
// LogFile.cpp: implementation file
//

#include "ace/ACE.h"
#include "ace/OS.h"

#include "resource.h"
#include "LogFile.h"

const size_t BUF_LEN = 2048; // ğàçìåğ áóôôåğà

LogFile::LogFile () : m_file (0), m_is_extended (false) {
}

LogFile::~LogFile () {
	if (m_file) { 
		if (ACE_OS::fclose (m_file) == 0) {
			m_file = 0;
		} 
	}
}

void LogFile::set_extended (bool val) {
	GUARD (m_mutex);
	m_is_extended = val;
}

void LogFile::open (const std::string& path) {
	if (path.empty () == false) {
		GUARD (m_mutex);
		m_file = ACE_OS::fopen (path.c_str (), "a");
		this->out (IDS_SESSION_LOG_DELIMITER);
	}
}

void LogFile::out (UINT id) {
   	CString str;
	str.LoadString (id);
	this->out (str.GetBuffer ());
}

void LogFile::out (const char* str, ...) {
	if (m_file) { 
		char buf [BUF_LEN];

		va_list argp;
		va_start (argp, str);
		ACE_OS::vsprintf (buf, str, argp);
		va_end (argp);

		GUARD (m_mutex);

		ACE_OS::fprintf (m_file, "%s\n", buf);
		ACE_OS::fflush (m_file);
	}
}

void LogFile::out_t (UINT id) {
	CString str;
	str.LoadString (id);
	this->out_t (str.GetBuffer ());
}

void LogFile::out_t (CString& str) {
	this->out_t (str.GetBuffer ());
}

void LogFile::out_t (const char* str, ...) {
	char buf [BUF_LEN];

	va_list argp;
	va_start (argp, str);
	ACE_OS::vsprintf (buf, str, argp);
	va_end (argp);

	char time_str [32];

	ACE_OS::tzset ();
	time_t seconds_since_1970 = ACE_OS::time ();
	tm* tm_local_time = ACE_OS::localtime (&seconds_since_1970);
	ACE_OS::strftime (time_str, 31, "%a %b %d %Y %X", tm_local_time);
	this->out ("%s: %s", time_str, buf);
}

void LogFile::out_t_ext (const char* str, ...) {
	if (m_is_extended) {
		char buf [BUF_LEN];

		va_list argp;
		va_start (argp, str);
		ACE_OS::vsprintf (buf, str, argp);
		va_end (argp);

		char time_str [32];

		ACE_OS::tzset ();
		time_t seconds_since_1970 = ACE_OS::time ();
		tm* tm_local_time = ACE_OS::localtime (&seconds_since_1970);
		ACE_OS::strftime (time_str, 31, "%a %b %d %Y %X", tm_local_time);
		this->out ("%s: %s", time_str, buf);
	}
}

void LogFile::out_t (const std::string& str) {
	this->out_t (str.c_str ());
}

// end of...
