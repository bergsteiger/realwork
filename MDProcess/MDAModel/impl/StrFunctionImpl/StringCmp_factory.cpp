////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringCmp
//
// реализация встроенной функции генератора _string_cmp
// _string_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает строку1 со строкой2
// применяя заданную операцию (>,<,==, !=, >=, <=)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp.h"

namespace StrFunctionImpl {

StringCmp_factory::StringCmp_factory () {
}

void StringCmp_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StringCmp_factory::key () const {
	return "_string_cmp";
}

TemplateFunctions::InternalFunction* StringCmp_factory::make () {
	StringCmp_var ret = new StringCmp ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

