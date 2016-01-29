////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddDependency
//
// 1. %S%f_add_dependency(<UID нового элемента>,<цель связи>,<стереотип>,<имя связи>,<имя
// переменной>) - создает новую связь между текущим и элементом и целью связи, цель может быть
// задана УИДом реального элемента либо просто именем - данный формат используется для простановки
// связи между классами
// 2. %S%f_add_dependency(<цель связи>) - создает новую связь между текущим и элементом и целью
// связи, цель может быть задана УИДом реального элемента либо просто именем - данный формат
// используется для простановки связи между папками.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency.h"

namespace VirtualElementsFuncionsImpl {

AddDependency_factory::AddDependency_factory () {
}

void AddDependency_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	AddDependencyLocalFactoryManager::register_factory (this, priority);
}

const std::string AddDependency_factory::key () const {
	return "_add_dependency";
}

AddDependencyLocal* AddDependency_factory::get () {
	AddDependency_var ret = new AddDependency (AddDependency::FactoriesID::Get());
	return ret._retn ();
}

TemplateFunctions::InternalStereotypeFunction* AddDependency_factory::make () {
	AddDependency_var ret = new AddDependency (AddDependency::FactoriesID::Make());
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

