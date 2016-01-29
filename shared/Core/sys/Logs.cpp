////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/Logs.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::Logs
// Файл реализации утилитного набора Logs
//
// макросы вывода в лог
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"

//#UC START# *450E97E40167_CUSTOM_INCLUDES*
#include "shared/Core/sys/synch.h"
#include "boost/regex.hpp"
//#UC END# *450E97E40167_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *450E97E40167*
static unsigned char g_curent_format_set = 0;

void select_log_format_set (LogFormatsId id) {
	switch (id) {
	case LFI_FULL:
		g_curent_format_set = 0;
		break;
	case LFI_DEBUG_MP:
		g_curent_format_set = 1;
		break;
	case LFI_DEBUG_MT:
		g_curent_format_set = 2;
		break;
	case LFI_SILENT:
		g_curent_format_set = 3;
		break;
	}
}

static const LogFormatStrs G_FORMATS [] = {
	{
		"%D[%P, %t] -%M: "
		, "%D[%P, %t] -CORBA_EX: "
		, "%D[%P, %t] -STD_EX: "
		, "%D[%P, %t] -UNKNOWN_EX: "
	}
	, {
		"[%P, %t] -%M: "
		, "[%P, %t] -CORBA_EX: "
		, "[%P, %t] -STD_EX: "
		, "[%P, %t] -UNKNOWN_EX: "
	}
	, {
		"[%t] -%M: "
		, "[%t] -CORBA_EX: "
		, "[%t] -STD_EX: "
		, "[%t] -UNKNOWN_EX: "
	}
	, {
		""
		, ""
		, ""
		, ""
	}
};

const LogFormatStrs& current_log_format () {
	return G_FORMATS[g_curent_format_set];
}

#define FORMAT_BUF_SIZE 1024

#define ACE_LOG_WRAPPER \
	int __ace_error = ACE_OS::last_error ();\
	ACE_Log_Msg *ace___ = ACE_Log_Msg::instance ();\
	ace___->conditional_set (__FILE__, __LINE__, -1, __ace_error);\
	u_long priority_mask = ace___->priority_mask ();\
	ace___->priority_mask (priority_mask | LM_GARANT);\
	size_t len = strlen (format_str);\
	assert (len<FORMAT_BUF_SIZE);\
	if (len > FORMAT_BUF_SIZE - current_log_format ().LOG.len - 2) \
		len = FORMAT_BUF_SIZE - current_log_format ().LOG.len - 2; \
	char format_buf [FORMAT_BUF_SIZE];\
	memcpy (format_buf, current_log_format ().LOG.str, current_log_format ().LOG.len);\
	memcpy (format_buf + current_log_format ().LOG.len, format_str, len);\
	memcpy (format_buf + current_log_format ().LOG.len + len, "\n", 2);\
	va_list argp;\
		va_start (argp, format_str);\
		ace___->log (format_buf, log_priority,argp);\
	ace___->priority_mask (priority_mask);\
	va_end (argp);

#define ACE_SLOG_WRAPPER \
	int __ace_error = ACE_OS::last_error ();\
	ACE_Log_Msg *ace___ = ACE_Log_Msg::instance ();\
	ace___->conditional_set (__FILE__, __LINE__, -1, __ace_error);\
	u_long priority_mask = ace___->priority_mask ();\
	ace___->priority_mask (priority_mask | LM_GARANT);\
	size_t len = strlen (format_str);\
	unsigned long stack_len = SLogShifter::stack_len ();\
	assert (len + stack_len < FORMAT_BUF_SIZE);\
	if (len + stack_len > FORMAT_BUF_SIZE - current_log_format ().LOG.len - 2) \
		len = FORMAT_BUF_SIZE - current_log_format ().LOG.len - 2 - stack_len;\
	char format_buf [FORMAT_BUF_SIZE];\
	memcpy (format_buf, current_log_format ().LOG.str, current_log_format ().LOG.len);\
	memset (format_buf+current_log_format ().LOG.len, '\t', stack_len);\
	memcpy (format_buf+current_log_format ().LOG.len+stack_len, format_str, len);\
	memcpy (format_buf+current_log_format ().LOG.len+stack_len+len, "\n", 2);\
	va_list argp;\
		va_start (argp, format_str);\
		ace___->log (format_buf, log_priority,argp);\
	ace___->priority_mask (priority_mask);\
	va_end (argp);


