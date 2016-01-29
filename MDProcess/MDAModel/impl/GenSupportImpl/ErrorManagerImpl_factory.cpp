////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ErrorManagerImpl
//
// реалиазция менеджера ошибок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl.h"

namespace GenSupportImpl {

ErrorManagerImpl_factory::ErrorManagerImpl_factory () {
}

void ErrorManagerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GenSupport::ErrorManagerFactoryManager::register_factory (this, priority);
}

const char* ErrorManagerImpl_factory::key () const {
	return "ErrorManagerImpl";
}

GenSupport::ErrorManager* ErrorManagerImpl_factory::get () {
	ErrorManagerImpl_var ret = new ErrorManagerImpl ();
	return ret._retn ();
}

} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

