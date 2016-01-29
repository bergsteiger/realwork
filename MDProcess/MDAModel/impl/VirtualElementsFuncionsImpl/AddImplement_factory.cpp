////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddImplement_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddImplement
//
// %S%f_add_implement(<GUID операции>) - добавляет операцию заданную GUID'ом в список реализуемых
// операции (%o), при этом операция должна принадлежать одному из реализуемых элементов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddImplement_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddImplement.h"

namespace VirtualElementsFuncionsImpl {

AddImplement_factory::AddImplement_factory () {
}

void AddImplement_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddImplement_factory::key () const {
	return "_add_implement";
}

TemplateFunctions::InternalStereotypeFunction* AddImplement_factory::make () {
	AddImplement_var ret = new AddImplement ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

