////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/NotifyService_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GSI::NotifyService_i
//
// ���������� ������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ���������� ��� ���������� � ������ �������� ������� ������ �����������.
// �T_CLIENT - ���������� ����������, ���������� RTE ������ �� ������� � ������ ������ � ����
// �����������.
// CT_SERVER - ��������� ����������, ������ ������ ��� ������� ���������� RTE.
// CT_DESKTOP - "��� � �����", � ������ � ������� � ����� ������� (���� ����� �� ���������� ��
// CT_SERVER)
enum ConfigurationType {
	CT_CLIENT // ������������� ��� ������������� ������� � ���������� ������������
	, CT_SERVER // ������������� ��� ������������� ������� � ��������� ������������
	, CT_DESKTOP // ������������� ��� ������������� ������� � ��������� ������������
};

// ��� �������, ������������ ����������������� �������� ��� �������� ����������� �����
typedef long EventType;

class ManagerLocal;
typedef ::Core::Var<ManagerLocal> ManagerLocal_var;
typedef ::Core::Var<const ManagerLocal> ManagerLocal_cvar;
// ���������� ���������� ���������
class ManagerLocal
	: virtual public NotifyService::Manager
{
public:
	// ���������� ������ ���������� �� ������ ���������
	virtual void unregister (const ProxyConsumer* proxy) = 0;

	// ������� ������� ���������
	virtual void send_common_notify (
		const CORBA::Any& notify
	) /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/ = 0;

	// ������� ������������ ���������
	virtual void send_personal_notify (
		const CORBA::Any& notify
		, NotifyService::PersonalID prs_id
	) /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/ = 0;

	// ����������� ������ ���������� �� ����� ������������ ���������
	virtual ProxyConsumer* subscribe_for_personal (const Consumer_i* consumer, NotifyService::PersonalID prs_id) = 0;

	// ����������� ������ ���������� �� ��������� ��� ����
	virtual ProxyConsumer* subscribe_for_common (const Consumer_i* consumer) = 0;
};

/// factory interface for ManagerLocal
class ManagerLocalFactory {
public:
	// ��������� �����
	static ManagerLocal& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// �������� ��� ���� �������, ����������� �������� �������� ��������� ���� ��� ������ �����������
// �����
static const EventType PN_NOTIFY_TO_ALL = ACE_ES_EVENT_UNDEFINED+1; // ��� ���������, ���������� ��� ������ ��������� ������ ���� ��������� ��� - ����� ��� �������, ������������ ���������
static const EventType PN_NOTIFY_TO_ONE = ACE_ES_EVENT_UNDEFINED+2; // ������� ��������� ������ ���������� � ��������� ��� ������� ID ����������

} //namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

