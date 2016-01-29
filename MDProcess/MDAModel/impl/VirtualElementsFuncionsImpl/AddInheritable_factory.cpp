////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddInheritable
//
// %S%f_add_inheritable(<ГУИД реального элемента или просто имя>) - аналогично _add_realized, но
// добавлет элемент в список наследуемых
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable.h"

namespace VirtualElementsFuncionsImpl {

AddInheritable_factory::AddInheritable_factory () {
}

void AddInheritable_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddInheritable_factory::key () const {
	return "_add_inheritable";
}

TemplateFunctions::InternalStereotypeFunction* AddInheritable_factory::make () {
	AddInheritable_var ret = new AddInheritable ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

