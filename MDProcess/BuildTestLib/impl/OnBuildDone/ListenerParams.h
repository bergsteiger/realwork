////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/ListenerParams.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::BuildTestLib::OnBuildDone::ListenerParams
//
// настройки копирования файлов сборки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LISTENERPARAMS_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LISTENERPARAMS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace BuildTestLib {
namespace OnBuildDone {

// настройки копирования файлов сборки
class ListenerParams {

// static member methods and data
public:
	// куда копировать структуру поддиректорий сборки на локальной машине
	static const std::string get_local_path () /* throw (Core::ParameterIsMissing) */;
	static void set_local_path (const std::string& value);
	static const char* local_path_param_name ();

	// имя релиза (фильтр) где разрешено тестировать сборки
	static const std::string get_release_name () /* throw (Core::ParameterIsMissing) */;
	static void set_release_name (const std::string& value);
	static const char* release_name_param_name ();

	// script_name
	static const std::string get_script_name () /* throw (Core::ParameterIsMissing) */;
	static void set_script_name (const std::string& value);
	static const char* script_name_param_name ();

}; // class ListenerParams

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LISTENERPARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

