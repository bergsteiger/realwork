//
// Common.cpp : implementation file
//

#include "ace/OS.h"

#include <cstdlib>
#include <cstdarg>
#include <cstring>

#include "common.h"

void set_date_time_buffer (char* buf) {
	ACE_OS::tzset ();
	time_t seconds_since_1970 = ACE_OS::time ();
	tm* tm_local_time = ACE_OS::localtime (&seconds_since_1970);
	ACE_OS::strftime (buf, 31, "%a %b %d %Y %X", tm_local_time); // GARANT_ACE
}

void __message (const char *buf, const bool is_console, const bool is_log) {
	char time_buf [32] = {'\0'};
	set_date_time_buffer (time_buf);

	char msg_buf [1024] = {'\0'};
	ACE_OS::sprintf (msg_buf, "%s: %s\n", time_buf, buf);

	if (is_console) {
		ACE_OS::printf (msg_buf);
	} 

	if (is_log) {
		FILE* log_file = mpcxc_fopen ("EndtConvertor.log", "a");
		if (log_file) { 
			ACE_OS::fprintf (log_file, msg_buf);
			ACE_OS::fclose (log_file);
		}
	}
}

void _msg (const char *format_str, ...) {
	if (format_str) {
		char buf [1024] = {'\0'};
		va_list argp;
		va_start (argp, format_str);
		ACE_OS::vsprintf (buf, format_str, argp);
		va_end (argp);
		__message (buf, true, true);
	} 
}

void _msg_console (const char *format_str, ...) {
	if (format_str) {
		char buf [1024] = {'\0'};
		va_list argp;
		va_start (argp, format_str);
		ACE_OS::vsprintf (buf, format_str, argp);
		va_end (argp);
		__message (buf, true, false);
	} 
}

void _msg_log (const char *format_str, ...) {
	if (format_str) {
		char buf [1024] = {'\0'};
		va_list argp;
		va_start (argp, format_str);
		ACE_OS::vsprintf (buf, format_str, argp);
		va_end (argp);
		__message (buf, false, true);
	} 
}

//////////////////////////////////////////////////////////////////////////////////////


PictList::PictList () { 
}

void PictList::add (unsigned doc_id, long obj_id) {
	GUARD (m_mutex);
	m_data [doc_id].insert (obj_id);
}

void PictList::write (const char* file_name) {
	if (m_data.empty () == false) {
		FILE* file = ACE_OS::fopen (file_name, "a");

		if (file) {
			char time_buf [32];
			set_date_time_buffer (time_buf);

			for (DocPicList::const_iterator it = m_data.begin (); it != m_data.end (); ++it) {
				this->write (file, it->first, it->second, time_buf);
			}

			ACE_OS::fclose (file);
		}
	}
}

void PictList::write (FILE* file, unsigned doc_id, const DataSet& data, const char* time_buf) {
	for (DataSet::const_iterator it = data.begin (); it != data.end (); ++it) {
		ACE_OS::fprintf (file, "%s: obj_id: %ld, doc_id: %ld\n", time_buf, *it, doc_id);
	}
}