void log_error (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_ERROR; 
	ACE_LOG_WRAPPER	
}

void log_warning (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_WARNING; 
	ACE_LOG_WRAPPER	
}

void log_info (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_INFO; 
	ACE_LOG_WRAPPER	
}

void log_debug (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_DEBUG; 
	ACE_LOG_WRAPPER	
}

void log_trace (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_TRACE; 
	ACE_LOG_WRAPPER	
}

void slog_debug (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_DEBUG; 
	ACE_SLOG_WRAPPER	
}

void log_fatal (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_MAX; 
	ACE_LOG_WRAPPER	
	abort();
}

void log_alert (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_ALERT; 
	ACE_LOG_WRAPPER	
}

void log_garant (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = static_cast <ACE_Log_Priority> (LM_GARANT); 
	ACE_LOG_WRAPPER	
}

void log_unknown_exception (const ACE_TCHAR *format_str, ...) { 
	ACE_Log_Priority log_priority = LM_ERROR; 
	int __ace_error = ACE_OS::last_error ();
	ACE_Log_Msg *ace___ = ACE_Log_Msg::instance ();
	ace___->conditional_set (__FILE__, __LINE__, -1, __ace_error);
	
	size_t len = strlen (format_str);

	if (len > FORMAT_BUF_SIZE - current_log_format ().UEX.len - 2) 
		len = FORMAT_BUF_SIZE - current_log_format ().UEX.len - 2;

	char format_buf [FORMAT_BUF_SIZE];

	memcpy (format_buf, current_log_format ().UEX.str, current_log_format ().UEX.len);
	memcpy (format_buf+current_log_format ().UEX.len, format_str, len);
	memcpy (format_buf+current_log_format ().UEX.len+len, "\n", 2);

	va_list argp;
		va_start (argp, format_str);
		ace___->log (format_buf, log_priority,argp);
	va_end (argp);
}

void log_std_exception (const std::exception& ex, const ACE_TCHAR *format_str, ...) { 
	int __ace_error = ACE_OS::last_error ();
	ACE_Log_Msg *ace___ = ACE_Log_Msg::instance ();
	ace___->conditional_set (__FILE__, __LINE__, -1, __ace_error);
	size_t ex_len = strlen(ex.what());
	size_t len = strlen (format_str);
	
	char* sex_format_buf = new char[current_log_format ().SEX.len + ex_len + len + 2 + 3];

	memcpy (sex_format_buf, current_log_format ().SEX.str, current_log_format ().SEX.len);
	memcpy (sex_format_buf+current_log_format ().SEX.len, ex.what(), ex_len);
	sex_format_buf[current_log_format ().SEX.len+ex_len] = ':';
	sex_format_buf[current_log_format ().SEX.len+ex_len+1] = ' ';
	memcpy (sex_format_buf+current_log_format ().SEX.len+ex_len+2, format_str, len);
	memcpy (sex_format_buf+current_log_format ().SEX.len+ex_len+2+len, "\n", 2);
	sex_format_buf[current_log_format ().SEX.len+ex_len+2+len+2] = 0;
	
	va_list argp;
		va_start (argp, format_str);
		ace___->log (sex_format_buf, LM_ERROR, argp);
	va_end (argp);
	delete [] sex_format_buf;
}

const char* gds_current_function (const char* signature) {
	typedef std::map <std::string, std::string> NameMap;

	static NameMap name_map;
	static RWMutex mutex;

	{
		READ_GUARD (mutex);
		NameMap::const_iterator it = name_map.find (signature);
		if (it != name_map.end ()) {
			return it->second.c_str ();
		}
	}
	
	static boost::regex expression ("\\w+(<.*>)?::~?\\w+\\(");
	boost::match_results<const char*> what;

	std::pair <std::string, std::string> value (
		signature
		, boost::regex_search (signature, what, expression, boost::match_default)
			? std::string (what[0].first, what[0].second - 1)  // minus 1: to exclude '(' from result
			: signature
	);
	
	{
		WRITE_GUARD (mutex);
		std::pair<NameMap::iterator, bool> result = name_map.insert (value);
		return result.first->second.c_str ();
	}
}


//#UC END# *450E97E40167*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

