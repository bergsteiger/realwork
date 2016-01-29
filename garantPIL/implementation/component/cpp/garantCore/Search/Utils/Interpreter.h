////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Utils/Interpreter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Utils::Interpreter
//
// Интерпретатор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_UTILS_INTERPRETER_H__
#define __GARANTCORE_SEARCH_UTILS_INTERPRETER_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Def/Def.h"

//#UC START# *50A510FD01FE_CUSTOM_INCLUDES*
//#UC END# *50A510FD01FE_CUSTOM_INCLUDES*

namespace Search {

// Интерпретатор
class Interpreter {
	SET_OBJECT_COUNTER (Interpreter)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// выполнить
	static QueriesTags* execute (const std::string& str, bool need_optimize = false);

	// выполнить с валидацией и сортировкой
	static QueriesTags* execute_ext (const std::string& str);

private:
	// оптимизация
	static void optimize (QueryTag& tag);

	// оптимизация скобок
	static QueriesTags* optimize_brackets (QueryTag& tag);


//#UC START# *50A510FD01FE*
//#UC END# *50A510FD01FE*
}; // class Interpreter

} // namespace Search


#endif //__GARANTCORE_SEARCH_UTILS_INTERPRETER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

