////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SortList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SortList
//
// %S%f_sort_list(«тип сортировки») - то же, что и глобальная функция сортировки _sort_lsit
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SortList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SortList.h"

namespace StereotypeFunctionsImpl {

SortList_factory::SortList_factory () {
}

void SortList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SortList_factory::key () const {
	return "_sort_list";
}

TemplateFunctions::InternalStereotypeFunction* SortList_factory::make () {
	SortList_var ret = new SortList ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

