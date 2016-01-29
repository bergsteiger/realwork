////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetImplementSelectType
//
// %S%f_set_implement_select_type(all|include|exclude) - устанавливает тип включения для
// реализуемых операций класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType.h"

namespace VirtualElementsFuncionsImpl {

SetImplementSelectType_factory::SetImplementSelectType_factory () {
}

void SetImplementSelectType_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetImplementSelectType_factory::key () const {
	return "_set_implement_select_type";
}

TemplateFunctions::InternalStereotypeFunction* SetImplementSelectType_factory::make () {
	SetImplementSelectType_var ret = new SetImplementSelectType ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

