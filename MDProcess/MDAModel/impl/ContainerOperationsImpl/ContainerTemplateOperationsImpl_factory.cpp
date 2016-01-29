////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::ContainerTemplateOperationsImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl_factory.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl.h"

namespace ContainerOperationsImpl {

ContainerTemplateOperationsImpl_factory::ContainerTemplateOperationsImpl_factory () {
}

void ContainerTemplateOperationsImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ContainerOperations::ContainerTemplateOperationsFactoryManager::register_factory (this, priority);
}

const char* ContainerTemplateOperationsImpl_factory::key () const {
	return "ContainerTemplateOperationsImpl";
}

ContainerOperations::ContainerTemplateOperations* ContainerTemplateOperationsImpl_factory::get () {
	ContainerTemplateOperationsImpl_var ret = new ContainerTemplateOperationsImpl ();
	return ret._retn ();
}

} // namespace ContainerOperationsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

