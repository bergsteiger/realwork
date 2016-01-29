////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::EvenComm_i::EventChannelManagerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl_factory.h"
#include "shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl.h"
#include "shared/CoreSrv/LibHome.h"

namespace CoreSrv {
namespace EvenComm_i {

EventChannelManagerImpl_factory::EventChannelManagerImpl_factory () {
}

void EventChannelManagerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	EventComm::EventChannelManagerFactoryManager::register_factory (this, priority);
}

const char* EventChannelManagerImpl_factory::key () const {
	return "EventChannelManagerImpl";
}

EventComm::EventChannelManager* EventChannelManagerImpl_factory::get () {
	EventChannelManagerImpl_var ret = new EventChannelManagerImpl ();
	return ret->_this ();
}

} // namespace EvenComm_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

