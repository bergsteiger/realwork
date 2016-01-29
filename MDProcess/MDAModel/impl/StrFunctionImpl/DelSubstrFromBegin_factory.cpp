////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromBegin
//
// реализация встроенной функции генератора "_delsubstr_from_begin"
// _delsubstr_from_begin("<строка>",n) - удаляет n символов с начала строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin.h"

namespace StrFunctionImpl {

DelSubstrFromBegin_factory::DelSubstrFromBegin_factory () {
}

void DelSubstrFromBegin_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string DelSubstrFromBegin_factory::key () const {
	return "_delsubstr_from_begin";
}

TemplateFunctions::InternalFunction* DelSubstrFromBegin_factory::make () {
	DelSubstrFromBegin_var ret = new DelSubstrFromBegin ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

