////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Error_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Error
//
// реализация встроенной функции генератора "_error".
// _error(«сообщение») - выводит сообщение об ошибке и прекращает генерацию
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Error_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Error.h"

namespace SystemFunctionsImpl {

Error_factory::Error_factory () {
}

void Error_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string Error_factory::key () const {
	return "_error";
}

TemplateFunctions::InternalFunction* Error_factory::make () {
	Error_var ret = new Error ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

