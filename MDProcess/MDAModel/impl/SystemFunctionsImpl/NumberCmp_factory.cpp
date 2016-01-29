////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NumberCmp
//
// реализация встроенной функции генератора _number_cmp
// _number_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает как числа строку1 со
// строкой2 применяя заданную операцию (>,<,==, !=, >=, <=). Если результат сравнения - истина,
// возвращает 1, в противном случае 0.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp.h"

namespace SystemFunctionsImpl {

NumberCmp_factory::NumberCmp_factory () {
}

void NumberCmp_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string NumberCmp_factory::key () const {
	return "_number_cmp";
}

TemplateFunctions::InternalFunction* NumberCmp_factory::make () {
	NumberCmp_var ret = new NumberCmp ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

