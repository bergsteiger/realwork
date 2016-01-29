////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/fix/Win32Exception.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::fix::Win32Exception
// Файл реализации утилитного набора Win32Exception
//
// хак для правильной работы с win32 исключениями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/fix/Win32Exception.h"

//#UC START# *45011F6B0000_CUSTOM_INCLUDES*
#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0)
#include "eh.h"
#include "shared/Core/sys/Logs.h"
#endif
//#UC END# *45011F6B0000_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *45011F6B0000*
#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0)
void Win32Exception::install_handler() {
	_set_se_translator(Win32Exception::translate);
}

void Win32Exception::translate (unsigned code, EXCEPTION_POINTERS* info) {
	// Windows guarantees that *(info->ExceptionRecord) is valid
	switch (code) {
		case EXCEPTION_ACCESS_VIOLATION: throw AccessViolation (*(info->ExceptionRecord));
		default:                         throw Win32Exception (*(info->ExceptionRecord));
	}
}

Win32Exception::Win32Exception (const EXCEPTION_RECORD& info)
	: m_what ("Win32 exception"), m_where (info.ExceptionAddress), m_code (info.ExceptionCode) {
	switch (info.ExceptionCode) {
		case EXCEPTION_ACCESS_VIOLATION         : m_what = "EXCEPTION_ACCESS_VIOLATION";         break;
		case EXCEPTION_ARRAY_BOUNDS_EXCEEDED    : m_what = "EXCEPTION_ARRAY_BOUNDS_EXCEEDED";    break;
		case EXCEPTION_BREAKPOINT               : m_what = "EXCEPTION_BREAKPOINT";               break;
		case EXCEPTION_DATATYPE_MISALIGNMENT    : m_what = "EXCEPTION_DATATYPE_MISALIGNMENT";    break;
		case EXCEPTION_FLT_DENORMAL_OPERAND     : m_what = "EXCEPTION_FLT_DENORMAL_OPERAND";     break;
		case EXCEPTION_FLT_DIVIDE_BY_ZERO       : m_what = "EXCEPTION_FLT_DIVIDE_BY_ZERO";       break;
		case EXCEPTION_FLT_INEXACT_RESULT       : m_what = "EXCEPTION_FLT_INEXACT_RESULT";       break;
		case EXCEPTION_FLT_INVALID_OPERATION    : m_what = "EXCEPTION_FLT_INVALID_OPERATION";    break;
		case EXCEPTION_FLT_OVERFLOW             : m_what = "EXCEPTION_FLT_OVERFLOW";             break;
		case EXCEPTION_FLT_STACK_CHECK          : m_what = "EXCEPTION_FLT_STACK_CHECK";          break;
		case EXCEPTION_FLT_UNDERFLOW            : m_what = "EXCEPTION_FLT_UNDERFLOW";            break;
		case EXCEPTION_ILLEGAL_INSTRUCTION      : m_what = "EXCEPTION_ILLEGAL_INSTRUCTION";      break;
		case EXCEPTION_IN_PAGE_ERROR            : m_what = "EXCEPTION_IN_PAGE_ERROR";            break;
		case EXCEPTION_INT_DIVIDE_BY_ZERO       : m_what = "EXCEPTION_INT_DIVIDE_BY_ZERO";       break;
		case EXCEPTION_INT_OVERFLOW             : m_what = "EXCEPTION_INT_OVERFLOW";             break;
		case EXCEPTION_INVALID_DISPOSITION      : m_what = "EXCEPTION_INVALID_DISPOSITION";      break;
		case EXCEPTION_NONCONTINUABLE_EXCEPTION : m_what = "EXCEPTION_NONCONTINUABLE_EXCEPTION"; break;
		case EXCEPTION_PRIV_INSTRUCTION         : m_what = "EXCEPTION_PRIV_INSTRUCTION";         break;
		case EXCEPTION_SINGLE_STEP              : m_what = "EXCEPTION_SINGLE_STEP";              break;
		case EXCEPTION_STACK_OVERFLOW           : m_what = "EXCEPTION_STACK_OVERFLOW";           break;
	}
	LOG_A (("Win32 exception [%s] translated to Core::Win32Exception", m_what));
}

AccessViolation::AccessViolation (const EXCEPTION_RECORD& info)
	: Win32Exception(info), m_is_write (false), m_bad_address (0) {
	m_is_write = info.ExceptionInformation[0] == 1;
	m_bad_address = reinterpret_cast<Win32Exception::Address> (info.ExceptionInformation[1]);
}
#endif
//#UC END# *45011F6B0000*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

