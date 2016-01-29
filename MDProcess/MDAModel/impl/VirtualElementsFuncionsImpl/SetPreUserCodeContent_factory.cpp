////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetPreUserCodeContent
//
// %S%f_set_pre_uc_content(gen_id, uc_id,content) - добавляет дополнительный код перед юзерсекцией
// заданной uc_id для генератора gen_id
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent.h"

namespace VirtualElementsFuncionsImpl {

SetPreUserCodeContent_factory::SetPreUserCodeContent_factory () {
}

void SetPreUserCodeContent_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetPreUserCodeContent_factory::key () const {
	return "_set_pre_uc_content";
}

TemplateFunctions::InternalStereotypeFunction* SetPreUserCodeContent_factory::make () {
	SetPreUserCodeContent_var ret = new SetPreUserCodeContent ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

