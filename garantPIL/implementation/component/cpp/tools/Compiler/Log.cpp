//
// Log.cpp : implementation file
//

#include "ace/ACE.h"

#include "Log.h"

namespace Compiler {

static const size_t BUF_SIZE = 4096; // 4K

////////////////////////////////////////////////////////////////////////////////////////////////////////////

Log::Log () {
}

Log::~Log () {
}

void Log::init (const char* file_name, const char* cd_str) {
	GDS_ASSERT (file_name);
	GDS_ASSERT (ACE_OS::strlen (file_name));

	m_log.setLogName (file_name);

	AdvLogger::Coding cd = this->get_coding (cd_str);

	if (cd) {
		m_log.setDestCoding (cd);
	} else {
		m_log.printf (AdvLogger::LOG_ERROR, "Unknown log encoding %s.\n", cd_str);
	}
}

AdvLogger::Coding Log::get_coding (const char* str) const {
	if (str) {
		if (ACE_OS::strcmp (str, "win") == 0) {
			return AdvLogger::CD_WIN;
		} else if (ACE_OS::strcmp (str, "koi") == 0) {
			return AdvLogger::CD_KOI;
		} else if (ACE_OS::strcmp (str, "dos") == 0) {
			return AdvLogger::CD_ALT;
		} else if (ACE_OS::strcmp (str, "mac") == 0) {
			return AdvLogger::CD_MAC;
		}
	}

	return AdvLogger::CD_NONE;
}

AdvLogger::Coding Log::translate (CodePage value) const {
	switch (value) {
		case cp_Dos:
			return AdvLogger::CD_ALT;
			break;
		case cp_Koi:
			return AdvLogger::CD_KOI;
			break;
		case cp_Win:
			return AdvLogger::CD_WIN;
			break;
		case cp_Mac:
			return AdvLogger::CD_MAC;
			break;
	}

	return AdvLogger::CD_NONE;
}

void Log::out (AdvLogger::LogPriority pr, AdvLogger::Coding cd, const char* format_str, ...) {
	if (format_str) {
		char buffer [BUF_SIZE];

		va_list argp;
		va_start (argp, format_str);
		ACE_OS::vsprintf (buffer, format_str, argp);
		va_end (argp);

		m_log.printfC (pr, cd, buffer);
	} 
}

void Log::out (AdvLogger::LogPriority pr, const char* format_str, ...) {
	if (format_str) {
		char buffer [BUF_SIZE];

		va_list argp;
		va_start (argp, format_str);
		ACE_OS::vsprintf (buffer, format_str, argp);
		va_end (argp);

		m_log.printf (pr, buffer);	
	} 
}

void Log::out_e (CodePage code_page, const char* format_str, ...) {
	if (format_str) {
		char buffer [BUF_SIZE];

		va_list argp;
		va_start (argp, format_str);
		ACE_OS::vsprintf (buffer, format_str, argp);
		va_end (argp);

		AdvLogger::Coding cd = this->translate (code_page);

		GDS_ASSERT (cd != AdvLogger::CD_NONE);

		m_log.noHdr ();
		m_log.printfC (AdvLogger::LOG_ERROR, cd, buffer);
	} 
}

}
