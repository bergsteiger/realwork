////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/Settings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::KPageToolLib::LibSupport::Settings
//
// Блок настроек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_SETTINGS_H__
#define __MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_SETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {

// Блок настроек
class Settings {

// static member methods and data
public:
	// путь до файла, содержащего данные для страничных экшанов
	static const std::string get_file () /* throw (Core::ParameterIsMissing) */;
	static void set_file (const std::string& value);
	static const char* file_param_name ();

	// логин для авторизации на сервер К
	static const std::string get_login () /* throw (Core::ParameterIsMissing) */;
	static void set_login (const std::string& value);
	static const char* login_param_name ();

	// Действие, которое нужно выполнить, задается строкой, совпадающей с названием идентификатора в
	// перечислении, подробнее см перечисление указаное в типе настройки.
	static const Actions::PageActionsEnum get_operation () /* throw (Core::ParameterIsMissing) */;
	static void set_operation (Actions::PageActionsEnum value);
	static const char* operation_param_name ();

	// ID страницы, которыую нужно прочитать
	static const unsigned long get_page_id () /* throw (Core::ParameterIsMissing) */;
	static void set_page_id (unsigned long value);
	static const char* page_id_param_name ();

	// пароль для авториацзии на сервере К
	static const std::string get_password () /* throw (Core::ParameterIsMissing) */;
	static void set_password (const std::string& value);
	static const char* password_param_name ();

}; // class Settings

} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_SETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

