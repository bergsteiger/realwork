////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOverride
//
// %S%f_add_override(<GUID операции>) - добавляет операцию заданную GUID'ом в список
// переопределяемых операции (%O), при этом операция должна принадлежать одному из базовых
// элементов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride.h"

namespace VirtualElementsFuncionsImpl {

AddOverride_factory::AddOverride_factory () {
}

void AddOverride_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddOverride_factory::key () const {
	return "_add_override";
}

TemplateFunctions::InternalStereotypeFunction* AddOverride_factory::make () {
	AddOverride_var ret = new AddOverride ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

