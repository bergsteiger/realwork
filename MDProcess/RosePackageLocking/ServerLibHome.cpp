////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::RosePackageLocking
//
// библиотека с основной функциональностью сервера залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/RosePackageLocking/ServerLibHome.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i_factory.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer_factory.h"
#include "MDProcess/RosePackageLocking/Executor.h"

namespace RosePackageLocking {

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
	this->get_executors ().insert (&Executor::get ());
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *45DAFE2D0216_ENVIRONMENTS_CONFIG*
	//#UC END# *45DAFE2D0216_ENVIRONMENTS_CONFIG*

	{
		RosePackageLockingServerImpl::Package_i_factory_var fctr = new RosePackageLockingServerImpl::Package_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RosePackageLockingServerImpl::PackageContainer_factory_var fctr = new RosePackageLockingServerImpl::PackageContainer_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void ServerLibHomeImpl::finalize () {
}
	
void ServerLibHomeImpl::print_usage () const {
	std::cout << "-StorageFile: (string)   - Имя файла-хранилища с информацией о залоченных\n";
	std::cout << "                         пакетах.\n";
	std::cout << "                         = EMPTY_STR\n";
	std::cout << "-FlushTimeout: (unsigned integer) - Таймаут в секундах, через которой\n";
	std::cout << "                         сервер будет сохранять информацию о залочках в\n";
	std::cout << "                         файл.\n";
	std::cout << "                         = 300\n";

}

bool ServerLibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-StorageFile", false);
	res &= check_param<unsigned int> ("-FlushTimeout", false);

	return res;
}
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
