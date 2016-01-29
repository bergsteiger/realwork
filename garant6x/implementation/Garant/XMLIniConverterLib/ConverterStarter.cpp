////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/ConverterStarter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> garant6x::XMLIniConverterLib::LibSupport::ConverterStarter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "ace/Signal.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/ConverterStarter.h"
// by <<uses>> dependencies
#include <fstream>

//#UC START# *45E43FDF02CE_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"
#include "shared/XercesHelpers/wrappers/XercesHelper.h"
//#UC END# *45E43FDF02CE_CUSTOM_INCLUDES*
namespace XMLIniConverterLib {

//#UC START# *45E43FDF02CE_CUSTOM_BODY*
//#UC END# *45E43FDF02CE_CUSTOM_BODY*

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void ConverterStarter::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)ConverterStarter::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)ConverterStarter::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)ConverterStarter::handle_control, SIGQUIT);
	
		//#UC START# *45E43FDF02CE*
		IniConverter::RulesManager_var rules_manager = IniConverter::RulesManagerFactory::make ();
		std::string ini_path = Core::ParamManagerFactory::get ().get_string ("-f");
		if (ini_path.empty ()) {
			this->usage ();
			this->set_current_status(Core::Root::ES_FINISHED);
			return;
		}

		// чтение пути для дельты (было в старом конвертере, перенесено для совместимости)
		std::string update_path = Core::ParamManagerFactory::get ().get_string ("-u");
		if (!update_path.empty ()) {
			rules_manager->set_variable (IniConverter::UPDATE_PATH, update_path);
		} else {
			size_t position = ini_path.find_last_of (ACE_DIRECTORY_SEPARATOR_CHAR);
			if (position == std::string::npos) {
				update_path += ".";
				update_path += ACE_DIRECTORY_SEPARATOR_CHAR;
			} else {
				update_path = ini_path.substr (0, position + 1);
			}
		}
		if (update_path[update_path.size () - 1] != ACE_DIRECTORY_SEPARATOR_CHAR) {
			update_path += ACE_DIRECTORY_SEPARATOR_CHAR;
		}
		update_path += "delta";
		rules_manager->set_variable (IniConverter::UPDATE_PATH, update_path);

		IniConverter::IniFile_var old_file;
		try {
			old_file = IniConverter::IniFileFactory::make (ini_path.c_str ());
		} catch (IniConverter::FileReadingError&) {
			this->set_current_status(Core::Root::ES_ERROR);
			return;
		}

		// чтение путей к новому инишнику и правилам
		std::string new_ini_path = Core::ParamManagerFactory::get ().get_string ("-n");
		std::string xml_path = Core::ParamManagerFactory::get ().get_string ("-x");
		if (new_ini_path.empty () || xml_path.empty ()) {
			// получаем путь к текущему бинарнику
			char path [PATH_MAX + 1];
			this->get_app_path (path, PATH_MAX + 1);
			size_t path_len = std::strlen (path);
			if (!path_len) {
				std::cerr << "Can't find path to current executable" << std::endl;
				this->set_current_status(Core::Root::ES_ERROR);
				return;
			}
			if (path[path_len - 1] != ACE_DIRECTORY_SEPARATOR_CHAR) {
				path[path_len++] = ACE_DIRECTORY_SEPARATOR_CHAR;
				path[path_len] = 0;
			}

			// получаем версию старого инишника
			IniConverter::Parameter* parameter = old_file->get_cached_parameter ("[Version]", "-Product");
			if (parameter) {
				this->create_path (path, "ini", parameter->get_value (), new_ini_path);
				this->create_path (path, "xml", parameter->get_value (), xml_path);
			} else {
				std::cerr << "Can't find -Product option in [Version] section in old ini file" << std::endl;
				this->set_current_status(Core::Root::ES_ERROR);
				return;
			}
		}

		XercesHelpers::XercesHelper::instance (); // инициализируем библиотеку xerces
		IniConverter::IniFile_var new_file;
		try {
			new_file = IniConverter::IniFileFactory::make (new_ini_path.c_str ());
		} catch (IniConverter::FileReadingError&) {
			this->set_current_status(Core::Root::ES_ERROR);
			return;
		}
		// применяем правила
		try {
			rules_manager->init (xml_path.c_str ());
			rules_manager->apply (old_file.ptr (), new_file.ptr ());
		} catch (...) {
			std::cerr << "Error occured while parsing xml file "<< xml_path << std::endl;
			std::cerr << "Use ONLY new ini file" << std::endl;
			this->print_result (ini_path.c_str (), new_file.ptr ());
			this->set_current_status(Core::Root::ES_ERROR);
			return;
		}
		// затем сливаем информацию из инишников
		old_file->merge (new_file.in ());
		// выливаем результат
		this->print_result (ini_path.c_str (), new_file.ptr ());
		//#UC END# *45E43FDF02CE*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void ConverterStarter::finalize () {
	//#UC START# *45E43FDF02CE_FINI*
	//#UC END# *45E43FDF02CE_FINI*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void ConverterStarter::create_path (
	const char* path
	, const char* extension
	, const std::string& version
	, std::string& result
) const {
	//#UC START# *45E43FFD0213*
	if (result.empty ()) {
		result = path;
		result += extension;
		result += ACE_DIRECTORY_SEPARATOR_CHAR;
		result += version;
		result += ".";
		result += extension;
	}
	//#UC END# *45E43FFD0213*
}

// получить путь к каталогу с бинарником. метод непереносим.
void ConverterStarter::get_app_path (char* buf, size_t len) const {
	//#UC START# *45E43FFB03D8*
	buf [0] = '\0';

	char app_path [PATH_MAX + 1];
	DWORD res = GetModuleFileName (GetModuleHandle (0)
								  , app_path
								  , sizeof (app_path));
	if (!res) {
		return;
	}

	char drive [_MAX_DRIVE];
	char dir [_MAX_DIR];
	_splitpath (app_path, drive, dir, 0, 0);
	if ((strlen (drive) + strlen (dir)) >= len) {
		return;
	}
	_makepath (buf, drive, dir, 0, 0);
	//#UC END# *45E43FFB03D8*
}

void ConverterStarter::print_result (const char* path, const IniConverter::IniFile* file) const {
	//#UC START# *45E44CCE01E4*
	std::ofstream result_file (path);
	if (result_file) {
		file->print (result_file);
	} else {
		std::cerr << "Can't write result to the ini file " << path << std::endl;
	}
	//#UC END# *45E44CCE01E4*
}

// описание командной строки утилиты
void ConverterStarter::usage () const {
	//#UC START# *45E43FF903C8*
	std::cout << "usage: IniConverter -f <file> [-u <path>] [-n <path>] [-x <path>]\n" << std::endl;
	std::cout << "-f <file>     : path to ini file to convert" << std::endl;
	std::cout << "-u <path>     : path to data update, default is ini file dir" << std::endl;
	std::cout << "-n <file>     : path to ini file for new version, default is ./ini/[VERSION-TYPE].ini" << std::endl;
	std::cout << "-x <file>     : path to xml rules, default is ./xml/[VERSION-TYPE].xml" << std::endl;
	//#UC END# *45E43FF903C8*
}
void ConverterStarter::handle_control (int sig) {
	//#UC START# *45E43FDF02CE_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *45E43FDF02CE_HANDLE_CONTROl*
}

} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
