////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::ArchiEventsListenerImpl
//
// ArchiEventsListenerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl_factory.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl.h"
#include "MDProcess/ArchiGate/LibHome.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

ArchiEventsListenerImpl_factory::ArchiEventsListenerImpl_factory () {
}

void ArchiEventsListenerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocCardRemote::ArchiEventsListenerFactoryManager::register_factory (this, priority);
}

const char* ArchiEventsListenerImpl_factory::key () const {
	return "ArchiEventsListenerImpl";
}

DocCardRemote::ArchiEventsListener* ArchiEventsListenerImpl_factory::make () {
	ArchiEventsListenerImpl_var ret = new ArchiEventsListenerImpl ();
	return ret->_this ();
}

} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

