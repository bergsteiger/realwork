////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToLower_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToLower
//
// реализация встроенной функции генератора "_to_lower".
// _to_lower  ("<строка>") - изменяет регистр строки на lowercase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToLower_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToLower.h"

namespace StrFunctionImpl {

ToLower_factory::ToLower_factory () {
}

void ToLower_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ToLower_factory::key () const {
	return "_to_lower";
}

TemplateFunctions::InternalFunction* ToLower_factory::make () {
	ToLower_var ret = new ToLower ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

