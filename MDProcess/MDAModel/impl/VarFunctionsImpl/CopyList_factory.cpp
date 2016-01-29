////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CopyList
//
// реализация встроенной функции генератора _copy_list
// _copy_list(«идентификатор списка1», «идентификатор списка2») - копирует список1 в список2.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList.h"

namespace VarFunctionsImpl {

CopyList_factory::CopyList_factory () {
}

void CopyList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string CopyList_factory::key () const {
	return "_copy_list";
}

TemplateFunctions::InternalFunction* CopyList_factory::make () {
	CopyList_var ret = new CopyList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

