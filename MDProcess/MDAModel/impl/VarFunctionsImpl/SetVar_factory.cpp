////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SetVar
//
// реализация встроенной функции генератора _set_var.
// _set_var («идентификатор», «значение») - определяет и инициализирует глобальную переменную
// (область видимость неограничена) типа ЭЛЕМЕНТ МОДЕЛИ или СТРОКА. Например:
// {code}
// %f_set_var (CURRENT_ELEM, S) .... %{CURRENT_ELEM}N
// %f_set_var (PARENT, P) .... %{PARENT}%CN
// %f_set_var (TEMP, "[{%SM=Interface::Class}{non interface}interface]") .... %{TEMP}N
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar.h"

namespace VarFunctionsImpl {

SetVar_factory::SetVar_factory () {
}

void SetVar_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetVar_factory::key () const {
	return "_set_var";
}

TemplateFunctions::InternalFunction* SetVar_factory::make () {
	SetVar_var ret = new SetVar ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

