////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::TemplateFunctions
//
// пакет интерфейсов для работы с встроенными функциями генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace TemplateFunctions {


// конструктор
BadParams::BadParams (const std::string& function, unsigned short min_count, unsigned short max_count, unsigned short provided)
//#UC START# *4BE0F6790119_BASE_INIT*
	: FatalError ("BadParams")
	 , m_function (function)
	 , m_min_expected_params_count (min_count)
	 , m_provided_params_count (max_count)
	 , m_max_expected_params_count (provided)
//#UC END# *4BE0F6790119_BASE_INIT*
{
	//#UC START# *4BE0F6790119_BODY*
	//#UC END# *4BE0F6790119_BODY*
}
// конструктор
BadParams::BadParams (const std::string& function, unsigned short params_count, unsigned short provided)
//#UC START# *4BE0F6B60399_BASE_INIT*
	: FatalError ("BadParams")
	 , m_function (function)
	 , m_min_expected_params_count (params_count)
	 , m_provided_params_count (params_count)
	 , m_max_expected_params_count (provided)
//#UC END# *4BE0F6B60399_BASE_INIT*
{
	//#UC START# *4BE0F6B60399_BODY*
	//#UC END# *4BE0F6B60399_BODY*
}

BadParams::BadParams (const std::string& function, unsigned short min_expected_params_count, unsigned short provided_params_count, unsigned short max_expected_params_count, const std::string& info)
	: FatalError (info), m_function (function), m_min_expected_params_count (min_expected_params_count), m_provided_params_count (provided_params_count), m_max_expected_params_count (max_expected_params_count)
//#UC START# *4BE0F2D30271_BASE_INIT*
//#UC END# *4BE0F2D30271_BASE_INIT*
{
	//#UC START# *4BE0F2D30271_BODY*
	//#UC END# *4BE0F2D30271_BODY*
}

BadParams::~BadParams () throw () {
}

const char* BadParams::uid () const /*throw ()*/ {
	return "3947B1B7-85F5-4BF9-AAED-53F9FC422D98";
}

const char* BadParams::what () const throw () {
	//#UC START# *4BE0F2D30271_WHAT_IMPL*
	if (m_min_expected_params_count == m_max_expected_params_count) {
		ACE_OS::snprintf (
			m_message
			, 256
			, "Неправильно заданы параметры функции \"%s\", задано %u параметров, функция принимает %u параметров"
			, m_function.c_str ()
			, m_provided_params_count
			, m_min_expected_params_count
		);
	} else {
		ACE_OS::snprintf (
			m_message
			, 256
			, "Неправильно заданы параметры функции \"%s\", задано %u параметров, функция принимает от %u до %u параметров"
			, m_function.c_str ()
			, m_provided_params_count
			, m_min_expected_params_count
			, m_max_expected_params_count
		);
	}
	return m_message;
	//#UC END# *4BE0F2D30271_WHAT_IMPL*
}

// factory interface wrapper for InternalStereotypeFunction
InternalStereotypeFunction& InternalStereotypeFunctionFactory::make (const std::string& key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return InternalStereotypeFunctionFactoryManager::Singleton::instance ()->make (key);
}


InternalStereotypeFunctionFactory::KeySet* InternalStereotypeFunctionFactory::keys () {
	return InternalStereotypeFunctionFactoryManager::keys ();
}

// factory interface wrapper for InternalFunction
InternalFunction& InternalFunctionFactory::make (const std::string& key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return InternalFunctionFactoryManager::Singleton::instance ()->make (key);
}


InternalFunctionFactory::KeySet* InternalFunctionFactory::keys () {
	return InternalFunctionFactoryManager::keys ();
}

} // namespace TemplateFunctions

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

