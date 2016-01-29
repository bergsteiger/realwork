////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUp_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetUp
//
// %S%f_set_up(<имя свойства>,<значение UP>) - устанавливает значение юзер-свойства
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUp_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUp.h"

namespace VirtualElementsFuncionsImpl {

SetUp_factory::SetUp_factory () {
}

void SetUp_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetUp_factory::key () const {
	return "_set_up";
}

TemplateFunctions::InternalStereotypeFunction* SetUp_factory::make () {
	SetUp_var ret = new SetUp ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

