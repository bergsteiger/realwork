////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/UniqueList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::UniqueList
//
// реализация встроенной функции генератора _unique_list.
// _unique_list(«идентификатор») - удаляет дубликаты из списка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/UniqueList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/UniqueList.h"

namespace VarFunctionsImpl {

UniqueList_factory::UniqueList_factory () {
}

void UniqueList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string UniqueList_factory::key () const {
	return "_unique_list";
}

TemplateFunctions::InternalFunction* UniqueList_factory::make () {
	UniqueList_var ret = new UniqueList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

