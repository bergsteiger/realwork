////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/Params/Params.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Params
//
// пакет для работы с параметрами приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/Params/Params.h"
#include "shared/Core/Params/ParamsFactories.h"

namespace Core {

// factory interface wrapper for ParamManager
ParamManager& ParamManagerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ParamManagerFactoryManager::Singleton::instance ()->get ();
}

ParamManager* ParamManagerFactory::make (
	const std::string& args
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ParamManagerFactoryManager::Singleton::instance ()->make (args);
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

