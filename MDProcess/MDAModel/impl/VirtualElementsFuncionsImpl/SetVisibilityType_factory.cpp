////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetVisibilityType
//
// %S%f_set_visability_type(PublicAccess|ProtectedAccess|PrivateAccess|ImplementationAccess) -
// станавливает тип видиости элемента. Применима ТОЛЬКО для виртуальных элементов. Если тип
// видимости не указан в списке разрешённых шаблоном - выбрасывается исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType.h"

namespace VirtualElementsFuncionsImpl {

SetVisibilityType_factory::SetVisibilityType_factory () {
}

void SetVisibilityType_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetVisibilityType_factory::key () const {
	return "_set_visibility_type";
}

TemplateFunctions::InternalStereotypeFunction* SetVisibilityType_factory::make () {
	SetVisibilityType_var ret = new SetVisibilityType ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

