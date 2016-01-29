////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/NotifyService_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GSI::NotifyService_i
//
// Реализация сервиса нотификаций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/NotifyService/NotifyService.h"
#include "orbsvcs/orbsvcs/RtecEventCommC.h"
#include "orbsvcs/orbsvcs/RtecEventChannelAdminC.h"
#include "orbsvcs/orbsvcs/Event_Utilities.h"
#include "tao/ORB_Core.h"
#include "tao/PortableServer/PortableServerC.h"

//forward decl
namespace GSI {
namespace NotifyService_i {
	class ProxyConsumer;
} // namespace NotifyService_i
} // namespace GSI

namespace GSI {
namespace NotifyService_i {
	class Consumer_i;
} // namespace NotifyService_i
} // namespace GSI


namespace GSI {
namespace NotifyService_i {

// Определяет тип приложения в рамках которого запущен сервис нотификаций.
// СT_CLIENT - клиентское приложение, корбовский RTE поднят на сервере и сервис должен к нему
// подключится.
// CT_SERVER - серверное приложение, сервис должен сам поднять корбовский RTE.
// CT_DESKTOP - "два в одном", и сервер и клиенты в одном флаконе (пока ничем не отличается от
// CT_SERVER)
enum ConfigurationType {
	CT_CLIENT // идентификатор для инициализации сервиса в клиентской конфигурации
	, CT_SERVER // идентификатор для инициализации сервиса в серверной конфигурации
	, CT_DESKTOP // идентификатор для инициализации сервиса в дектопной конфигурации
};

// тип события, определяющий широковещательную рассылку или рассылку конкретному юзеру
typedef long EventType;

class ManagerLocal;
typedef ::Core::Var<ManagerLocal> ManagerLocal_var;
typedef ::Core::Var<const ManagerLocal> ManagerLocal_cvar;
// расширение интерфейса менеджера
class ManagerLocal
	: virtual public NotifyService::Manager
{
public:
	// отписываем прокси консьюмера от приема сообщений
	virtual void unregister (const ProxyConsumer* proxy) = 0;

	// послать обычное сообщение
	virtual void send_common_notify (
		const CORBA::Any& notify
	) /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/ = 0;

	// послать персональное сообщение
	virtual void send_personal_notify (
		const CORBA::Any& notify
		, NotifyService::PersonalID prs_id
	) /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/ = 0;

	// подписываем прокси консьюмера на прием персональных сообщений
	virtual ProxyConsumer* subscribe_for_personal (const Consumer_i* consumer, NotifyService::PersonalID prs_id) = 0;

	// подписываем прокси консьюмера на сообщения для всех
	virtual ProxyConsumer* subscribe_for_common (const Consumer_i* consumer) = 0;
};

/// factory interface for ManagerLocal
class ManagerLocalFactory {
public:
	// фабричный метод
	static ManagerLocal& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// вводятся два типа событий, позволяющий отличать рассылку сообщения всем или только конкретному
// юзеру
static const EventType PN_NOTIFY_TO_ALL = ACE_ES_EVENT_UNDEFINED+1; // тип сообщения, означающий что данное сообщение должно быть разослано все - нужно для фильтра, рассылающего сообщения
static const EventType PN_NOTIFY_TO_ONE = ACE_ES_EVENT_UNDEFINED+2; // послать сообщение только получателю с указанным при посылке ID получателя

} //namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

