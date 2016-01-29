////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/Logs.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::Logs
//
// макросы вывода в лог
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_LOGS_H__
#define __SHARED_CORE_SYS_LOGS_H__

#include "ace/ACE.h"
#include "shared/Core/sys/AtomicOp.h"

//#UC START# *450E97E40167_USER_INCLUDES*
#include <string>
#include "boost/current_function.hpp"
#include "ace/Singleton.h"
#include "ace/Log_Msg.h"
#include "ace/OS.h"
//#UC END# *450E97E40167_USER_INCLUDES*

namespace Core {

//#UC START# *450E97E40167_USER_DEFINITION*

enum LogFormatsId {
	LFI_FULL
	, LFI_DEBUG_MP
	, LFI_DEBUG_MT
	, LFI_SILENT	
};

void select_log_format_set (LogFormatsId id);

struct LogFormatStr {
	LogFormatStr (const char* _str) : str (_str), len (strlen(str)) {		
	}
	const char* str;
	size_t len;
};

struct LogFormatStrs {
	LogFormatStr LOG;
	LogFormatStr CEX;
	LogFormatStr SEX;
	LogFormatStr UEX;
};

const LogFormatStrs& current_log_format ();

class SLogShifter {
	struct Atomic_ULongInit {
		Atomic_ULongInit () {
			value = 0;
		}
		Core::AtomicOp <long> value;
	};

	typedef ACE_Singleton <Atomic_ULongInit, ACE_Recursive_Thread_Mutex> StackShift; // GAARNT_USL (Unix Static Linkage)

public:
	SLogShifter () {
		StackShift::instance()->value++;
	}
	~SLogShifter () {
		StackShift::instance()->value--;
	}
	
	static long stack_len () {
		return StackShift::instance()->value.value ();
	}
};

void log_error (const ACE_TCHAR *format_str, ...);

void log_warning (const ACE_TCHAR *format_str, ...);

void log_info (const ACE_TCHAR *format_str, ...);

void log_debug (const ACE_TCHAR *format_str, ...);

void log_trace (const ACE_TCHAR *format_str, ...);

void slog_debug (const ACE_TCHAR *format_str, ...);

void log_fatal (const ACE_TCHAR *format_str, ...);

void log_alert (const ACE_TCHAR *format_str, ...);

void log_garant (const ACE_TCHAR *format_str, ...);

void log_unknown_exception (const ACE_TCHAR *format_str, ...);

void log_std_exception (const std::exception& ex, const ACE_TCHAR *format_str, ...);

const char* gds_current_function (const char* signature);
    
#if !defined(__APPLE__)

#ifndef GDS_NLOG_UNKNOWNEXCEPTION 
#define LOG_UEX(X) Core::log_unknown_exception X
#else 
#define LOG_UEX(X)
#endif

#if defined(GDS_NLOG_DEBUG) || defined(GDS_NLOG_UNKNOWNEXCEPTION)
#define LOG_UEXD(X)
#else 
#define LOG_UEXD(X) Core::log_unknown_exception X
#endif //GDS_NLOG_DEBUG

#ifndef GDS_NLOG_STDEXCEPTION 
// cool name i think ;))
#define LOG_SEX(X) Core::log_std_exception X
#else
#define LOG_SEX(X)
#endif

#if defined(GDS_NLOG_DEBUG) || defined(GDS_NLOG_STDEXCEPTION)
#define LOG_SEXD(X)
#else 
#define LOG_SEXD(X) Core::log_std_exception X
#endif //GDS_NLOG_DEBUG

#ifndef GDS_NLOG_FATAL 
#define LOG_F(X) Core::log_fatal X
#else 
#define LOG_F(X)
#endif

#ifndef GDS_NLOG_ERROR 
#define LOG_E(X) Core::log_error X
#else 
#define LOG_E(X)
#endif

#ifndef GDS_NLOG_WARNING 
#define LOG_W(X) Core::log_warning X
#else 
#define LOG_W(X)
#endif

#ifndef GDS_NLOG_INFO 
#define LOG_I(X) Core::log_info X
#else 
#define LOG_I(X)
#endif

#ifndef GDS_NLOG_DEBUG 
#define LOG_D(X) Core::log_debug X
#else 
#define LOG_D(X)
#endif

#ifndef GDS_NLOG_DEBUG 
#define SLOG_D(X) Core::slog_debug X
#else 
#define SLOG_D(X)
#endif

#ifndef GDS_NLOG_TRACE
#define LOG_T(X) Core::log_trace X
#else 
#define LOG_T(X)
#endif

#define LOG_G(X) Core::log_garant X	// логи

#define LOG_A(X) Core::log_alert X // ALERT (ASSERT)

#define STD_CATCH_AND_LOG 1

#define CATCH_AND_LOG(MESSAGE) \
	catch (std::exception& ex) { \
		LOG_SEX ((ex, MESSAGE)); \
	} catch (...) { \
		LOG_UEX ((MESSAGE)); \
	}

#define CATCH_LOG_AND_DO(MESSAGE,CODE) \
	catch (std::exception& ex) { \
		LOG_SEX ((ex, MESSAGE)); \
		CODE\
	} catch (...) { \
		LOG_UEX ((MESSAGE)); \
		CODE\
	}

#define GDS_CURRENT_FUNCTION (Core::gds_current_function (BOOST_CURRENT_FUNCTION))

#define SLOG_SHIFT \
	Core::SLogShifter _SLogShifter;	

#else

#undef LOG_W
#undef LOG_E
#undef LOG_D
#undef LOG_I

#define LOG_UEX(X)
#define LOG_UEXD(X)
#define LOG_SEX(X)
#define LOG_SEXD(X)
#define LOG_F(X)
#define LOG_E(X)
#define LOG_W(X)
#define LOG_I(X)
#define LOG_D(X)
#define SLOG_D(X)
#define LOG_T(X)
#define LOG_G(X)
#define LOG_A(X) true
#define STD_CATCH_AND_LOG 1
    
#define CATCH_AND_LOG(MESSAGE) \
catch (std::exception& ex) { \
LOG_SEX ((ex, MESSAGE)); \
} catch (...) { \
LOG_UEX ((MESSAGE)); \
}
    
#define CATCH_LOG_AND_DO(MESSAGE,CODE) \
catch (std::exception& ex) { \
LOG_SEX ((ex, MESSAGE)); \
CODE\
} catch (...) { \
LOG_UEX ((MESSAGE)); \
CODE\
}
    
#define GDS_CURRENT_FUNCTION ""
#define SLOG_SHIFT
    
#endif //#if !defined(__APPLE__)
    
#define LM_GARANT 04000

#define GDS_MESSAGE_STRINGER(MESSAGE)                                                                           \
	#MESSAGE

#define GDS_MESSAGE_QUOTE(MESSAGE)                                                                              \
	GDS_MESSAGE_STRINGER (MESSAGE)

#define GDS_MESSAGE(MESSAGE)                                                                                    \
	message (__FILE__ "(" GDS_MESSAGE_QUOTE (__LINE__) ") : " MESSAGE)

//#UC END# *450E97E40167_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_SYS_LOGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
