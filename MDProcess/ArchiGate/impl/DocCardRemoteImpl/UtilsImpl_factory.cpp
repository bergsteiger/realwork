////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::UtilsImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl.h"
#include "MDProcess/ArchiGate/LibHome.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

UtilsImpl_factory::UtilsImpl_factory () {
}

void UtilsImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocCardRemote::UtilsFactoryManager::register_factory (this, priority);
}

const char* UtilsImpl_factory::key () const {
	return "UtilsImpl";
}

DocCardRemote::Utils* UtilsImpl_factory::make () {
	UtilsImpl_var ret = new UtilsImpl ();
	return ret->_this ();
}

} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

