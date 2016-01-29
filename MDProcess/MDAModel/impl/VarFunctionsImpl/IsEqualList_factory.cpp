////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/IsEqualList_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::IsEqualList
//
// Функция сравнения списков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEqualList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEqualList.h"

namespace VarFunctionsImpl {

IsEqualList_factory::IsEqualList_factory () {
}

void IsEqualList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string IsEqualList_factory::key () const {
	return "_is_equal_list";
}

TemplateFunctions::InternalFunction* IsEqualList_factory::make () {
	IsEqualList_var ret = new IsEqualList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

