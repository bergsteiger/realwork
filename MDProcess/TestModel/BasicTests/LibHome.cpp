////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> TestModel::BasicTests
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/BasicTests/impl/NewImpl/NoDefFactoryServant_factory.h"
#include "TestModel/BasicTests/impl/NewImpl/NewServant_factory.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/NewServant_factory.h"
#include "TestModel/BasicTests/NativeTypesSmallTest/NativeTypesSmallTest.h"
#include "TestModel/BasicTests/NewLibExecutor.h"

namespace BasicTests {

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
	
	template <>
	bool check_param<NativeTypesSmallTest::NewEnum> (const char* key, bool is_requared) {
		bool res = true;
		if (Core::ParamManagerFactory::get ().is_exist (key)) {
			res = false;
			std::string value = Core::ParamManagerFactory::get ().get_string (key);
			res |= value == "A";
			res |= value == "B";
			res |= value == "C";
			if (!res) {
				LOG_E (("Неверное значение параметра %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("Не задан обязательный параметр: %s", key));
		}
		return res;
	}
} //namespace

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&NewLibExecutor::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *49AED1C602F9_ENVIRONMENTS_CONFIG*
	//#UC END# *49AED1C602F9_ENVIRONMENTS_CONFIG*

	{
		NewImpl::NoDefFactoryServant_factory_var fctr = new NewImpl::NoDefFactoryServant_factory ();
		fctr->registrate_me(0);
	}
	
	{
		NewImpl::NewServant_factory_var fctr = new NewImpl::NewServant_factory ();
		fctr->registrate_me(0);
	}
	
	#if defined(WIN32)
	{
		IfdefTestImpl::NewServant_factory_var fctr = new IfdefTestImpl::NewServant_factory ();
		fctr->registrate_me(0);
	}
	#endif //WIN32
	
}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-my_unsigned_long: (unsigned long)= 10\n";
	std::cout << "-my_long: (long)\n";
	std::cout << "-my_bool: (boolean)\n";
	std::cout << "-my_enum: (NewEnum: A, B,C)

}

bool LibHomeImpl::check_params () const {
	bool res = check_param<unsigned long> ("-my_unsigned_long", false);
	res &= check_param<long> ("-my_long", false);
	res &= check_param<unsigned long> ("-my_bool", false);
	res &= check_param<NativeTypesSmallTest::NewEnum> ("-my_enum", false);

	return res;
}
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
