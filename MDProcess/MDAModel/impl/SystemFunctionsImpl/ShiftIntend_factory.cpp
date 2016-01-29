////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftIntend_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ShiftIntend
//
// реализация встроенной функции генератора "_shift_intend".
// _shift_intend(N) - изменяет величину отступа по команде # на величину N, где N - целое число со
// знаком.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftIntend_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftIntend.h"

namespace SystemFunctionsImpl {

ShiftIntend_factory::ShiftIntend_factory () {
}

void ShiftIntend_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ShiftIntend_factory::key () const {
	return "_shift_intend";
}

TemplateFunctions::InternalFunction* ShiftIntend_factory::make () {
	ShiftIntend_var ret = new ShiftIntend ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

