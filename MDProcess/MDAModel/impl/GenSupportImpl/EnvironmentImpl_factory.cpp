////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::EnvironmentImpl
//
// реализация интерфейса параметров генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl.h"

namespace GenSupportImpl {

EnvironmentImpl_factory::EnvironmentImpl_factory () {
}

void EnvironmentImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GenSupport::EnvironmentFactoryManager::register_factory (this, priority);
}

const char* EnvironmentImpl_factory::key () const {
	return "EnvironmentImpl";
}

GenSupport::Environment* EnvironmentImpl_factory::get () {
	EnvironmentImpl_var ret = new EnvironmentImpl ();
	return ret._retn ();
}

} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

