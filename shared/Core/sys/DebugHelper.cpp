////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/DebugHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::DebugHelper
// Файл реализации утилитного набора DebugHelper
//
// вспомогательные функции для отладки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/sys/DebugHelper.h"
// by <<uses>> dependencies
#include "ace/Stack_Trace.h"
#include "shared/Core/sys/Logs.h"

namespace Core {
namespace DebugHelper {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// дампит текущий стэк в лог
void dump_stack () {
	//#UC START# *4DA7DBC703D8*
	ACE_Stack_Trace st;
	LOG_E (("Stack trace: %s", st.c_str()));
	//#UC END# *4DA7DBC703D8*
}

} // namespace DebugHelper
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

