////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAppliedGen_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetAppliedGen
//
// %S%f_set_applied_gen(<имя генератора>,<true/false>) - устанавливает или снимает галку Applied
// Generators на элементе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAppliedGen_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAppliedGen.h"

namespace VirtualElementsFuncionsImpl {

SetAppliedGen_factory::SetAppliedGen_factory () {
}

void SetAppliedGen_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetAppliedGen_factory::key () const {
	return "_set_applied_gen";
}

TemplateFunctions::InternalStereotypeFunction* SetAppliedGen_factory::make () {
	SetAppliedGen_var ret = new SetAppliedGen ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

