////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::CycleBreak
//
// встроенная функция:
// _cycle_break() - прерывает текущий цикл, если функция вызвана вне цикла - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak.h"

namespace SystemFunctionsImpl {

CycleBreak_factory::CycleBreak_factory () {
}

void CycleBreak_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string CycleBreak_factory::key () const {
	return "_cycle_break";
}

TemplateFunctions::InternalFunction* CycleBreak_factory::make () {
	CycleBreak_var ret = new CycleBreak ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

