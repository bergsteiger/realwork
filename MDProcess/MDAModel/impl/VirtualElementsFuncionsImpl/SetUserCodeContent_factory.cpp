////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetUserCodeContent
//
// %S%f_set_uc_content(gen_id, uc_id,content) - добавляет содержимое юзерсекции для генератора
// gen_id
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent.h"

namespace VirtualElementsFuncionsImpl {

SetUserCodeContent_factory::SetUserCodeContent_factory () {
}

void SetUserCodeContent_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetUserCodeContent_factory::key () const {
	return "_set_uc_content";
}

TemplateFunctions::InternalStereotypeFunction* SetUserCodeContent_factory::make () {
	SetUserCodeContent_var ret = new SetUserCodeContent ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

