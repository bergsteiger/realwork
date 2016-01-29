////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/SahiTestLib/SahiSettings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::SahiTestLib::TestPerformer::SahiSettings
//
// настройки тестов sahi
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SAHITESTLIB_TESTPERFORMER_SAHISETTINGS_H__
#define __MDPROCESS_SAHITESTLIB_TESTPERFORMER_SAHISETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace SahiTestLib {

// настройки тестов sahi
class SahiSettings {

// static member methods and data
public:
	// bat-файл запускающий тесты sahi
	static const std::string get_bat_file_path () /* throw (Core::ParameterIsMissing) */;
	static void set_bat_file_path (const std::string& value);
	static const char* bat_file_path_param_name ();

	// результаты тестов sahi в текстовом файле
	static const std::string get_text_file_path () /* throw (Core::ParameterIsMissing) */;
	static void set_text_file_path (const std::string& value);
	static const char* text_file_path_param_name ();

}; // class SahiSettings

} // namespace SahiTestLib


#endif //__MDPROCESS_SAHITESTLIB_TESTPERFORMER_SAHISETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

