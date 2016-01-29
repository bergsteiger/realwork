////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTargetStereotype
//
// %S%f_set_target_stereotype(agr|lnk|ref) - устанавливает target_stereotyp для атрибута или
// операции. Применима ТОЛЬКО для вирутальных элементов. Если устанавливаемый target_stereotyp не
// указан как разрешенный в шаблоне - бросает исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype.h"

namespace VirtualElementsFuncionsImpl {

SetTargetStereotype_factory::SetTargetStereotype_factory () {
}

void SetTargetStereotype_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetTargetStereotype_factory::key () const {
	return "_set_target_stereotype";
}

TemplateFunctions::InternalStereotypeFunction* SetTargetStereotype_factory::make () {
	SetTargetStereotype_var ret = new SetTargetStereotype ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

