////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/PrintStack_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::PrintStack
//
// %f_print_stack("маркер") - выводит стэк вызова функций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/PrintStack_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/PrintStack.h"

namespace SystemFunctionsImpl {

PrintStack_factory::PrintStack_factory () {
}

void PrintStack_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string PrintStack_factory::key () const {
	return "_print_stack";
}

TemplateFunctions::InternalFunction* PrintStack_factory::make () {
	PrintStack_var ret = new PrintStack ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

