////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/Consumer_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::Consumer_i
//
// �������� ���������� ���������, �� ���� ���������� ����� ����������
// ����� ����������� � ����� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_CONSUMER_I_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_CONSUMER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/NotifyService/NotifyService.h"
#include "shared/GSI/impl/NotifyService_i/ProxyConsumer.h"

// forward decls for defined friends
namespace GSI {
namespace NotifyService_i {
	class ProxyConsumer;
} // namespace NotifyService_i
} // namespace GSI


namespace GSI {
namespace NotifyService_i {

// �������� ���������� ���������, �� ���� ���������� ����� ����������
// ����� ����������� � ����� �������
class Consumer_i;
typedef Core::Var<Consumer_i> Consumer_i_var;
typedef Core::Var<const Consumer_i> Consumer_i_cvar;

class Consumer_i :
	virtual public NotifyService::Consumer
	, virtual public Core::RefCountObjectBase
{
	friend class ProxyConsumer; // defined friend
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~Consumer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������, �� ������� ��������� ��������� ������� ��������� ��� ����
	virtual void start_listen_common ();

	// �������, �� ������� ��������� ��������� ������� ������������
	virtual void start_listen_personal (NotifyService::PersonalID prs_id);

	// ������� �� ������� ���������� ���������� ������� ��������� ��� ����
	virtual void stop_listen_common ();

	// ������� �� ������� ���������� ���������� ������� ������������ ���������
	virtual void stop_listen_personal ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ProxyConsumer_var m_proxy_for_common_notifies;

	ProxyConsumer_var m_proxy_for_personal_notifies;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NotifyService::Consumer
	// ��� ��������� ��������� ���������� ����������� ���� �����.
	virtual void fire_event (const CORBA::Any& event);
}; // class Consumer_i

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_CONSUMER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

