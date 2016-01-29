////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/Manager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GSI::NotifyService_i::Manager_i
// Заголовок реализации класса серванта для интерфеса ManagerLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_MANAGER_I_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_MANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/Core/data/unsorted_containers.h"
#include "shared/GSI/NotifyService/NotifyService.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "shared/GSI/impl/NotifyService_i/ProxyConsumer.h"
#include "shared/GSI/impl/NotifyService_i/RTEventSupplier.h"
#include "orbsvcs/orbsvcs/RtecEventChannelAdminC.h"
#include "shared/GSI/impl/NotifyService_i/RTEventListener.h"
#include "tao/ORB_Core.h"
#include "tao/PortableServer/PortableServerC.h"

//#UC START# *44A13F9E035B_CUSTOM_INCLUDES*
//#UC END# *44A13F9E035B_CUSTOM_INCLUDES*

namespace GSI {
namespace NotifyService_i {

class Manager_i; // self forward Var
typedef ::Core::Var<Manager_i> Manager_i_var;
typedef ::Core::Var<const Manager_i> Manager_i_cvar;

class Manager_i_factory;

class Manager_i:
	virtual public ManagerLocal
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Manager_i)
	friend class Manager_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	struct EventListenerKey;
	// нужно для поиска по мапе, т.к. ключ в ней структура
	struct EventListenerLess {
		bool operator () (const EventListenerKey& x, const EventListenerKey& y) const;

	};

	// характерезует получателя сообщений парой: тип подписки (на сообщения для всех или на
	// персональные)  и идентификатором юзера
	struct EventListenerKey {
		// уникальный идентификатор получателя
		NotifyService::PersonalID id;
		// тип сообщения
		EventType et;
	};

	// мапа листенеров, где каждому листенеру ставится в соответсвие корбовский листенер, причем
	// разным листенерам может быть поставлен один и тот же корбовский - это нужно что бы не создавать
	// на каждого получателя широковещательных событий корбовского листенера.
	typedef std::map < const EventListenerKey, RTEventListener::Box, EventListenerLess > EventListenerMap;

	// Хранит список прокси консьюмеров. Мапа нужна для быстрого поиск данных о прокси консьюмере.
	typedef boost::unordered_map <ProxyConsumer*
		, EventListenerKey> ProxyConsumersMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Manager_i ();

	virtual ~Manager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	RtecEventChannelAdmin::ConsumerAdmin_var m_consumer_adm;

	ProxyConsumersMap m_consumers_set;

	RtecEventChannelAdmin::EventChannel_var m_event_channel;

	EventListenerMap m_event_listeners;

	CORBA::ORB_var m_orb;

	PortableServer::POA_var m_poa;

	ConfigurationType m_prid;

	RTEventSupplier::Box m_rte_supplier;

	Core::Mutex m_subscribe_event_mutex;

	RtecEventChannelAdmin::SupplierAdmin_var m_supplier_adm;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NotifyService::Manager
	// остановка сервиса
	virtual void done () /*throw (NotifyService::InternalError, NotifyService::NotInitialized)*/;

	// implemented method from NotifyService::Manager
	// запуск сервиса
	virtual void init () /*throw (NotifyService::InternalError, NotifyService::NotInitialized)*/;

	// implemented method from ManagerLocal
	// послать обычное сообщение
	virtual void send_common_notify (
		const CORBA::Any& notify
	) /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/;

	// implemented method from ManagerLocal
	// послать персональное сообщение
	virtual void send_personal_notify (
		const CORBA::Any& notify
		, NotifyService::PersonalID prs_id
	) /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/;

	// implemented method from ManagerLocal
	// подписываем прокси консьюмера на сообщения для всех
	virtual ProxyConsumer* subscribe_for_common (const Consumer_i* consumer);

	// implemented method from ManagerLocal
	// подписываем прокси консьюмера на прием персональных сообщений
	virtual ProxyConsumer* subscribe_for_personal (const Consumer_i* consumer, NotifyService::PersonalID prs_id);

	// implemented method from ManagerLocal
	// отписываем прокси консьюмера от приема сообщений
	virtual void unregister (const ProxyConsumer* proxy);

//#UC START# *44A13F9E035B*
//#UC END# *44A13F9E035B*
}; // class Manager_i

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_MANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
