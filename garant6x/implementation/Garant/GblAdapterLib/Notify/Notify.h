////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.h"

namespace GblAdapterLib {

enum NotifyType {
	NT_LONG_OPERATION_START
	, NT_LONG_OPERATION_END
	, NT_MONITORING_UPDATE
	, NT_SHUTDOWN
	, NT_LOGOUT
	, NT_BASE_UPDATE_START
	, NT_BASE_UPDATE_END
	, NT_BASE_UPDATE_FAILED
	, NT_CONSULTATION_RECEIVED // Получен ответ
	, NT_CONSULTATION_NOT_SENT // Консультация не отправлена
	, NT_NO_SUBSCRIPTION // Консультация не отправлена, тк не прошла валидация
	, NT_INTERNET_AVAILABLE // Приходит при успешной связи с удалёнными сервисами (СК или сервер ревизий документов)
	, NT_NEW_CHAT_MESSAGES_RECEIVED // получены новые сообщения для чата
	, NT_CHAT_CONTACT_ADDED // добавлен новый контакт для чата
	, NT_CHAT_CONTACT_REMOVED // удалён контакт чата
	, NT_INTERNET_NOT_AVAILABLE // нет доступа к серверу ревизий документов
};

class Notification;
typedef ::Core::Var<Notification> Notification_var;
typedef ::Core::Var<const Notification> Notification_cvar;
class Notification
	: virtual public ::Core::IObject
{
public:
	virtual NotifyType get_id () const = 0;

	virtual const Variant& get_data () const = 0;
	virtual Variant& get_data () = 0;

	virtual void set_type (NotifyType type) = 0;

	virtual void set_data (Variant* data) = 0;
};

/// factory interface for Notification
class NotificationFactory {
public:
	static Notification* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Listener;
typedef ::Core::Var<Listener> Listener_var;
typedef ::Core::Var<const Listener> Listener_cvar;
// Callback на облочке для получения сообщений с адаптера
class Listener
	: virtual public ::Core::IObject
{
public:
	virtual void fire (const Notification* notify) const = 0;
};

class NotifyManager;
typedef ::Core::Var<NotifyManager> NotifyManager_var;
typedef ::Core::Var<const NotifyManager> NotifyManager_cvar;
// Менеджер, обеспечивающий обмен сообщениями между адаптером и оболочкой
class NotifyManager
	: virtual public ::Core::IObject
{
public:
	virtual void register_listener_for_notify (NotifyType notify_id, Listener* listener) = 0;

	virtual void register_transformer (NotifyType type, DataTransformer* transformer) = 0;

	virtual void listen_for_all () = 0;

	virtual void listen_only_for_me () = 0;

	virtual void stop_listen_me () = 0;
};

/// factory interface for NotifyManager
class NotifyManagerFactory {
public:
	static NotifyManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Notification> {
	typedef GblAdapterLib::NotificationFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::NotifyManager> {
	typedef GblAdapterLib::NotifyManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
