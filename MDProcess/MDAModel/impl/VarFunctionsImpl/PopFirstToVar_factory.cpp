////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopFirstToVar
//
// реализация встроенной функции генератора  _pop_first_to_var.
// _pop_first_to_var(«идентификатор», «идентификатор переменной») - помещает в переменную
// «идентификатор переменной» значение певого дампера из списка (аналогично _set_var), и удаляет
// его (из списка)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar.h"

namespace VarFunctionsImpl {

PopFirstToVar_factory::PopFirstToVar_factory () {
}

void PopFirstToVar_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string PopFirstToVar_factory::key () const {
	return "_pop_first_to_var";
}

TemplateFunctions::InternalFunction* PopFirstToVar_factory::make () {
	PopFirstToVar_var ret = new PopFirstToVar ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

