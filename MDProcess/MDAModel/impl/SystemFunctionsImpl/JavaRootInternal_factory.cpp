////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaRootInternal_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::JavaRootInternal
//
// Возвращает корневую директорию для java исходников
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaRootInternal_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaRootInternal.h"

namespace SystemFunctionsImpl {

JavaRootInternal_factory::JavaRootInternal_factory () {
}

void JavaRootInternal_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string JavaRootInternal_factory::key () const {
	return "_java_root_internal";
}

TemplateFunctions::InternalFunction* JavaRootInternal_factory::make () {
	JavaRootInternal_var ret = new JavaRootInternal ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

