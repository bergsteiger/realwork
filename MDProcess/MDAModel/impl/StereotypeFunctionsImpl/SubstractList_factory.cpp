////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SubstractList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SubstractList
//
// %S%f_substract_list(элемент являющийся списком) - вычитание из списка другого списка:
// {code}
// %f_clear_list(LIST1)
// %f_clear_list(LIST2)
// ...
// %{LIST1}%f_substract_list({LIST2})
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SubstractList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SubstractList.h"

namespace StereotypeFunctionsImpl {

SubstractList_factory::SubstractList_factory () {
}

void SubstractList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SubstractList_factory::key () const {
	return "_substract_list";
}

TemplateFunctions::InternalStereotypeFunction* SubstractList_factory::make () {
	SubstractList_var ret = new SubstractList ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

