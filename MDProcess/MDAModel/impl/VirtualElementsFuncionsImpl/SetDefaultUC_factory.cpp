////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDefaultUC
//
// %f_set_default_uc(<генератор>,<Идентификатор юзер-секции>,<код юзер-секции>) - заменяет код юзер-
// секции, который генерится шаблоном при первой генерации (или при выставленной галке "rewrite
// user code")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC.h"

namespace VirtualElementsFuncionsImpl {

SetDefaultUC_factory::SetDefaultUC_factory () {
}

void SetDefaultUC_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetDefaultUC_factory::key () const {
	return "_set_default_uc";
}

TemplateFunctions::InternalStereotypeFunction* SetDefaultUC_factory::make () {
	SetDefaultUC_var ret = new SetDefaultUC ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

