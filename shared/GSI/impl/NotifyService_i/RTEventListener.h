////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/RTEventListener.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::RTEventListener
//
// ��������� �� ����������� ���������� ���������. ��� ��������� �������� ������ ��������� �����
// push_event.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_RTEVENTLISTENER_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_RTEVENTLISTENER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/data/unsorted_containers.h"
#include "shared/GSI/NotifyService/NotifyService.h"
#include "shared/GSI/impl/NotifyService_i/ProxyConsumer.h"
#include "orbsvcs/orbsvcs/RtecEventCommC.h"
#include "orbsvcs/orbsvcs/RtecEventChannelAdminC.h"
#include "tao/PortableServer/PortableServerC.h"
#include "orbsvcs/orbsvcs/RtecEventCommS.h"

//#UC START# *44B375D50242_CUSTOM_INCLUDES*
#include "orbsvcs/orbsvcs/Event_Utilities.h"
//#UC END# *44B375D50242_CUSTOM_INCLUDES*

namespace GSI {
namespace NotifyService_i {

// ��������� �� ����������� ���������� ���������. ��� ��������� �������� ������ ��������� �����
// push_event.
class RTEventListener;
typedef Core::Var<RTEventListener> RTEventListener_var;
typedef Core::Var<const RTEventListener> RTEventListener_cvar;

class RTEventListener :
	virtual public POA_RtecEventComm::PushConsumer
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (RTEventListener)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ���� ���������� ��������, ������ �������� ��� ����������������� ���������, � ����� ������ �����
	// ��������� �����������
	typedef boost::unordered_set <ProxyConsumer*> ConsumersSet;

	// ����� ��� ����������� ��������������� ����������� �������
	struct BoxDeallocator {
		static void destroy (RTEventListener* content) {
		//#UC START# *44B3758A0148*
		content->deactivate ();
		content->_remove_ref ();
	//#UC END# *44B3758A0148*
		}
	};
	typedef ::Core::Box<RTEventListener, BoxDeallocator, true> Box;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ����������� ��� ����������� ��������� ��� �������� ��������� ��� ����
	RTEventListener (PortableServer::POA* poa, RtecEventChannelAdmin::ConsumerAdmin* consumer_admin);

	// ����������� ��� ����������� ��������� ��� �������� ������������ ���������
	RTEventListener (
		PortableServer::POA* poa
		, RtecEventChannelAdmin::ConsumerAdmin* consumer_admin
		, NotifyService::PersonalID id
	);

public:
	virtual ~RTEventListener ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ������ ����������
	virtual void add_consumer (ProxyConsumer* pc);

	// ������� ������ ����������
	virtual unsigned long remove_consumer (const ProxyConsumer* pc);

private:
	// ����� ��������� push � ��������� ������, ��� �� �� ������� ��� BiDir-�
	/*oneway*/ Core::ThreadHandle push_i (const RtecEventComm::EventSet& events);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ConsumersSet m_consumers;

	PortableServer::POA* m_poa;

	RtecEventChannelAdmin::ProxyPushSupplier_var m_proxy_supplier;
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_push_i_ (void* arg);

protected:
	virtual void push_i_ (const RtecEventComm::EventSet& events);


//#UC START# *44B375D50242*
protected:
	void disconnect_push_consumer () throw (CORBA::SystemException) {
		LOG_D (("RTEventListener::disconnect_push_consumer (): ok [push supplier call]"));
	}

private:
	void push (const RtecEventComm::EventSet& events) throw (CORBA::SystemException);
	void init (RtecEventChannelAdmin::ConsumerAdmin_ptr consumer_admin, ACE_ConsumerQOS_Factory& qos);
	void deactivate ();

private:
	Core::RWMutex m_consumer_mutex;
//#UC END# *44B375D50242*
}; // class RTEventListener

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_RTEVENTLISTENER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

