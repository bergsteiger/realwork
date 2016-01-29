////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::BuildTestLib
//
// библиотека реализующая логику сервера запуска тестов ночных сборок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/BuildTestLib/ServerLibHome.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i_factory.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i_factory.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i_factory.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i_factory.h"

namespace BuildTestLib {

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

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *4C878C39025E_ENVIRONMENTS_CONFIG*
	//#UC END# *4C878C39025E_ENVIRONMENTS_CONFIG*

	{
		OnBuildDone::BuildListener_i_factory_var fctr = new OnBuildDone::BuildListener_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		OnBuildDone::Publish_i_factory_var fctr = new OnBuildDone::Publish_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		OnBuildDone::LocalPageLogin_i_factory_var fctr = new OnBuildDone::LocalPageLogin_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		OnBuildDone::FunctionalTest_i_factory_var fctr = new OnBuildDone::FunctionalTest_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void ServerLibHomeImpl::finalize () {
}
	
void ServerLibHomeImpl::print_usage () const {
	std::cout << "-local_path: (a-string)  - куда копировать структуру поддиректорий сборки\n";
	std::cout << "                         на локальной машине\n";
	std::cout << "                         = C:/DATA/work/build\n";
	std::cout << "-script_name: (a-string) - script_name\n";
	std::cout << "                         = run.bat\n";
	std::cout << "-release_name: (a-string)- имя релиза (фильтр) где разрешено тестировать\n";
	std::cout << "                         сборки\n";

	std::cout << "-login: (a-string)       - логин/пароль под которым BuildTestServer\n";
	std::cout << "                         входит в К\n";
	std::cout << "                         = tester\n";
	std::cout << "-password: (a-string)    - логин/пароль под которым BuildTestServer\n";
	std::cout << "                         входит в К\n";


}

bool ServerLibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-local_path", false);
	res &= check_param<std::string> ("-script_name", false);
	res &= check_param<std::string> ("-release_name", false);
	res &= check_param<std::string> ("-login", false);
	res &= check_param<std::string> ("-password", false);

	return res;
}
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
