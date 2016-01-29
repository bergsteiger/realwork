////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::EvenComm_i::EventChannelManagerImpl
// Заголовк реализации фабрик интерфеса EventChannelManager для серванта EventChannelManagerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_EVENCOMM_I_EVENTCHANNELMANAGERIMPL_FCTR_H__
#define __SHARED_CORESRV_EVENCOMM_I_EVENTCHANNELMANAGERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/EventComm/EventCommFactories.h"

namespace CoreSrv {
namespace EvenComm_i {

/// Interface-factory implementation for EventChannelManagerImpl
class EventChannelManagerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public EventComm::EventChannelManagerAbstractFactory
{
public:
	EventChannelManagerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	EventComm::EventChannelManager* get ();

};

typedef ::Core::Var<EventChannelManagerImpl_factory> EventChannelManagerImpl_factory_var;

} // namespace EvenComm_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_EVENCOMM_I_EVENTCHANNELMANAGERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

