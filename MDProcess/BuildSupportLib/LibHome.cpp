////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildSupportLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::BuildSupportLib
//
// Библиотека поддержки работы со сборками в конфлюенсе, в частности из сборочного скрипта ant.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/BuildSupportLib/LibHome.h"
#include "MDProcess/BuildSupportLib/Run.h"

namespace BuildSupportLib {

namespace {
	template <typename T>
	bool check_param (const char* key, bool is_requared) {
		bool res = true;
		if (Core::ParamManagerFactory::get ().is_exist (key)) {
			std::string value = Core::ParamManagerFactory::get ().get_string (key);
			try {
				boost::lexical_cast<T> (value);
			} catch (boost::bad_lexical_cast&) {
				res = false;
				LOG_E (("Неверное значение параметра %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("Не задан обязательный параметр: %s", key));
		}
		
		return res;
	}
	
	template <>
	bool check_param<std::string> (const char* key, bool is_requared) {
		if (is_requared && !Core::ParamManagerFactory::get ().is_exist (key)) {
			LOG_E(("Не задан обязательный параметр <%s>", key));
			return false;
		}
		return true;
	}
	
} //namespace

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&Run::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *47D68BDE0153_ENVIRONMENTS_CONFIG*
	//#UC END# *47D68BDE0153_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-login: (a-string)       - логин пользователя, от имени которого\n";
	std::cout << "                         создаётся сборка\n";

	std::cout << "-paswd: (a-string)       - пароль пользователя\n";

	std::cout << "-event: (a-string)       - имя события (start, done или failure)\n";

	std::cout << "-project: (a-string)     - ключ спейса (MDP, NST и т.д.)\n";

	std::cout << "-tag: (a-string)         - имя тэга, связанного со сборкой\n";

	std::cout << "-build: (a-string)       - номер сборки\n";

	std::cout << "-branch: (a-string)      - номер ветки, 0 - обозначет хэд\n";
	std::cout << "                         = 0\n";
	std::cout << "-build_path: (string)    - путь к сборке\n";
	std::cout << "                         = EMPTY_STR\n";
	std::cout << "-build_log: (string)     - имя файла с логом сборки\n";
	std::cout << "                         = EMPTY_STR\n";

}

bool LibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-login", false);
	res &= check_param<std::string> ("-paswd", false);
	res &= check_param<std::string> ("-event", false);
	res &= check_param<std::string> ("-project", false);
	res &= check_param<std::string> ("-tag", false);
	res &= check_param<std::string> ("-build", false);
	res &= check_param<std::string> ("-branch", false);
	res &= check_param<std::string> ("-build_path", false);
	res &= check_param<std::string> ("-build_log", false);

	return res;
}
} // namespace BuildSupportLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
