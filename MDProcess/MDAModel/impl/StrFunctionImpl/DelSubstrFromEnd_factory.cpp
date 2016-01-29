////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromEnd
//
// реализация встроенной функции генератора "_delsubstr_from_end"
// _delsubstr_from_end("<строка>",n) - удаляет n символов с конца строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd.h"

namespace StrFunctionImpl {

DelSubstrFromEnd_factory::DelSubstrFromEnd_factory () {
}

void DelSubstrFromEnd_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string DelSubstrFromEnd_factory::key () const {
	return "_delsubstr_from_end";
}

TemplateFunctions::InternalFunction* DelSubstrFromEnd_factory::make () {
	DelSubstrFromEnd_var ret = new DelSubstrFromEnd ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

