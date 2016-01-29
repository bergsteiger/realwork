////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/sys/Logs.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::sys::Logs
// Файл реализации утилитного набора Logs
//
// расширение работы с Логами для CORBA
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/sys/Logs.h"

//#UC START# *45FF9E0B031C_CUSTOM_INCLUDES*
//#UC END# *45FF9E0B031C_CUSTOM_INCLUDES*

namespace CoreSrv {

//#UC START# *45FF9E0B031C*

void log_corba_exception (const CORBA::Exception& ex, const ACE_TCHAR *format_str, ...) { 
	int __ace_error = ACE_OS::last_error ();
	ACE_Log_Msg *ace___ = ACE_Log_Msg::instance ();
	ace___->conditional_set (__FILE__, __LINE__, -1, __ace_error);

	size_t ex_len = strlen(ex._rep_id());
	size_t len = strlen (format_str);
	
	char* cex_format_buf = new char[Core::current_log_format ().CEX.len + ex_len + len + 2 + 3];

	memcpy (cex_format_buf, Core::current_log_format ().CEX.str, Core::current_log_format ().CEX.len);
	memcpy (cex_format_buf+Core::current_log_format ().CEX.len, ex._rep_id(), ex_len);
	cex_format_buf[Core::current_log_format ().CEX.len+ex_len] = ':';
	cex_format_buf[Core::current_log_format ().CEX.len+ex_len+1] = ' ';
	memcpy (cex_format_buf+Core::current_log_format ().CEX.len+ex_len+2, format_str, len);
	memcpy (cex_format_buf+Core::current_log_format ().CEX.len+ex_len+2+len, "\n", 2);
	cex_format_buf[Core::current_log_format ().CEX.len+ex_len+2+len+2] = 0;
	
	va_list argp;
		va_start (argp, format_str);
		ace___->log (cex_format_buf, LM_ERROR, argp);
	va_end (argp);
	delete [] cex_format_buf;
}

//#UC END# *45FF9E0B031C*

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

