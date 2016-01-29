////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Warning_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Warning
//
// реализация встроенной функции генератора "_warning"
// _warning(«сообщение») - выводит предупреждение.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Warning_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Warning.h"

namespace SystemFunctionsImpl {

Warning_factory::Warning_factory () {
}

void Warning_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string Warning_factory::key () const {
	return "_warning";
}

TemplateFunctions::InternalFunction* Warning_factory::make () {
	Warning_var ret = new Warning ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

