////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ExistsInList
//
// реализация встроенной функции генератора _exists_in_list.
// _exists_in_list (идентификатор», «значение») - проверяет наличие в списке с заданным
// идентификатором элемента (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА), возвращает true или false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList.h"

namespace VarFunctionsImpl {

ExistsInList_factory::ExistsInList_factory () {
}

void ExistsInList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ExistsInList_factory::key () const {
	return "_exists_in_list";
}

TemplateFunctions::InternalFunction* ExistsInList_factory::make () {
	ExistsInList_var ret = new ExistsInList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

