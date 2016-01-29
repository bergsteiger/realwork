////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Logging_i::LogManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogManager_i.h"

namespace GblAdapterLib {

LogManager_i_factory::LogManager_i_factory () {
}

void LogManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	LogManagerFactoryManager::register_factory (this, priority);
}

const char* LogManager_i_factory::key () const {
	return "LogManager_i";
}

LogManager* LogManager_i_factory::make () {
	return Core::IObject::_duplicate (LogManager_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

