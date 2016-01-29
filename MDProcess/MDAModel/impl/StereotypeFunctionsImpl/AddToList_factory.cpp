////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/AddToList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::AddToList
//
// %S%f_add_to_list («значение») - добавляет в список c заданным идентификатором элемент (может
// быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/AddToList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/AddToList.h"

namespace StereotypeFunctionsImpl {

AddToList_factory::AddToList_factory () {
}

void AddToList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddToList_factory::key () const {
	return "_add_to_list";
}

TemplateFunctions::InternalStereotypeFunction* AddToList_factory::make () {
	AddToList_var ret = new AddToList ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

