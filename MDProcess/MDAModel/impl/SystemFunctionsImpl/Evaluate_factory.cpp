////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Evaluate
//
// реализация встроенной функции генератора _evaluate
// _evaluate(«мат. выражение») - вичисляет мат. выражение и возвращает результат. Например:
// %f_evaluate(2*2+10) - вернёт 14.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate.h"

namespace SystemFunctionsImpl {

Evaluate_factory::Evaluate_factory () {
}

void Evaluate_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string Evaluate_factory::key () const {
	return "_evaluate";
}

TemplateFunctions::InternalFunction* Evaluate_factory::make () {
	Evaluate_var ret = new Evaluate ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

