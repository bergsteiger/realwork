////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringHash_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringHash
//
// реализация встроенной функции генератора "_string_hash"
// _string_hash("<строка>") - хэш переданной строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringHash_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringHash.h"

namespace StrFunctionImpl {

StringHash_factory::StringHash_factory () {
}

void StringHash_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StringHash_factory::key () const {
	return "_string_hash";
}

TemplateFunctions::InternalFunction* StringHash_factory::make () {
	StringHash_var ret = new StringHash ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

