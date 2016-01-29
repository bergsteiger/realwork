////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/SahiTestLib/TestPlaceSettings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::SahiTestLib::TestPerformer::TestPlaceSettings
//
// где лежат результаты тестов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTPLACESETTINGS_H__
#define __MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTPLACESETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace SahiTestLib {

// где лежат результаты тестов
class TestPlaceSettings {

// static member methods and data
public:
	// корневой путь к папкам, где лежат результаты тестов в их первичном виде
	static const std::string get_prefix_path () /* throw (Core::ParameterIsMissing) */;
	static void set_prefix_path (const std::string& value);
	static const char* prefix_path_param_name ();

}; // class TestPlaceSettings

} // namespace SahiTestLib


#endif //__MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTPLACESETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

