////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::EvenComm_i::EventChannelManagerImpl
// ��������� ���������� ������ �������� ��� ��������� EventChannelManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_EVENCOMM_I_EVENTCHANNELMANAGERIMPL_H__
#define __SHARED_CORESRV_EVENCOMM_I_EVENTCHANNELMANAGERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "orbsvcs/orbsvcs/RtecEventChannelAdminC.h"
#include "shared/CoreSrv/EventComm/EventComm.h"
#include "shared/CoreSrv/EventComm/EventCommS.h"

namespace CoreSrv {
namespace EvenComm_i {

class EventChannelManagerImpl; // self forward Var
typedef ::Core::Var<EventChannelManagerImpl> EventChannelManagerImpl_var;
typedef ::Core::Var<const EventChannelManagerImpl> EventChannelManagerImpl_cvar;

class EventChannelManagerImpl_factory;

class EventChannelManagerImpl:
	virtual public POA_CoreSrv::EventComm::EventChannelManager
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (EventChannelManagerImpl)
	friend class EventChannelManagerImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ���� ��������� �������
	typedef std::map < std::string, RtecEventChannelAdmin::EventChannel_var > ChannelMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	EventChannelManagerImpl ();

	virtual ~EventChannelManagerImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� ��� ������ ���� �������
	Core::Mutex m_channel_mutex;

	// ��������� �������, ������� �������� ����������
	ChannelMap m_channels;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from EventComm::EventChannelManager
	// ������ ���������� ����� (���� �� �� ��� ������ �� �����) � ����������� ��� � NameService
	virtual void create_channel (
		const char* channel_name
	) throw (
		CORBA::SystemException
		, EventComm::CreateChannelFailed
	);
}; // class EventChannelManagerImpl

} // namespace EvenComm_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_EVENCOMM_I_EVENTCHANNELMANAGERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
