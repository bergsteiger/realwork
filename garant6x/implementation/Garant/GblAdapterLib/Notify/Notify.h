////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
	, NT_CONSULTATION_RECEIVED // ������� �����
	, NT_CONSULTATION_NOT_SENT // ������������ �� ����������
	, NT_NO_SUBSCRIPTION // ������������ �� ����������, �� �� ������ ���������
	, NT_INTERNET_AVAILABLE // �������� ��� �������� ����� � ��������� ��������� (�� ��� ������ ������� ����������)
	, NT_NEW_CHAT_MESSAGES_RECEIVED // �������� ����� ��������� ��� ����
	, NT_CHAT_CONTACT_ADDED // �������� ����� ������� ��� ����
	, NT_CHAT_CONTACT_REMOVED // ����� ������� ����
	, NT_INTERNET_NOT_AVAILABLE // ��� ������� � ������� ������� ����������
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
// Callback �� ������� ��� ��������� ��������� � ��������
class Listener
	: virtual public ::Core::IObject
{
public:
	virtual void fire (const Notification* notify) const = 0;
};

class NotifyManager;
typedef ::Core::Var<NotifyManager> NotifyManager_var;
typedef ::Core::Var<const NotifyManager> NotifyManager_cvar;
// ��������, �������������� ����� ����������� ����� ��������� � ���������
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
