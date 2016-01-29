////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildSupportLib/RunSettings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::BuildSupportLib::LibSupport::RunSettings
//
// настройки для работы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDSUPPORTLIB_LIBSUPPORT_RUNSETTINGS_H__
#define __MDPROCESS_BUILDSUPPORTLIB_LIBSUPPORT_RUNSETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace BuildSupportLib {

// настройки для работы
class RunSettings {

// static member methods and data
public:
	// номер ветки, 0 - обозначет хэд
	static const std::string get_branch () /* throw (Core::ParameterIsMissing) */;
	static void set_branch (const std::string& value);
	static const char* branch_param_name ();

	// номер сборки
	static const std::string get_build () /* throw (Core::ParameterIsMissing) */;
	static void set_build (const std::string& value);
	static const char* build_param_name ();

	// имя файла с логом сборки
	static const std::string get_build_log () /* throw (Core::ParameterIsMissing) */;
	static void set_build_log (const std::string& value);
	static const char* build_log_param_name ();

	// путь к сборке
	static const std::string get_build_path () /* throw (Core::ParameterIsMissing) */;
	static void set_build_path (const std::string& value);
	static const char* build_path_param_name ();

	// имя события (start, done или failure)
	static const std::string get_event () /* throw (Core::ParameterIsMissing) */;
	static void set_event (const std::string& value);
	static const char* event_param_name ();

	// логин пользователя, от имени которого создаётся сборка
	static const std::string get_login () /* throw (Core::ParameterIsMissing) */;
	static void set_login (const std::string& value);
	static const char* login_param_name ();

	// пароль пользователя
	static const std::string get_paswd () /* throw (Core::ParameterIsMissing) */;
	static void set_paswd (const std::string& value);
	static const char* paswd_param_name ();

	// ключ спейса (MDP, NST и т.д.)
	static const std::string get_project () /* throw (Core::ParameterIsMissing) */;
	static void set_project (const std::string& value);
	static const char* project_param_name ();

	// имя тэга, связанного со сборкой
	static const std::string get_tag () /* throw (Core::ParameterIsMissing) */;
	static void set_tag (const std::string& value);
	static const char* tag_param_name ();

}; // class RunSettings

} // namespace BuildSupportLib


#endif //__MDPROCESS_BUILDSUPPORTLIB_LIBSUPPORT_RUNSETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

