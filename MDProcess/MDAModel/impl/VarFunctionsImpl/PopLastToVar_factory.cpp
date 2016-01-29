////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopLastToVar
//
// реализация встроенной функции генератора _pop_last_to_var.
// _pop_last_to_var(«идентификатор», «идентификатор переменной») - помещает в переменную
// «идентификатор переменной» значение последнего дампера из списка (аналогично _set_var), и
// удаляет его (из списка)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar.h"

namespace VarFunctionsImpl {

PopLastToVar_factory::PopLastToVar_factory () {
}

void PopLastToVar_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string PopLastToVar_factory::key () const {
	return "_pop_last_to_var";
}

TemplateFunctions::InternalFunction* PopLastToVar_factory::make () {
	PopLastToVar_var ret = new PopLastToVar ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

