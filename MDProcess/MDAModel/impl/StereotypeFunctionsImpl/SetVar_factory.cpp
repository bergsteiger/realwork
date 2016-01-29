////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SetVar
//
// %S%f_set_var(имя переменной,элемент|"строка") - установка переменной, связанной с элементом:
// {code}
// %S%f_set_var(TYPE,T)
// %S%f_set_var(NAME,"%SN")
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar.h"

namespace StereotypeFunctionsImpl {

SetVar_factory::SetVar_factory () {
}

void SetVar_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetVar_factory::key () const {
	return "_set_var";
}

TemplateFunctions::InternalStereotypeFunction* SetVar_factory::make () {
	SetVar_var ret = new SetVar ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

