////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetStereotype
//
// %f_set_stereotype(<стереотип>) - устанавливает стереотип элементу. Применима только к
// виртуальным элементам, для реальных элементов будет выброшено исключение. Если элемент не может
// иметь заданный стереотип - выбрасывается исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype.h"

namespace VirtualElementsFuncionsImpl {

SetStereotype_factory::SetStereotype_factory () {
}

void SetStereotype_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetStereotype_factory::key () const {
	return "_set_stereotype";
}

TemplateFunctions::InternalStereotypeFunction* SetStereotype_factory::make () {
	SetStereotype_var ret = new SetStereotype ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

