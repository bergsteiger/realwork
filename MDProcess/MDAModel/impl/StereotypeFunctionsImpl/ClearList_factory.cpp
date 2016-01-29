////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::ClearList
//
// %S%f_clear_list(LIST_ID) - очищает локальный список с идентификатором LIST_ID, если с %S не было
// связано переменной типа список с таким идентфиикатором, список создается и связывается
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList.h"

namespace StereotypeFunctionsImpl {

ClearList_factory::ClearList_factory () {
}

void ClearList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string ClearList_factory::key () const {
	return "_clear_list";
}

TemplateFunctions::InternalStereotypeFunction* ClearList_factory::make () {
	ClearList_var ret = new ClearList ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

