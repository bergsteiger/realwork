////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ShiftScope
//
// реализация встроенной функции генератора "_shift_scope".
// _shift_scope(true/false) - устанавливает флаг - нужно ли сдвинуть scope на один уровень.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope.h"

namespace SystemFunctionsImpl {

ShiftScope_factory::ShiftScope_factory () {
}

void ShiftScope_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ShiftScope_factory::key () const {
	return "_shift_scope";
}

TemplateFunctions::InternalFunction* ShiftScope_factory::make () {
	ShiftScope_var ret = new ShiftScope ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

