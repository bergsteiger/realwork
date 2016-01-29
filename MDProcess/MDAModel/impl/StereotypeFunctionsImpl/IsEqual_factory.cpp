////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/IsEqual_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::IsEqual
//
// %S%f_is_equal (дампер списка) - сравниваем списки, возвращает true или false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/IsEqual_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/IsEqual.h"

namespace StereotypeFunctionsImpl {

IsEqual_factory::IsEqual_factory () {
}

void IsEqual_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string IsEqual_factory::key () const {
	return "_is_equal";
}

TemplateFunctions::InternalStereotypeFunction* IsEqual_factory::make () {
	IsEqual_var ret = new IsEqual ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

