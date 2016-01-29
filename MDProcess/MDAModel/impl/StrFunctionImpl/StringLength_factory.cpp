////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringLength_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringLength
//
// реализация встроенной функции генератора _string_length
// _string_length(«строка») - длина переданной строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringLength_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringLength.h"

namespace StrFunctionImpl {

StringLength_factory::StringLength_factory () {
}

void StringLength_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StringLength_factory::key () const {
	return "_string_length";
}

TemplateFunctions::InternalFunction* StringLength_factory::make () {
	StringLength_var ret = new StringLength ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

