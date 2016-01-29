////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::RemoveFromList
//
// реализация встроенной функции генератора _remove_from_list.
// _remove_from_list (идентификатор», «значение») - удаляет из списка c заданным идентификатором
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList.h"

namespace VarFunctionsImpl {

RemoveFromList_factory::RemoveFromList_factory () {
}

void RemoveFromList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string RemoveFromList_factory::key () const {
	return "_remove_from_list";
}

TemplateFunctions::InternalFunction* RemoveFromList_factory::make () {
	RemoveFromList_var ret = new RemoveFromList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

