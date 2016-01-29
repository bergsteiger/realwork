//
// Common.cpp : implementation file
//

#include "ace/ACE.h"

#include "shared/Core/fix/mpcxc.h"

#include "Common.h"

namespace EndtTools {

static const char progress [4] = {'|', '/', '-', '\\'};

/////////////////////////////////////////////////////////////////////////////////////////////
// FileWriter implementation

FileWriter::FileWriter (const char* file_path) : m_file (0) {
	if (file_path) {
		m_file = mpcxc_fopen (file_path, "a");
	}
}

FileWriter::~FileWriter () {
	if (m_file) { 
		ACE_OS::fclose (m_file);
		m_file = 0;
	}
}

void FileWriter::write_empty () {
	ACE_OS::fprintf (m_file, "\n");
}

void FileWriter::write (const char* buffer, size_t num) {
	if (m_file && buffer) { 
		if (num) {
			ACE_OS::fprintf (m_file, "%d\n%s\n\n", num, buffer);
		} else {
			ACE_OS::fprintf (m_file, "%s\n\n", buffer);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////
// Log implementation

Log::Log (const char* path) : FileWriter (path) {
}

void Log::out (const char *str, ...) {
	FILE* handle = this->get_handle ();

	if (str && handle) {
		char buf [1024];

		va_list argp;
		va_start (argp, str);
		ACE_OS::vsprintf (buf, str, argp);
		va_end (argp);

		char time_str [32];

		ACE_OS::tzset ();
		time_t seconds_since_1970 = ACE_OS::time ();
		tm* tm_local_time = ACE_OS::localtime (&seconds_since_1970);
		ACE_OS::strftime (time_str, 31, "%a %b %d %Y %X", tm_local_time);
		ACE_OS::fprintf (handle, "%s: %s\n", time_str, buf);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////
// ProcessIndicator implementation

ProcessIndicator::~ProcessIndicator () { 
	this->show_runtime ();
}

void ProcessIndicator::init (unsigned long count, unsigned rate) {
	time_t start_time;
	time (&start_time);

	struct tm* _time = localtime (&start_time);
	m_start_time.set (_time->tm_hour, _time->tm_min, _time->tm_sec);

	this->set_count (count);
	this->set_update_rate (rate);
}

void ProcessIndicator::update (unsigned i, unsigned long cur_id) {
	if (m_iter % m_update_rate == 0 || i == m_count - 1) {
		this->calc (i);
	}
	if (cur_id) {
		ACE_OS::printf (" %c  %s - %ld%%, id: %ld\r", progress [m_pos], m_text.c_str (), m_proc, cur_id);
	} else {
		ACE_OS::printf (" %c  %s - %ld%%\r", progress [m_pos], m_text.c_str (), m_proc);
	}
	m_pos = (m_pos == 3)? 0 : m_pos + 1;
	++m_iter;
}

void ProcessIndicator::update_ (unsigned i) {
	if (m_iter % m_update_rate == 0 || i == m_count - 1) {
		this->calc (i);
	}

	if (m_proc != m_prev_proc || i == 0) {
		ACE_OS::printf ("%s: %ld%%\r", m_text.c_str (), m_proc);
		m_prev_proc = m_proc;
	}
}

void ProcessIndicator::start () {
	ACE_OS::printf ("%s%ld%%\r", m_text.c_str (), 0);
}

void ProcessIndicator::get_runtime () {
	time_t _time;
	time (&_time);                 
	struct tm* finish_time = localtime (&_time);
	m_rt.set (0, 0, 0);

	m_rt.m_sec = finish_time->tm_sec - m_start_time.m_sec;
	if (m_rt.m_sec < 0) {
		m_rt.m_sec += 60;
		--m_rt.m_min;
	}
	m_rt.m_min += finish_time->tm_min - m_start_time.m_min;
	if (m_rt.m_min < 0) {
		m_rt.m_min += 60;
		--m_rt.m_hour;
	}
	m_rt.m_hour += finish_time->tm_hour - m_start_time.m_hour;
	if (m_rt.m_hour < 0) {
		m_rt.m_hour += 24;
	}
}

void ProcessIndicator::show_runtime () {
	if (m_is_wo_rt == false) {
		this->get_runtime ();
		this->msg ("RT of '%s': %u h, %u min, %u sec", m_text.c_str (), m_rt.m_hour, m_rt.m_min, m_rt.m_sec);
	}
}

void ProcessIndicator::msg (const char *format_str, ...) {
	if (format_str) {
		char text_buf [1024] = {'\0'};

		va_list argp;
		{
			va_start (argp, format_str);
			ACE_OS::vsprintf (text_buf, format_str, argp);
		}
		va_end (argp);

		char time_buf [32] = {'\0'};

		ACE_OS::tzset ();
		time_t seconds_since_1970 = ACE_OS::time ();
		tm* tm_local_time = ACE_OS::localtime (&seconds_since_1970);
		ACE_OS::strftime (time_buf, 31, "%a %b %d %Y %X", tm_local_time); // GARANT_ACE

		char buf [1024] = {'\0'};
		ACE_OS::sprintf (buf, "%s: %s\n", time_buf, text_buf);

		if (m_log_path.empty () == false) {
			FileWriter (m_log_path.c_str ()).write (buf);
		}

		ACE_OS::printf (buf);
	} 
}

} // namespace
