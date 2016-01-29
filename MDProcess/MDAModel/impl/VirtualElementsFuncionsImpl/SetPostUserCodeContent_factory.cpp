////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPostUserCodeContent_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetPostUserCodeContent
//
// %S%f_set_post_uc_content(gen_id, uc_id,content) - добавляет дополнительный код  после юзерсекции
// заданной uc_id для генератора gen_id
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPostUserCodeContent_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPostUserCodeContent.h"

namespace VirtualElementsFuncionsImpl {

SetPostUserCodeContent_factory::SetPostUserCodeContent_factory () {
}

void SetPostUserCodeContent_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetPostUserCodeContent_factory::key () const {
	return "_set_post_uc_content";
}

TemplateFunctions::InternalStereotypeFunction* SetPostUserCodeContent_factory::make () {
	SetPostUserCodeContent_var ret = new SetPostUserCodeContent ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

