////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/Settings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::Addin_i::Settings
//
// Настройки генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_SETTINGS_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_SETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"


// Настройки генератора
class Settings {

// static member methods and data
public:
	// путь к лог-файлу
	static const std::string get_log_file () /* throw (Core::ParameterIsMissing) */;
	static void set_log_file (const std::string& value);
	static const char* log_file_param_name ();

	// время задержки в мс. перед показом всплывающей подсказки
	static const unsigned long get_tooltip_initial_delay () /* throw (Core::ParameterIsMissing) */;
	static void set_tooltip_initial_delay (unsigned long value);
	static const char* tooltip_initial_delay_param_name ();

	// путь к внешнему приложению, которое должно быть запущено
	static const std::string get_external_command_path () /* throw (Core::ParameterIsMissing) */;
	static void set_external_command_path (const std::string& value);
	static const char* external_command_path_param_name ();

}; // class Settings



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_SETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

