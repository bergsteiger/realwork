////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetOverloadSelectType_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetOverloadSelectType
//
// %S%f_set_overload_select_type(all|include|exclude) - устанавливает тип включения для
// переопределяемых операций класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetOverloadSelectType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetOverloadSelectType.h"

namespace VirtualElementsFuncionsImpl {

SetOverloadSelectType_factory::SetOverloadSelectType_factory () {
}

void SetOverloadSelectType_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetOverloadSelectType_factory::key () const {
	return "_set_overload_select_type";
}

TemplateFunctions::InternalStereotypeFunction* SetOverloadSelectType_factory::make () {
	SetOverloadSelectType_var ret = new SetOverloadSelectType ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

